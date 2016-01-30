#include "gamehsp.h"

#include "../../hsp3/hsp3config.h"
#include "../supio.h"
#include "../sysreq.h"

// Default sprite shaders
#define SPRITE_VSH "res/shaders/sprite.vert"
#define SPRITE_FSH "res/shaders/sprite.frag"

#define SPRITECOL_VSH "res/shaders/spritecol.vert"
#define SPRITECOL_FSH "res/shaders/spritecol.frag"

enum {
CLSMODE_NONE = 0,
CLSMODE_SOLID,
CLSMODE_TEXTURE,
CLSMODE_BLUR,
CLSMODE_MAX,
};

extern bool hasParameter( Material* material, const char* name );

/*------------------------------------------------------------*/
/*
		gameplay Node Obj
*/
/*------------------------------------------------------------*/

gpobj::gpobj()
{
	// コンストラクタ
	_flag = GPOBJ_FLAG_NONE;
}

gpobj::~gpobj()
{
}

void gpobj::reset( int id )
{
	int i;
	_mode = 0;
	_mark = 0;
	_shape = GPOBJ_SHAPE_NONE;
	_spr = NULL;
	_phy = NULL;
	_node = NULL;
	_model = NULL;
	_camera = NULL;
	_light = NULL;
	_flag = GPOBJ_FLAG_ENTRY;
	_id = id;
	_mygroup = 0;
	_colgroup = 0;
	_transparent = 255;

	_usegpmat = -1;
	_colilog = -1;

	_prm_modalpha = NULL;

	for(i=0;i<GPOBJ_USERVEC_MAX;i++) {
		_vec[i].set( Vector4::zero() );
	}

}


bool gpobj::isVisible( void )
{
	//	表示可能か調べる
	//
	if ( _flag == 0 ) return false;
	if ( _mode & GPOBJ_MODE_HIDE ) {		// 非表示設定
		return false;
	}
	return true;
}


bool gpobj::isVisible( bool lateflag )
{
	//	表示可能か調べる
	//  ( GPOBJ_MODE_LATE指定時か、半透明時は手前の優先度として認識される )
	//	( lateflag : true=手前の描画優先度 )
	//
	bool curflag;
	if ( _flag == 0 ) return false;

	if ( _mode & GPOBJ_MODE_HIDE ) {		// 非表示設定
		return false;
	}
	if ( _transparent <= 0 ) {				// 完全な透明
		return false;
	}
	if ( _mode & GPOBJ_MODE_LATE ) {
		curflag = true;						// 手前を強制
	} else {
		if ( _transparent >= 255 ) {
			curflag = false;				// 通常の優先順位
		} else {
			curflag = true;					// 透明を含む
		}
	}

	return ( curflag == lateflag );
}


float gpobj::getAlphaRate( void )
{
	// Alpha値を取得する
	// ( _transparent値を0.0～1.0に変換する)
	if ( _transparent >= 255 ) return 1.0f;
	if ( _transparent <= 0 ) return 0.0f;
	return ( 1.0f / 255.0f ) * (float)_transparent;
}


void gpobj::updateParameter( Material *mat )
{
	//	マテリアル設定後処理を行なう
	//	パラメーターのポインタ設定など、モデル確定後にgpobjで必要な処理を行なう
	//
	_prm_modalpha = NULL;
	if ( _flag == 0 ) return;
	if ( mat ) {
		if ( hasParameter( mat, "u_modulateAlpha" ) )
			_prm_modalpha = mat->getParameter("u_modulateAlpha");
	}
}


/*------------------------------------------------------------*/
/*
		gameplay game class
*/
/*------------------------------------------------------------*/

gamehsp::gamehsp()
{
	// コンストラクタ
	mFont = NULL;
	_maxobj = 0;
	_gpobj = NULL;
	_gpmat = NULL;
	_colrate = 1.0f / 255.0f;
	_scene = NULL;
	_meshBatch = NULL;
	_meshBatch_line = NULL;
	_spriteEffect = NULL;

}

void gamehsp::initialize()
{
	// フォント作成
	mFont = Font::create("res/font.gpb");
	resetScreen();
}

void gamehsp::finalize()
{
	// release
	//
	deleteAll();

	SAFE_RELEASE(mFont);
}


void gamehsp::deleteAll( void )
{
	// release
	//
	if ( _scene ) {
		_scene->removeAllNodes();
		_scene->setActiveCamera(NULL);
	}

	if ( _gpobj ) {
		int i;
		for(i=0;i<_maxobj;i++) { deleteObj( i ); }
		delete[] _gpobj;
		_gpobj = NULL;
	}
	if ( _gpmat ) {
		int i;
		for(i=0;i<_maxmat;i++) { deleteMat( i ); }
		delete[] _gpmat;
		_gpmat = NULL;
	}

	if ( _meshBatch ) {
		delete _meshBatch;
		_meshBatch = NULL;
	}
	if ( _meshBatch_line ) {
		delete _meshBatch_line;
		_meshBatch_line = NULL;
	}

	SAFE_RELEASE(_spriteEffect);
	SAFE_RELEASE(_scene);
}


void gamehsp::update(float elapsedTime)
{
}

void gamehsp::render(float elapsedTime)
{
    // Clear the color and depth buffers
	Vector4 clscolor;
	int icolor;
	int clsmode;

	icolor = GetSysReq( SYSREQ_CLSCOLOR );
	clsmode = GetSysReq( SYSREQ_CLSMODE );

	if ( clsmode == CLSMODE_NONE ) {
		clear(CLEAR_DEPTH, Vector4::zero(), 1.0f, 0);
		return;
	}

	clscolor.set( ( (icolor>>16)&0xff )*_colrate, ( (icolor>>8)&0xff )*_colrate, ( icolor&0xff )*_colrate, 1.0f );
    clear(CLEAR_COLOR_DEPTH, clscolor, 1.0f, 0);

    //nodetemp->rotateY(MATH_DEG_TO_RAD((float)elapsedTime / 1000.0f * 180.0f));
}

void gamehsp::keyEvent(Keyboard::KeyEvent evt, int key)
{
}

void gamehsp::touchEvent(Touch::TouchEvent evt, int x, int y, unsigned int contactIndex)
{
}

/*------------------------------------------------------------*/
/*
		HSP Script Service
*/
/*------------------------------------------------------------*/

void gamehsp::hookSetSysReq( int reqid, int value )
{
	//	HGIMG4用のSetSysReq
	//
	switch( reqid ) {
	case SYSREQ_VSYNC:
		setVsync( value!=0 );
		break;
	default:
		break;
	}
}


void gamehsp::hookGetSysReq( int reqid )
{
	//	HGIMG4用のGetSysReq
	//
	switch( reqid ) {
	case SYSREQ_FPS:
		SetSysReq( reqid, (int)getFrameRate() );
		break;
	default:
		break;
	}
}


void gamehsp::resetScreen( int opt )
{
	if ( opt == 1 ) {
		_scene->removeAllNodes();
		return;
	}

	// 画面の初期化
	deleteAll();

	// VSYNCの設定
	setVsync( GetSysReq( SYSREQ_VSYNC )!=0 );

	// gpobj作成
	_maxobj = GetSysReq( SYSREQ_MAXOBJ );
	_gpobj = new gpobj[ _maxobj ];
	setObjectPool( 0, -1 );

	// gpmat作成
	_maxmat = GetSysReq( SYSREQ_MAXMATERIAL );
	_gpmat = new gpmat[ _maxmat ];

	// シーン作成
	_scene = Scene::create();
	_curscene = 0;

	// カメラ作成
	//Camera*	camera = Camera::createPerspective(45.0f, getAspectRatio(), 0.01f, 20.0f );
	//Camera*	camera = Camera::createPerspective(0.25f*3.141592654f, getAspectRatio(), 0.5f, 768.0f );
	//_cameraDefault = Camera::createPerspective( 45.0f, getAspectRatio(), 0.5f, 768.0f );

	_defcamera = makeNewCam( -1, 45.0f, getAspectRatio(), 0.5f, 768.0f );		// カメラを生成
	selectCamera( _defcamera );

//	_camera = _scene->addNode("camera");
//	_camera->setCamera( _cameraDefault );
//	_scene->setActiveCamera( _cameraDefault );	// カメラ設定
//	_camera->translate(0, 0, 100);
//	SAFE_RELEASE(camera);

	// シーンライト作成
	_scene->setLightColor( 1.0f, 1.0f, 1.0f );

	Vector3 ldir;
	ldir.set( -0.5f, 0.0f, -0.3f );
	_scene->setLightDirection( ldir );
	_scene->setAmbientColor( 0.25f, 0.25f, 0.25f );

	// ライト作成
	_deflight = makeNewLgt( -1, GPLGT_OPT_NORMAL );
	selectLight( _deflight );

	// ボーダー初期化
	border1.set( -50.0f, 0.0f, -50.0f );
	border2.set( 50.0f, 100.0f,  50.0f );

	// 2D初期化
	init2DRender();

	//makeFloorNode( 20.0f, 20.0f, 0x404040 );
	//makeModelNode( "res/mikuA","mikuA_root" );

	// ビューポート初期化
	updateViewport( 0, 0, getWidth(), getHeight() );

}


void gamehsp::updateViewport( int x, int y, int w, int h )
{
	Rectangle viewport;
	viewport.set( (float)x, (float)y, (float)w, (float)h );
	setViewport( viewport );
}


void gamehsp::setBorder( float x0, float x1, float y0, float y1, float z0, float z1 )
{
	border1.set( x0, y0, z0 );
	border2.set( x1, y1, z1 );
}


void gamehsp::getBorder( Vector3 *v1, Vector3 *v2 )
{
	*v1 = border1;
	*v2 = border2;
}


void gamehsp::deleteObjectID( int id )
{
	//	指定されたIDのオブジェクトを削除する
	//	(gpobj,gpmat,gplgt,gpcam,gpphyで使用可能)
	//
	int flag_id;
	int base_id;
	flag_id = id & GPOBJ_ID_FLAGBIT;
	base_id = id & GPOBJ_ID_FLAGMASK;
	switch( flag_id ) {
	case GPOBJ_ID_MATFLAG:
		deleteMat( id );
		return;
	default:
		break;
	}
	deleteObj( base_id );
}


bool gamehsp::init2DRender( void )
{
	// 2D用の初期化
	//

	// 2D用のプロジェクション
	//Matrix::createOrthographic(getWidth(), getHeight(), -1.0f, 1.0f, &_projectionMatrix2D);
	Matrix::createOrthographicOffCenter( 0.0f, getWidth(), getHeight(), 0.0f, -1.0f, 1.0f, &_projectionMatrix2D);
	_projectionMatrix2D.translate( 0.5f, 0.0f, 0.0f );						// 座標誤差修正のため0.5ドットずらす

	// スプライト用のshader
	_spriteEffect = Effect::createFromFile(SPRITE_VSH, SPRITE_FSH);
	if ( _spriteEffect == NULL ) {
        GP_ERROR("2D shader initalize failed.");
        return false;
	}

	// MeshBatch for FlatPolygon Draw
	Material* mesh_material = make2DMaterialForMesh();
    VertexFormat::Element elements[] =
    {
        VertexFormat::Element(VertexFormat::POSITION, 3),
        VertexFormat::Element(VertexFormat::COLOR, 4)
    };
    unsigned int elementCount = sizeof(elements) / sizeof(VertexFormat::Element);
    _meshBatch = MeshBatch::create(VertexFormat(elements, elementCount), Mesh::TRIANGLE_STRIP, mesh_material, true, 16, 16 );
	SAFE_RELEASE(mesh_material);

	mesh_material = make2DMaterialForMesh();
	_meshBatch_line = MeshBatch::create(VertexFormat(elements, elementCount), Mesh::LINES, mesh_material, true, 4, 4 );
	SAFE_RELEASE(mesh_material);


	int i;
	for(i=0;i<BUFSIZE_POLYCOLOR;i++) {
		_bufPolyColor[i] = 0.0f;
	}
	for(i=0;i<BUFSIZE_POLYTEX;i++) {
		_bufPolyTex[i] = 0.0f;
	}

	return true;
}


void gamehsp::selectScene( int sceneid )
{
	_curscene = sceneid;
}


int gamehsp::setObjName( int objid, char *name )
{
	Node *node;
	node = getNode( objid );
	if ( node == NULL ) return -1;
	node->setId( name );
	return 0;
}


char *gamehsp::getObjName( int objid )
{
	Node *node;
	node = getNode( objid );
	if ( node == NULL ) return NULL;
	return (char *)node->getId();
}

	
void gamehsp::addSceneVector( int ch, Vector4 *prm )
{
}


void gamehsp::addNodeVector( gpobj *obj, Node *node, int moc, Vector4 *prm )
{
	switch(moc) {
	case MOC_POS:
		if ( node ) {
			node->translate( prm->x, prm->y, prm->z );
		}
		break;
	case MOC_QUAT:
		if ( node ) {
			node->rotate( prm->x, prm->y, prm->z, prm->w );
		}
		break;
	case MOC_SCALE:
		if ( node ) {
			node->scale( prm->x, prm->y, prm->z );
		}
		break;
	case MOC_DIR:
		if ( obj ) {
			obj->_vec[GPOBJ_USERVEC_DIR] += *prm;
		}
		break;
	case MOC_EFX:
		break;
	case MOC_COLOR:
		if ( obj ) {
			obj->_vec[GPOBJ_USERVEC_COLOR] += *prm;
			if ( obj->_light ) updateLightVector( obj, moc );
		}
		break;
	case MOC_WORK:
		if ( obj ) {
			obj->_vec[GPOBJ_USERVEC_WORK] += *prm;
		}
		break;
	case MOC_WORK2:
		if ( obj ) {
			obj->_vec[GPOBJ_USERVEC_WORK2] += *prm;
		}
		break;

	case MOC_AXANG:
		break;
	case MOC_ANGX:
		if ( node ) {
			node->rotateX( prm->x );
			node->rotateY( prm->y );
			node->rotateZ( prm->z );
		}
		break;
	case MOC_ANGY:
		if ( node ) {
			node->rotateY( prm->y );
			node->rotateZ( prm->z );
			node->rotateX( prm->x );
		}
		break;
	case MOC_ANGZ:
		if ( node ) {
			node->rotateZ( prm->z );
			node->rotateY( prm->y );
			node->rotateX( prm->x );
		}
		break;


	}
}


void gamehsp::addSpriteVector( gpobj *obj, int moc, Vector4 *prm )
{
	gpspr *spr;
	spr = obj->_spr;
	if ( spr == NULL ) return;

	switch(moc) {
	case MOC_POS:
		spr->_pos.add( *prm );
		break;
	case MOC_SCALE:
		spr->_scale.add( *prm );
		break;
	case MOC_DIR:
		obj->_vec[GPOBJ_USERVEC_DIR] += *prm;
		break;

	case MOC_ANGX:
	case MOC_ANGY:
	case MOC_ANGZ:
		spr->_ang.add( *prm );
		break;

	case MOC_COLOR:
		obj->_vec[GPOBJ_USERVEC_COLOR] += *prm;
		break;
	case MOC_WORK:
		obj->_vec[GPOBJ_USERVEC_WORK] += *prm;
		break;
	case MOC_WORK2:
		obj->_vec[GPOBJ_USERVEC_WORK2] += *prm;
		break;
	}
}


int gamehsp::addObjectVector( int objid, int moc, Vector4 *prm )
{
	gpobj *obj;
	int flag_id;
	flag_id = objid & GPOBJ_ID_FLAGBIT;
	if ( flag_id == 0 ) {
		obj = getObj( objid );
		if ( obj == NULL ) return -1;
		if ( obj->_spr ) {
			addSpriteVector( obj, moc, prm );
			return 0;
		}
		addNodeVector( obj, obj->_node, moc, prm );
		return 0;
	}

	switch( flag_id ) {
	case GPOBJ_ID_EXFLAG:
		break;
	default:
		return -1;
	}

	//	GPOBJ_ID_EXFLAGの場合
	switch( objid ) {
	case GPOBJ_ID_SCENE:
		addSceneVector( moc, prm );
		return 0;
	case GPOBJ_ID_CAMERA:
		obj = getObj( _defcamera );
		break;
	case GPOBJ_ID_LIGHT:
		obj = getObj( _deflight );
		break;
	default:
		return -1;
	}
	if ( obj == NULL ) return -1;
	addNodeVector( obj, obj->_node, moc, prm );
	return 0;
}


void gamehsp::lookAtNode(Node* node, const Vector3& target )
{
	Vector3 up;
	up.set( 0.0f, 1.0f, 0.0f );

	// Create lookAt matrix
    Matrix matrix;
	Matrix::createLookAt( node->getTranslation(), target, up, &matrix);
    matrix.transpose();

    // Pull rotation out of matrix
    Quaternion rotation;
    matrix.getRotation(&rotation);

    // Set rotation on node
    node->setRotation(rotation);
}



int gamehsp::lookAtObject( int objid, Vector4 *prm )
{
	Vector3 target;
	target.set( prm->x, prm->y, prm->z );
	Node *node;
	node = getNode( objid );
	if ( node == NULL ) return -1;
	lookAtNode( node, target );
	return 0;
}


void gamehsp::setSceneVector( int ch, Vector4 *prm )
{
}


void gamehsp::setSpriteVector( gpobj *obj, int moc, Vector4 *prm )
{
	gpspr *spr;
	spr = obj->_spr;
	if ( spr == NULL ) return;

	switch(moc) {
	case MOC_POS:
		spr->_pos.set( *prm );
		break;
	case MOC_SCALE:
		spr->_scale.set( *prm );
		break;
	case MOC_DIR:
		obj->_vec[GPOBJ_USERVEC_DIR] = *prm;
		break;

	case MOC_ANGX:
	case MOC_ANGY:
	case MOC_ANGZ:
		spr->_ang.set( *prm );
		break;

	case MOC_COLOR:
		obj->_vec[GPOBJ_USERVEC_COLOR] = *prm;
		break;
	case MOC_WORK:
		obj->_vec[GPOBJ_USERVEC_WORK] = *prm;
		break;
	case MOC_WORK2:
		obj->_vec[GPOBJ_USERVEC_WORK2] = *prm;
		break;
	}
}


void gamehsp::setNodeVector( gpobj *obj, Node *node, int moc, Vector4 *prm )
{
	switch(moc) {
	case MOC_POS:
		if ( node ) {
			node->setTranslation( prm->x, prm->y, prm->z );
		}
		break;
	case MOC_QUAT:
		if ( node ) {
			node->setRotation( prm->x, prm->y, prm->z, prm->w );
		}
		break;
	case MOC_SCALE:
		if ( node ) {
			node->setScale( prm->x, prm->y, prm->z );
		}
		break;
	case MOC_DIR:
		if ( obj ) {
			obj->_vec[GPOBJ_USERVEC_DIR] = *prm;
		}
		break;
	case MOC_EFX:
		break;

	case MOC_ANGX:
		if ( node ) {
			Matrix matrix;
			matrix.identity();
			matrix.rotateX( prm->x );
			matrix.rotateY( prm->y );
			matrix.rotateZ( prm->z );
			node->setRotation( matrix );
		}
		break;
	case MOC_ANGY:
		if ( node ) {
			Matrix matrix;
			matrix.identity();
			matrix.rotateY( prm->y );
			matrix.rotateX( prm->x );
			matrix.rotateZ( prm->z );
			node->setRotation( matrix );
		}
		break;
	case MOC_ANGZ:
		if ( node ) {
			Matrix matrix;
			matrix.identity();
			matrix.rotateZ( prm->z );
			matrix.rotateY( prm->y );
			matrix.rotateX( prm->x );
			node->setRotation( matrix );
		}
		break;

	case MOC_COLOR:
		if ( obj ) {
			obj->_vec[GPOBJ_USERVEC_COLOR] = *prm;
			if ( obj->_light ) updateLightVector( obj, moc );
		}
		break;
	case MOC_WORK:
		if ( obj ) {
			obj->_vec[GPOBJ_USERVEC_WORK] = *prm;
		}
		break;
	case MOC_WORK2:
		if ( obj ) {
			obj->_vec[GPOBJ_USERVEC_WORK2] = *prm;
		}
		break;
	}
}


int gamehsp::setObjectVector( int objid, int moc, Vector4 *prm )
{
	gpobj *obj;
	int flag_id;
	flag_id = objid & GPOBJ_ID_FLAGBIT;
	if ( flag_id == 0 ) {
		obj = getObj( objid );
		if ( obj == NULL ) return -1;
		if ( obj->_spr ) {
			setSpriteVector( obj, moc, prm );
			return 0;
		}
		setNodeVector( obj, obj->_node, moc, prm );
		return 0;
	}

	switch( flag_id ) {
	case GPOBJ_ID_EXFLAG:
		break;
	default:
		return -1;
	}

	//	GPOBJ_ID_EXFLAGの場合
	switch( objid ) {
	case GPOBJ_ID_SCENE:
		setSceneVector( moc, prm );
		return 0;
	case GPOBJ_ID_CAMERA:
		obj = getObj( _defcamera );
		break;
	case GPOBJ_ID_LIGHT:
		obj = getObj( _deflight );
		break;
	default:
		return -1;
	}
	if ( obj == NULL ) return -1;
	setNodeVector( obj, obj->_node, moc, prm );
	return 0;
}


void gamehsp::getNodeVector( gpobj *obj, Node *node, int moc, Vector4 *prm )
{
	switch(moc) {
	case MOC_POS:
		if ( node ) {
			*(Vector3 *)prm = node->getTranslation();
			prm->w = 0.0f;
		}
		break;
	case MOC_QUAT:
		if ( node ) {
			Quaternion quat;
			quat = node->getRotation();
			prm->x = quat.x;
			prm->y = quat.y;
			prm->z = quat.z;
			prm->w = quat.w;
		}
		break;
	case MOC_SCALE:
		if ( node ) {
			*(Vector3 *)prm = node->getScale();
			prm->w = 1.0f;
		}
		break;
	case MOC_DIR:
		if ( obj ) {
			*prm = obj->_vec[GPOBJ_USERVEC_DIR];
		}
		break;
	case MOC_EFX:
		break;

	case MOC_COLOR:
		if ( obj ) {
			*prm = obj->_vec[GPOBJ_USERVEC_COLOR];
		}
		break;
	case MOC_WORK:
		if ( obj ) {
			*prm = obj->_vec[GPOBJ_USERVEC_WORK];
		}
		break;
	case MOC_WORK2:
		if ( obj ) {
			*prm = obj->_vec[GPOBJ_USERVEC_WORK2];
		}
		break;
	}
}


void gamehsp::getSpriteVector( gpobj *obj, int moc, Vector4 *prm )
{
	gpspr *spr;
	spr = obj->_spr;
	if ( spr == NULL ) return;

	switch(moc) {
	case MOC_POS:
		prm->set( spr->_pos );
		break;
	case MOC_SCALE:
		prm->set( spr->_scale );
		break;
	case MOC_ANGX:
	case MOC_ANGY:
	case MOC_ANGZ:
		prm->set( spr->_ang );
		break;

	case MOC_DIR:
		*prm = obj->_vec[GPOBJ_USERVEC_DIR];
		break;
	case MOC_COLOR:
		*prm = obj->_vec[GPOBJ_USERVEC_COLOR];
		break;
	case MOC_WORK:
		*prm = obj->_vec[GPOBJ_USERVEC_WORK];
		break;
	case MOC_WORK2:
		*prm = obj->_vec[GPOBJ_USERVEC_WORK2];
		break;
	}
}


int gamehsp::getObjectVector( int objid, int moc, Vector4 *prm )
{
	int flag_id;
	flag_id = objid & GPOBJ_ID_FLAGBIT;
	if ( flag_id == 0 ) {
		gpobj *obj;
		obj = getObj( objid );
		if ( obj == NULL ) return -1;
		if ( obj->_spr ) {
			getSpriteVector( obj, moc, prm );
			return 0;
		}
		getNodeVector( obj, obj->_node, moc, prm );
		return 0;
	}
	getNodeVector( NULL, getNode(objid), moc, prm );
	return 0;
}


void gamehsp::drawNode( Node *node )
{
	Model* model = node->getModel(); 
	if (model) {
		model->draw();
	}
}


void gamehsp::drawAll( int option )
{
	// すべてのノードを描画
	//

	// ビルボード用の向きを作成
	Matrix m;
	Camera* camera = _scene->getActiveCamera();
	m = camera->getNode()->getMatrix();
	m.getRotation(&_qcam_billboard);

	//	gpobjの3Dシーン描画
	//
	if ( option & GPDRAW_OPT_DRAWSCENE ) {
		_scenedraw_lateflag = false;
		_scene->visit(this, &gamehsp::drawScene);
	}
	if ( option & GPDRAW_OPT_DRAWSCENE_LATE ) {
		_scenedraw_lateflag = true;
		_scene->visit(this, &gamehsp::drawScene);
	}
}


bool gamehsp::updateNodeMaterial( Node* node, Material *material )
{
	//	再帰的にノードのマテリアルを設定
	//
	Node *sub_node;
	sub_node = node->getFirstChild();
	if ( sub_node ) {
		updateNodeMaterial( sub_node, material );
	}
	sub_node = node->getNextSibling();
	if ( sub_node ) {
		updateNodeMaterial( sub_node, material );
	}

	Model* model = node->getModel(); 
    if (model)
    {
		model->setMaterial( material );
    }
	return true;
}


bool gamehsp::drawScene(Node* node)
{
    // If the node visited contains a model, draw it
	gpobj *obj = (gpobj *)node->getUserPointer();
    Model* model = node->getModel(); 
	if ( obj ) {
		if ( obj->isVisible( _scenedraw_lateflag ) == false ) return false;

		int mode = obj->_mode;
		if ( mode & GPOBJ_MODE_XFRONT ) {
			node->setRotation(_qcam_billboard);
		}
		if ( mode & GPOBJ_MODE_CLIP ) {
			if (node->getBoundingSphere().intersects(_cameraDefault->getFrustum()) == false ) return false;
		}

		//	Alphaのモジュレート設定
		gameplay::MaterialParameter *prm_modalpha = obj->_prm_modalpha;
		if ( prm_modalpha ) { prm_modalpha->setValue( obj->getAlphaRate() ); }

		if ( model ) {

			if ( mode & GPOBJ_MODE_WIRE ) {			// ワイヤーフレーム描画時
				model->draw(true);
				return true;
			}

		}


	}

    if (model)
    {
        model->draw();
    }
    return true;
}


int *gamehsp::getObjectPrmPtr( int objid, int prmid )
{
	int id;
	int *base_i;
	gpobj *obj;
	obj = getObj( objid );
	if ( obj == NULL ) return NULL;
	if ( prmid < 0 ) return NULL;
	if ( prmid & 0x100 ) {
		gpspr *spr;
		spr = obj->_spr;
		if ( spr == NULL ) return NULL;
		id = prmid & 0xff;
		if ( id >= (sizeof(gpspr)/sizeof(int)) ) return NULL;
		base_i = (int *)spr;
		base_i += id;
	} else {
		base_i = (int *)obj;
		if ( prmid >= (sizeof(gpobj)/sizeof(int)) ) return NULL;
		base_i += prmid;
	}
	return base_i;
}


int gamehsp::getObjectPrm( int objid, int prmid, int *outptr )
{
	int *base_i;
	base_i = getObjectPrmPtr( objid, prmid );
	if ( base_i == NULL ) return -1;
	*outptr = *base_i;
	return 0;
}


int gamehsp::setObjectPrm( int objid, int prmid, int value )
{
	int *base_i;
	base_i = getObjectPrmPtr( objid, prmid );
	if ( base_i == NULL ) return -1;
	*base_i = value;
	return 0;
}


/*------------------------------------------------------------*/
/*
		Primitive process
*/
/*------------------------------------------------------------*/

int gamehsp::makeNullNode( void )
{
	Node *node;
	gpobj *obj = addObj();
	if ( obj == NULL ) return -1;

	node = Node::create();
	obj->_node = node;
	node->setUserPointer( obj, NULL );

	if ( _curscene >= 0 ) {
		_scene->addNode( obj->_node );
	}

	return obj->_id;
}


int gamehsp::makeSpriteObj( int celid, int gmode, void *bmscr )
{
	gpobj *obj = addObj();
	if ( obj == NULL ) return -1;

	obj->_spr = new gpspr;
	obj->_spr->reset( obj->_id, celid, gmode, bmscr );
	obj->_mode |= GPOBJ_MODE_2D;

	return obj->_id;
}


int gamehsp::makeFloorNode( float xsize, float ysize, int color, int matid )
{
	gpobj *obj = addObj();
	if ( obj == NULL ) return -1;

    // 平面作成
	Mesh* floorMesh = Mesh::createQuad(
		Vector3( -xsize * 0.5f , 0, -ysize * 0.5f ), Vector3( -xsize * 0.5f , 0, ysize * 0.5f ), 
		Vector3( xsize * 0.5f ,  0, -ysize * 0.5f ), Vector3( xsize * 0.5f , 0, ysize * 0.5f ));

	//Mesh* floorMesh = createFloorMesh( xsize, ysize );

	Material *material;
	if ( matid < 0 ) {
		int matopt = 0;
		if ( _curlight < 0 ) matopt |= GPOBJ_MATOPT_NOLIGHT;
		material = makeMaterialColor( color, matopt );
	} else {
		material = getMaterial( matid );
	}
	makeNewModel( obj, floorMesh, material );

    // メッシュ削除
    SAFE_RELEASE(floorMesh);

	// 初期化パラメーターを保存
	obj->_shape = GPOBJ_SHAPE_FLOOR;
	obj->_sizevec.set( xsize, 0, ysize );

/*
	// 物理設定
	PhysicsRigidBody::Parameters rigParams;
	rigParams.mass = 0.0f;	// 重さ
    rigParams.friction = 0.5;
    rigParams.restitution = 0.75;
    rigParams.linearDamping = 0.025;
    rigParams.angularDamping = 0.16;
	obj->_node->setCollisionObject(PhysicsCollisionObject::RIGID_BODY, 
		PhysicsCollisionShape::box(Vector3(xsize * 2, 0, ysize * 2)), &rigParams);
*/

	if ( _curscene >= 0 ) {
		_scene->addNode( obj->_node );
	}

	return obj->_id;
}


int gamehsp::makePlateNode( float xsize, float ysize, int color, int matid )
{
	gpobj *obj = addObj();
	if ( obj == NULL ) return -1;

    // 平面作成
	Mesh* floorMesh = Mesh::createQuad(
		Vector3( -xsize * 0.5f , ysize * 0.5f, 0 ), Vector3( -xsize * 0.5f , -ysize * 0.5f, 0 ), 
		Vector3( xsize * 0.5f ,  ysize * 0.5f, 0 ), Vector3( xsize * 0.5f , -ysize * 0.5f, 0 ));

	//Mesh* floorMesh = createFloorMesh( xsize, ysize );

	Material *material;
	if ( matid < 0 ) {
		int matopt = 0;
		if ( _curlight < 0 ) matopt |= GPOBJ_MATOPT_NOLIGHT;
		material = makeMaterialColor( color, matopt );
	} else {
		material = getMaterial( matid );
	}
	makeNewModel( obj, floorMesh, material );

    // メッシュ削除
    SAFE_RELEASE(floorMesh);

	// 初期化パラメーターを保存
	obj->_shape = GPOBJ_SHAPE_PLATE;
	obj->_sizevec.set( xsize, ysize, 0 );

	if ( _curscene >= 0 ) {
		_scene->addNode( obj->_node );
	}

	return obj->_id;
}


int gamehsp::makeBoxNode( float size, int color, int matid )
{
	Mesh *mesh;
	gpobj *obj = addObj();
	if ( obj == NULL ) return -1;

	mesh = createCubeMesh( size );

	Material *material;
	if ( matid < 0 ) {
		int matopt = 0;
		if ( _curlight < 0 ) matopt |= GPOBJ_MATOPT_NOLIGHT;
		material = makeMaterialColor( color, matopt );
	} else {
		material = getMaterial( matid );
	}
	makeNewModel( obj, mesh, material );

	// 初期化パラメーターを保存
	obj->_shape = GPOBJ_SHAPE_BOX;
	obj->_sizevec.set( size, size, size );

    // メッシュ削除
    SAFE_RELEASE(mesh);

/*
	// 物理設定
	PhysicsRigidBody::Parameters rigParams;
	rigParams.mass = 1.0f;	// 重さ
	rigParams.friction = 0.5;
	rigParams.restitution = 0.5;
	rigParams.linearDamping = 0.1;
	rigParams.angularDamping = 0.5;
	obj->_node->setCollisionObject(PhysicsCollisionObject::RIGID_BODY, 
		PhysicsCollisionShape::box(Vector3(1,1,1)), &rigParams);
*/

	if ( _curscene >= 0 ) {
		_scene->addNode( obj->_node );
	}

	BoundingSphere bound = obj->_node->getBoundingSphere();

	return obj->_id;
}


int gamehsp::makeModelNode( char *fname, char *idname )
{
	char fn[512];
	char fn2[512];
	gpobj *obj = addObj();
	if ( obj == NULL ) return -1;

	getpath( fname, fn, 1 );
	//strcpy( fn, fname );
	strcpy( fn2, fn );
	strcat( fn, ".gpb" );
	strcat( fn2, ".material" );

    Bundle *bundle = Bundle::create( fn );
	Node *rootNode;
	Node *node;

	Material* boxMaterial = Material::create( fn2 );

	MaterialParameter *ambientColorParam =
		hasParameter( boxMaterial, "u_ambientColor" ) ?
		boxMaterial->getParameter("u_ambientColor") : NULL;
	MaterialParameter *lightDirectionParam =
		hasParameter( boxMaterial, "u_lightDirection" ) ?
		boxMaterial->getParameter("u_lightDirection") : NULL;
	MaterialParameter *lightColorParam =
		hasParameter( boxMaterial, "u_lightColor" ) ?
		boxMaterial->getParameter("u_lightColor") : NULL;

	if ( _curlight >= 0 ) {
		//	カレントライトを反映させる
		gpobj *lgt;
		Node *light_node;
		lgt = getObj( _curlight );
		light_node = lgt->_node;

		// ライトの方向設定
		if ( lightDirectionParam ) {
			lightDirectionParam->bindValue(light_node, &Node::getForwardVectorView);
		}
	    // ライトの色設定
		// (リアルタイムに変更を反映させる場合は再設定が必要。現在は未対応)
		if ( ambientColorParam ) {
			Vector3 *vambient;
			vambient = (Vector3 *)&lgt->_vec[GPOBJ_USERVEC_WORK];
			ambientColorParam->setValue( vambient );
		}
		if ( lightColorParam ) {
			lightColorParam->setValue(light_node->getLight()->getColor());
		}
	}

	if ( idname ) {
		rootNode = bundle->loadNode( idname );
		if ( rootNode == NULL ) {
			Alertf( "Node not found.(%s#%s)",fname,idname );
			return -1;
		}
		updateNodeMaterial( rootNode, boxMaterial );

	} else {
		unsigned int i;

		Scene *scene;
		Animation *animation;
		char *rootid;

		rootNode = Node::create();
		rootid = NULL;

		scene = bundle->loadScene();
		if ( scene ) {
			node = scene->getFirstNode();
			animation = node->getAnimation("animations");
			if (animation) {
				rootid = (char *)node->getId();
				//Alertf( "Found Power Scene Node(%s) Clip count: %d", node->getId(), animation->getClipCount() );
			}

		}

		for(i=0;i<bundle->getObjectCount();i++) {
			node = bundle->loadNode( bundle->getObjectId(i) );
			if ( node ) {
				Model* model = node->getModel();
			    if (model) {
					model->setMaterial( boxMaterial );
			    }
				//Alertf( "#%d %s",i, bundle->getObjectId(i) );

				animation = node->getAnimation("animations");
				if (animation) {
					if (  strcmp( node->getId() ,rootid ) == 0 ) {
						AnimationClip *aclip;
						aclip = animation->createClip( "idle", 0, animation->getDuration() );
						aclip->setRepeatCount( AnimationClip::REPEAT_INDEFINITE );
						animation->play("idle");
						//animation->createClips("zombie.animation");
						//Alertf( "(%s) Clip count: %d Dur:%ld", node->getId(), animation->getClipCount(), animation->getDuration() );
						rootNode->addChild( node );
					}
				} else {
					rootNode->addChild( node );
				}

				SAFE_RELEASE(node);
			}
		}


		SAFE_RELEASE(scene);


	}

	obj->updateParameter( boxMaterial );

	if ( _curscene >= 0 ) {
		_scene->addNode( rootNode );
	}

	//model->setMaterial( boxMaterial );

	SAFE_RELEASE(bundle);
    SAFE_RELEASE(boxMaterial);

	//nodetemp = mCubeNode;
	rootNode->setUserPointer( obj, NULL );
	obj->_node = rootNode;

	// 初期化パラメーターを保存
	obj->_shape = GPOBJ_SHAPE_MODEL;

	return obj->_id;
}


void gamehsp::makeNewModel( gpobj *obj, Mesh *mesh, Material *material )
{
	//	gpobjに新規モデルを追加してメッシュとマテリアルを設定する
	//
	Model *model;
	model = Model::create(mesh);	// モデル作成
	model->setMaterial( material );

	Node *node = obj->_node;
	if ( node == NULL ) {
		node = Node::create();
		obj->_node = node;
	}
	node->setModel(model);
	node->setUserPointer( obj, NULL );
	obj->_model = model;
	obj->updateParameter( material );
	SAFE_RELEASE(model);
}


int gamehsp::makeNewModelWithMat( gpobj *obj, Mesh *mesh, int matid )
{
	//	gpobjに新規モデルを追加してメッシュとマテリアルを設定する
	//  (マテリアルIDを使用)
	//
	gpmat *mat = getMat( matid );
	if ( mat == NULL ) return -1;
	makeNewModel( obj, mesh, mat->_material );
	obj->_usegpmat = matid;
	return 0;
}


/*------------------------------------------------------------*/
/*
		Node process
*/
/*------------------------------------------------------------*/

gpobj *gamehsp::getObj( int id )
{
	if (( id < 0 )||( id >= _maxobj )) return NULL;
	if ( _gpobj[id]._flag == GPOBJ_FLAG_NONE ) return NULL;
	return &_gpobj[id];
}


int gamehsp::deleteObj( int id )
{
	Model *model;
	Material *material;
	gpobj *obj = getObj( id );
	if ( obj == NULL ) return -1;

	obj->_flag = GPOBJ_FLAG_NONE;
	if ( obj->_spr ) {
		delete obj->_spr;
		obj->_spr = NULL;
	}
	if ( obj->_phy ) {
		delete obj->_phy;
		obj->_phy = NULL;
	}
	model = obj->_model;
	if ( model ) {
		if ( obj->_usegpmat < 0 ) {
			material = model->getMaterial();
			material->release();		// 独自にcreateした参照カウントを減らす
		}
	}
    SAFE_RELEASE( obj->_node );

    SAFE_RELEASE( obj->_camera );
    SAFE_RELEASE( obj->_light );

	return 0;
}


int gamehsp::setObjectPool( int startid, int num )
{
	int max;
	max = num;
	if ( max < 0 ) {
		max = _maxobj - startid;
	}
	if ( startid < 0 ) return -1;
	if ( startid >= _maxobj ) return -1;
	if ( ( startid + max ) > _maxobj ) return -1;
	_objpool_startid = startid;
	_objpool_max = max;
	return 0;
}


gpobj *gamehsp::addObj( void )
{
	//	空のgpobjを生成する
	//
	int i;
	gpobj *obj = _gpobj;
	obj += _objpool_startid;
	for( i=_objpool_startid; i<_objpool_max; i++ ) {
		if ( obj->_flag == GPOBJ_FLAG_NONE ) {
			obj->reset(i);
			return obj;
		}
		obj++;
	}
	return NULL;
}


Node *gamehsp::getNode( int objid )
{
	//	指定されたIDの持つノードを返す
	//	(gpobj,gplgt,cameraで使用可能)
	//
	int flag_id;
	gpobj *obj;
	flag_id = objid & GPOBJ_ID_FLAGBIT;
	switch( flag_id ) {
	case 0:
		obj = getObj( objid );
		if ( obj == NULL ) return NULL;
		return obj->_node;
	case GPOBJ_ID_EXFLAG:
		break;
	default:
		return NULL;
	}

	//	GPOBJ_ID_EXFLAGの場合
	switch( objid ) {
//	case GPOBJ_ID_SCENE:
	case GPOBJ_ID_CAMERA:
		return _cameraDefault->getNode();
	case GPOBJ_ID_LIGHT:
		obj = getObj( _deflight );
		if ( obj == NULL ) return NULL;
		return obj->_node;
	default:
		break;
	}
	return NULL;
}


int gamehsp::makeCloneNode( int objid )
{
	gpobj *obj;
	Node *node;
	obj = getObj( objid );
	if ( obj == NULL ) return -1;

	if ( obj->_spr ) {
		// 2Dスプライトの場合
		return makeSpriteObj( obj->_spr->_celid, obj->_spr->_gmode, obj->_spr->_bmscr );
	}
	
	gpobj *newobj = addObj();
	if ( newobj == NULL ) return -1;

	node = obj->_node;
	if ( node == NULL ) {
		return newobj->_id;
	}

	newobj->_mode = obj->_mode;
	newobj->_usegpmat = obj->_usegpmat;
	newobj->_shape = obj->_shape;
	newobj->_sizevec = obj->_sizevec;

	node->setUserPointer( NULL, NULL );

	newobj->_node = node->clone();

	newobj->_node->setUserPointer( newobj, NULL );

	if ( _curscene >= 0 ) {
		_scene->addNode( newobj->_node );
	}

	node->setUserPointer( obj, NULL );

	return newobj->_id;
}


/*------------------------------------------------------------*/
/*
		gpobj update
*/
/*------------------------------------------------------------*/

int gamehsp::updateObjBorder( int mode, Vector3 *pos, Vector4 *dir )
{
	//		自動範囲クリップ
	//
	int cflag,thru;
	cflag = 0;
	thru = GetSysReq( SYSREQ_THROUGHFLAG );
		if ( thru & 1 ) {
			if ( pos->x < border1.x ) {
				pos->x = border2.x - ( border1.x - pos->x );
			}
			if ( pos->x > border2.x ) {
				pos->x = border1.x + ( pos->x - border2.x );
			}
		}
		if ( thru & 2 ) {
			if ( pos->y < border1.y ) {
				pos->y = border2.y - ( border1.y - pos->y );
			}
			if ( pos->y > border2.y ) {
				pos->y = border1.y + ( pos->y - border2.y );
			}
		}
		if ( thru & 4 ) {
			if ( pos->z < border1.z ) {
				pos->z = border2.z - ( border1.z - pos->z );
			}
			if ( pos->z > border2.z ) {
				pos->z = border1.z + ( pos->z - border2.z );
			}
		}
		if ( mode & GPOBJ_MODE_FLIP ) {
			if ( pos->x < border1.x ) {
				pos->x = border1.x;
				dir->x *= -1.0f;
			}
			if ( pos->x > border2.x ) {
				pos->x = border2.x;
				dir->x *= -1.0f;
			}
			if ( pos->y < border1.y ) {
				pos->y = border1.y;
				dir->y *= -1.0f;
			}
			if ( pos->y > border2.y ) {
				pos->y = border2.y;
				dir->y *= -1.0f;
			}
			if ( pos->z < border1.z ) {
				pos->z = border1.z;
				dir->z *= -1.0f;
			}
			if ( pos->z > border2.z ) {
				pos->z = border2.z;
				dir->z *= -1.0f;
			}
		}
		else {
			if ( pos->x < border1.x ) {
				cflag++;
			}
			if ( pos->x > border2.x ) {
				cflag++;
			}
			if ( pos->y < border1.y ) {
				cflag++;
			}
			if ( pos->y > border2.y ) {
				cflag++;
			}
			if ( pos->z < border1.z ) {
				cflag++;
			}
			if ( pos->z > border2.z ) {
				cflag++;
			}
			if ( cflag ) {
				return -1;
			}
		}

	return 0;
}


void gamehsp::updateObj( gpobj *obj )
{
	//		gpobjの更新
	//
	int mode = obj->_mode;
	if ( mode & ( GPOBJ_MODE_MOVE|GPOBJ_MODE_BORDER) ) {
		int cflag;
		Vector3 pos;
		Vector4 *dir;
		if ( obj->_spr ) {
			pos = *(Vector3 *)&obj->_spr->_pos;
		} else {
			pos = obj->_node->getTranslation();
		}
		dir = &obj->_vec[GPOBJ_USERVEC_DIR];
		if ( mode & GPOBJ_MODE_MOVE ) {
			pos.add( *(Vector3 *)dir );
		}
		if ( mode & GPOBJ_MODE_BORDER ) {
			cflag = updateObjBorder( mode, &pos, dir );
			if ( cflag ) {												// 消去フラグ
				deleteObj( obj->_id );
				return;
			}
		}
		if ( obj->_spr ) {
			obj->_spr->_pos.set( pos.x, pos.y, pos.z, 1.0f );
		} else {
			obj->_node->setTranslation( pos );
		}
	}

}


void gamehsp::updateAll( void )
{
	/*
		All update of gpobj
	*/
	int i;

    if ( getState() == PAUSED ) return;

	gpobj *obj = _gpobj;
	for(i=0;i<_maxobj;i++) {
		if ( obj->_flag ) {
			updateObj( obj );
		}
		obj++;
	}
}


int gamehsp::updateObjColi( int objid, float size, int addcol )
{
	int i;
	int chkgroup;
	gpobj *obj;
	gpobj *atobj;
	gpspr *spr;
	Vector3 *pos;

	obj = getObj( objid );
	if ( obj == NULL ) return -1;

	if ( addcol == 0 ) {
		chkgroup = obj->_colgroup;
	} else {
		chkgroup = addcol;
	}

	spr = obj->_spr;
	if ( spr ) {									// 2Dスプライト時の処理
		gpspr *atspr;
		pos = (Vector3 *)&spr->_pos;
		atobj = _gpobj;
		for(i=0;i<_maxobj;i++) {
			if ( atobj->isVisible() ) {
				if (( atobj->_mygroup & chkgroup )&&( i != objid )) {
					atspr = atobj->_spr;
					if ( atspr ) {
						if ( atspr->getDistanceHit( pos, size ) ) {
							return i;
						}
					}
				}
			}
			atobj++;
		}
		return -1;
	}

	Vector3 vpos;
	Node *node;
	BoundingSphere bound;
	if ( obj->_node == NULL ) return -1;

	vpos = obj->_node->getTranslation();
	bound = obj->_node->getBoundingSphere();
	bound.radius *= size;							// 自分のサイズを調整する
	atobj = _gpobj;

	for(i=0;i<_maxobj;i++) {
		if ( atobj->isVisible() ) {
			if (( atobj->_mygroup & chkgroup )&&( i != objid )) {
				node = atobj->_node;
				if ( node ) {
					if ( bound.intersects( node->getBoundingSphere() ) ) {
						return i;
					}
				}
			}
		}
		atobj++;
	}

	return -1;
}


/*------------------------------------------------------------*/
/*
		gpspr Obj
*/
/*------------------------------------------------------------*/

gpspr::gpspr()
{
	_id = -1;
}

gpspr::~gpspr()
{
}

void gpspr::reset( int id, int celid, int gmode, void *bmscr )
{
	_id = id;
	_celid = celid;
	_gmode = gmode;
	_bmscr = bmscr;
	_pos.set( Vector4::zero() );
	_ang.set( Vector4::zero() );
	_scale.set( 1.0f, 1.0f, 1.0f, 1.0f );
}


int gpspr::getDistanceHit( Vector3 *v, float size )
{
	float sz;
	sz = size * 1.0f;//colscale[0];
	if ( fabs( _pos.x - v->x ) < sz ) {
		sz = size * 1.0f;//colscale[1]
		if ( fabs( _pos.y - v->y ) < sz ) {
			return 1;
		}
	}
	return 0;
}




gpspr *gamehsp::getSpriteObj( int objid )
{
	//	スプライト情報を返す
	//
	gpobj *obj = getObj( objid );
	if ( obj == NULL ) return NULL;
	return obj->_spr;
}


void gamehsp::findSpriteObj( bool lateflag )
{
	_find_count = 0;
	_find_gpobj = _gpobj;
	_find_lateflag = lateflag;
}


gpobj *gamehsp::getNextSpriteObj( void )
{
	gpobj *res;
	while(1) {
		if ( _find_count >= _maxobj ) { return NULL; }
		if ( _find_gpobj->_flag ) {
			if ( _find_gpobj->_spr ) {
				if ( _find_gpobj->isVisible( _find_lateflag ) ) {
					res = _find_gpobj;
					break;
				}
			}
		}
		_find_count++;
		_find_gpobj++;
	}
	_find_count++;
	_find_gpobj++;
	return res;
}


void gamehsp::findeObj( int exmode, int group )
{
	_find_count = 0;
	_find_gpobj = _gpobj;
	_find_exmode = exmode;
	_find_group = group;
}


gpobj *gamehsp::getNextObj( void )
{
	gpobj *res;
	while(1) {
		if ( _find_count >= _maxobj ) { return NULL; }
		if ( _find_gpobj->_flag ) {
			if ( _find_gpobj->_colgroup & _find_group ) {
				if (( _find_gpobj->_mode & _find_exmode ) == 0 ) {
					res = _find_gpobj;
					break;
				}
			}
		}
		_find_count++;
		_find_gpobj++;
	}
	_find_count++;
	_find_gpobj++;
	return res;
}


/*------------------------------------------------------------*/
/*
		Utils
*/
/*------------------------------------------------------------*/

void gamehsp::colorVector3( int icolor, Vector4 &vec )
{
	vec.set( ( (icolor>>16)&0xff )*_colrate, ( (icolor>>8)&0xff )*_colrate, ( icolor&0xff )*_colrate, 1.0f );
}


void gamehsp::colorVector4( int icolor, Vector4 &vec )
{
	vec.set( ( (icolor>>16)&0xff )*_colrate, ( (icolor>>8)&0xff )*_colrate, ( icolor&0xff )*_colrate, ( (icolor>>24)&0xff )*_colrate );
}


Mesh *gamehsp::createCubeMesh( float size )
{
    float a = size * 0.5f;
    float vertices[] =
    {
        -a, -a,  a,    0.0,  0.0,  1.0,   0.0, 0.0,
         a, -a,  a,    0.0,  0.0,  1.0,   1.0, 0.0,
        -a,  a,  a,    0.0,  0.0,  1.0,   0.0, 1.0,
         a,  a,  a,    0.0,  0.0,  1.0,   1.0, 1.0,
        -a,  a,  a,    0.0,  1.0,  0.0,   0.0, 0.0,
         a,  a,  a,    0.0,  1.0,  0.0,   1.0, 0.0,
        -a,  a, -a,    0.0,  1.0,  0.0,   0.0, 1.0,
         a,  a, -a,    0.0,  1.0,  0.0,   1.0, 1.0,
        -a,  a, -a,    0.0,  0.0, -1.0,   0.0, 0.0,
         a,  a, -a,    0.0,  0.0, -1.0,   1.0, 0.0,
        -a, -a, -a,    0.0,  0.0, -1.0,   0.0, 1.0,
         a, -a, -a,    0.0,  0.0, -1.0,   1.0, 1.0,
        -a, -a, -a,    0.0, -1.0,  0.0,   0.0, 0.0,
         a, -a, -a,    0.0, -1.0,  0.0,   1.0, 0.0,
        -a, -a,  a,    0.0, -1.0,  0.0,   0.0, 1.0,
         a, -a,  a,    0.0, -1.0,  0.0,   1.0, 1.0,
         a, -a,  a,    1.0,  0.0,  0.0,   0.0, 0.0,
         a, -a, -a,    1.0,  0.0,  0.0,   1.0, 0.0,
         a,  a,  a,    1.0,  0.0,  0.0,   0.0, 1.0,
         a,  a, -a,    1.0,  0.0,  0.0,   1.0, 1.0,
        -a, -a, -a,   -1.0,  0.0,  0.0,   0.0, 0.0,
        -a, -a,  a,   -1.0,  0.0,  0.0,   1.0, 0.0,
        -a,  a, -a,   -1.0,  0.0,  0.0,   0.0, 1.0,
        -a,  a,  a,   -1.0,  0.0,  0.0,   1.0, 1.0
    };
    short indices[] = 
    {
        0, 1, 2, 2, 1, 3, 4, 5, 6, 6, 5, 7, 8, 9, 10, 10, 9, 11, 12, 13, 14, 14, 13, 15, 16, 17, 18, 18, 17, 19, 20, 21, 22, 22, 21, 23
    };
    unsigned int vertexCount = 24;
    unsigned int indexCount = 36;
    VertexFormat::Element elements[] =
    {
        VertexFormat::Element(VertexFormat::POSITION, 3),
        VertexFormat::Element(VertexFormat::NORMAL, 3),
        VertexFormat::Element(VertexFormat::TEXCOORD0, 2)
    };
    Mesh* mesh = Mesh::createMesh(VertexFormat(elements, 3), vertexCount, false);
    if (mesh == NULL)
    {
        GP_ERROR("Failed to create mesh.");
        return NULL;
    }
    mesh->setVertexData(vertices, 0, vertexCount);
    MeshPart* meshPart = mesh->addPart(Mesh::TRIANGLES, Mesh::INDEX16, indexCount, false);
    meshPart->setIndexData(indices, 0, indexCount);
    return mesh;
}


float *gamehsp::startPolyColor2D( void )
{
    _meshBatch->start();
	return _bufPolyColor;
}


void gamehsp::drawPolyColor2D( void )
{
    static unsigned short indices[] = { 0, 1, 2, 3 };
	_meshBatch->add( _bufPolyColor, 4, indices, 4 );
    _meshBatch->finish();
    _meshBatch->draw();
}


void gamehsp::addPolyColor2D( int num )
{
    static unsigned short indices[] = { 0, 1, 2, 3 };
	_meshBatch->add( _bufPolyColor, num, indices, num );
}


void gamehsp::finishPolyColor2D( void )
{
    _meshBatch->finish();
    _meshBatch->draw();
}


void gamehsp::setPolyDiffuse2D( float r, float g, float b, float a )
{
	//	Vertexのカラーコードのみを設定する
	//
	int i;
	float *v = _bufPolyColor;
	for(i=0;i<4;i++) {
		v += 3;						// Posを飛ばす
		*v++ = r;
		*v++ = g;
		*v++ = b;
		*v++ = a;
	}
}


float *gamehsp::startLineColor2D( void )
{
    _meshBatch_line->start();
	return _bufPolyColor;
}


void gamehsp::drawLineColor2D( void )
{
    static unsigned short indices[] = { 0, 1, 2, 3 };
	_meshBatch_line->add( _bufPolyColor, 2, indices, 2 );
    _meshBatch_line->finish();
    _meshBatch_line->draw();
}


void gamehsp::addLineColor2D( int num )
{
    static unsigned short indices[] = { 0, 1, 2, 3 };
	_meshBatch_line->add( _bufPolyColor, num, indices, num );
}


void gamehsp::finishLineColor2D( void )
{
    _meshBatch_line->finish();
    _meshBatch_line->draw();
}


float *gamehsp::startPolyTex2D( gpmat *mat )
{
	MeshBatch *mesh = mat->_mesh;
	if ( mesh == NULL ) {
        GP_ERROR("Bad Material.");
        return NULL;
	}

	mesh->start();
	return _bufPolyTex;
}


void gamehsp::drawPolyTex2D( gpmat *mat )
{
    static unsigned short indices[] = { 0, 1, 2, 3 };

	MeshBatch *mesh = mat->_mesh;
	if ( mesh == NULL ) {
        GP_ERROR("Bad Material.");
        return;
	}

	mesh->add( _bufPolyTex, 4, indices, 4 );
    mesh->finish();
    mesh->draw();
}


void gamehsp::addPolyTex2D( gpmat *mat )
{
    static unsigned short indices[] = { 0, 1, 2, 3 };

	MeshBatch *mesh = mat->_mesh;
	if ( mesh == NULL ) {
        GP_ERROR("Bad Material.");
        return;
	}
	mesh->add( _bufPolyTex, 4, indices, 4 );
}


void gamehsp::finishPolyTex2D( gpmat *mat )
{
	MeshBatch *mesh = mat->_mesh;
	if ( mesh == NULL ) {
        GP_ERROR("Bad Material.");
        return;
	}
    mesh->finish();
    mesh->draw();
}


void gamehsp::setPolyDiffuseTex2D( float r, float g, float b, float a )
{
	//	Vertexのカラーコードのみを設定する
	//
	int i;
	float *v = _bufPolyTex;
	for(i=0;i<4;i++) {
		v += 3 + 2;					// Pos,UVを飛ばす
		*v++ = r;
		*v++ = g;
		*v++ = b;
		*v++ = a;
	}
}


float gamehsp::setPolyColorBlend( int gmode, int gfrate )
{
	//	2Dカラー描画設定
	//	(戻り値=alpha値(0.0～1.0))
	//
	Material *material;
	material = _meshBatch->getMaterial();
	return setMaterialBlend( material, gmode, gfrate );
}


void gamehsp::drawTest( int matid )
{

	float points[] ={
	        0,100,0, 1,1,1,1,
	        0,0,0, 1,1,1,1,
	        100,100,0, 1,1,1,1,
	        100,0,0, 1,1,1,1,

	        0,300,0, 1,1,1,0,
	        0,200,0, 1,1,1,0,
	        100,300,0, 1,1,1,1,
	        100,200,0, 1,1,1,1,
	};

    //SPRITE_ADD_VERTEX(v[0], downLeft.x, downLeft.y, z, u1, v1, color.x, color.y, color.z, color.w);
    //SPRITE_ADD_VERTEX(v[1], upLeft.x, upLeft.y, z, u1, v2, color.x, color.y, color.z, color.w);
    //SPRITE_ADD_VERTEX(v[2], downRight.x, downRight.y, z, u2, v1, color.x, color.y, color.z, color.w);
    //SPRITE_ADD_VERTEX(v[3], upRight.x, upRight.y, z, u2, v2, color.x, color.y, color.z, color.w);

//	material->getParameter("u_projectionMatrix")->bindValue(this, &gamehsp::getProjectionMatrix);
//	material->getParameter("u_projectionMatrix")->setValue( _projectionMatrix2D );
//	material->getParameter("u_worldViewProjectionMatrix")->setValue( _camera->getWorldViewProjectionMatrix() );
//	material->getParameter("u_inverseTransposeWorldViewMatrix")->setValue( _camera->getInverseTransposeWorldViewMatrix() );
//	material->getParameter("u_cameraPosition")->setValue( _camera->getTranslation() );



    static unsigned short indices[] = { 0, 1, 2, 3, 3,4,   4,5,6,7, };



    _meshBatch->start();
    _meshBatch->add( points, 8, indices, 10 );
    _meshBatch->finish();
    _meshBatch->draw();


	return;
}


Material* gamehsp::make2DMaterialForMesh( void )
{
	RenderState::StateBlock *state;
	Material* mesh_material = Material::create( SPRITECOL_VSH, SPRITECOL_FSH, NULL );
	if ( mesh_material == NULL ) {
        GP_ERROR("2D initalize failed.");
        return false;
	}
    mesh_material->getParameter("u_projectionMatrix")->setValue(_projectionMatrix2D);
	state = mesh_material->getStateBlock();
	state->setCullFace(false);
	state->setDepthTest(false);
	state->setDepthWrite(false);
	state->setBlend(true);
	state->setBlendSrc(RenderState::BLEND_SRC_ALPHA);
	state->setBlendDst(RenderState::BLEND_ONE_MINUS_SRC_ALPHA);
	return mesh_material;
}


int gamehsp::drawFont( int x, int y, char *text, Vector4 *p_color, int size )
{
	// フォントで描画
	int xsize;
	if ( mFont == NULL ) return 0;

    mFont->start();
    xsize = mFont->drawText(text, x, y, *p_color, size );
    mFont->finish();
	return xsize;
}


