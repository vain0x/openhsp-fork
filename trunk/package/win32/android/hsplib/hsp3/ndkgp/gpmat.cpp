#include "gamehsp.h"

#include "../../hsp3/hsp3config.h"
#include "../supio.h"
#include "../sysreq.h"

// Default sprite shaders
#define SPRITE_VSH "res/shaders/sprite.vert"
#define SPRITE_FSH "res/shaders/sprite.frag"

#define SPRITECOL_VSH "res/shaders/spritecol.vert"
#define SPRITECOL_FSH "res/shaders/spritecol.frag"

bool hasParameter( Material* material, const char* name );

/*------------------------------------------------------------*/
/*
		gameplay Material Obj
*/
/*------------------------------------------------------------*/

gpmat::gpmat()
{
	// コンストラクタ
	_flag = GPMAT_FLAG_NONE;
}

gpmat::~gpmat()
{
}

void gpmat::reset( int id )
{
	_mode = 0;
	_mark = 0;
	_material = NULL;
	_mesh = NULL;
	_flag = GPMAT_FLAG_ENTRY;
	_id = id;
	_sx = 0;
	_sy = 0;
	_texratex = 0.0f;
	_texratey = 0.0f;
}


int gpmat::setParameter( char *name, Vector4 *value )
{
	if ( _material == NULL ) return -1;
    _material->getParameter( name )->setValue( value );

	return 0;
}


int gpmat::setParameter( char *name, Vector3 *value )
{
	if ( _material == NULL ) return -1;
    _material->getParameter( name )->setValue( value );

	return 0;
}


int gpmat::setParameter( char *name, float value )
{
	if ( _material == NULL ) return -1;
    _material->getParameter( name )->setValue( value );

	return 0;
}


int gpmat::setState( char *name, char *value )
{
	RenderState::StateBlock *state;

	if ( _material == NULL ) return -1;

	state = _material->getStateBlock();
	state->setState( name, value );

	return 0;
}




/*------------------------------------------------------------*/
/*
		Material process
*/
/*------------------------------------------------------------*/

gpmat *gamehsp::getMat( int id )
{
	int flag_id;
	int base_id;
	flag_id = id & GPOBJ_ID_FLAGBIT;
	if ( flag_id != GPOBJ_ID_MATFLAG ) return NULL;
	base_id = id & GPOBJ_ID_FLAGMASK;
	if (( base_id < 0 )||( base_id >= _maxmat )) return NULL;
	if ( _gpmat[base_id]._flag == GPMAT_FLAG_NONE ) return NULL;
	return &_gpmat[base_id];
}


int gamehsp::deleteMat( int id )
{
	gpmat *mat = getMat( id );
	if ( mat == NULL ) return -1;
	mat->_flag = GPMAT_FLAG_NONE;
	if ( mat->_mesh ) {
		delete mat->_mesh;
		mat->_mesh = NULL;
	}
    SAFE_RELEASE( mat->_material );
	return 0;
}


gpmat *gamehsp::addMat( void )
{
	int i;
	gpmat *mat = _gpmat;
	for(i=0;i<_maxmat;i++) {
		if ( mat->_flag == GPMAT_FLAG_NONE ) {
			mat->reset( i|GPOBJ_ID_MATFLAG );
			return mat;
		}
		mat++;
	}
	return NULL;
}


Material *gamehsp::getMaterial( int matid )
{
	gpmat *mat = getMat( matid );
	if ( mat == NULL ) return NULL;
	return mat->_material;
}

void gamehsp::setMaterialDefaultBinding( Material* material, int icolor, int matopt )
{
	// These parameters are normally set in a .material file but this example sets them programmatically.
    // Bind the uniform "u_worldViewProjectionMatrix" to use the WORLD_VIEW_PROJECTION_MATRIX from the scene's active camera and the node that the model belongs to.

//	material->getParameter("u_worldViewProjectionMatrix")->setValue( _camera->getWorldViewProjectionMatrix() );
//	material->getParameter("u_inverseTransposeWorldViewMatrix")->setValue( _camera->getInverseTransposeWorldViewMatrix() );
//	material->getParameter("u_cameraPosition")->setValue( _camera->getTranslation() );

//	material->getParameter("u_worldViewProjectionMatrix")->bindValue( _camera, &Node::getWorldViewProjectionMatrix );
//	material->getParameter("u_inverseTransposeWorldViewMatrix")->bindValue( _camera, &Node::getInverseTransposeWorldViewMatrix );
//	material->getParameter("u_cameraPosition")->bindValue( _camera, &Node::getTranslation );

	if ( hasParameter( material, "u_cameraPosition" ) )
		material->setParameterAutoBinding("u_cameraPosition", "CAMERA_WORLD_POSITION");
	if ( hasParameter( material, "u_worldViewProjectionMatrix" ) )
		material->setParameterAutoBinding("u_worldViewProjectionMatrix", "WORLD_VIEW_PROJECTION_MATRIX");
	if ( hasParameter( material, "u_inverseTransposeWorldViewMatrix" ) )
		material->setParameterAutoBinding("u_inverseTransposeWorldViewMatrix", "INVERSE_TRANSPOSE_WORLD_VIEW_MATRIX");

	Vector4 color;
	Node *light_node;

	if ( _curlight < 0 ) {
		//	カレントライトなし(シーンを参照)
		if ( hasParameter( material, "u_ambientColor" ) )
			material->setParameterAutoBinding("u_ambientColor", "SCENE_AMBIENT_COLOR");
		if ( hasParameter( material, "u_lightDirection" ) )
			material->setParameterAutoBinding("u_lightDirection", "SCENE_LIGHT_DIRECTION");
		if ( hasParameter( material, "u_lightColor" ) )
			material->setParameterAutoBinding("u_lightColor", "SCENE_LIGHT_COLOR");
	} else {
		//	カレントライトを反映させる
		gpobj *lgt;
		lgt = getObj( _curlight );
		light_node = lgt->_node;
		// ライトの方向設定
		if ( hasParameter( material, "u_lightDirection" ) )
			material->getParameter("u_lightDirection")->bindValue(light_node, &Node::getForwardVectorView);
		// ライトの色設定
		// (リアルタイムに変更を反映させる場合は再設定が必要。現在は未対応)
		Vector3 *vambient;
		vambient = (Vector3 *)&lgt->_vec[GPOBJ_USERVEC_WORK];
		if ( hasParameter( material, "u_lightColor" ) )
			material->getParameter("u_lightColor")->setValue(light_node->getLight()->getColor());
		if ( hasParameter( material, "u_ambientColor" ) )
			material->getParameter("u_ambientColor")->setValue( vambient );
	}

	//material->setParameterAutoBinding("u_ambientColor", "SCENE_AMBIENT_COLOR");
	//material->setParameterAutoBinding("u_lightDirection", "SCENE_LIGHT_DIRECTION");
	//material->setParameterAutoBinding("u_lightColor", "SCENE_LIGHT_COLOR");

	colorVector3( icolor, color );
	if ( hasParameter( material, "u_diffuseColor" ) )
		material->getParameter("u_diffuseColor")->setValue(color);

	gameplay::MaterialParameter *prm_modalpha;
	if ( hasParameter( material, "u_modulateAlpha" ) )
		prm_modalpha = material->getParameter("u_modulateAlpha");
	if ( prm_modalpha ) { prm_modalpha->setValue( 1.0f ); }

	RenderState::StateBlock *state;
	state = material->getStateBlock();

	state->setCullFace( (( matopt & GPOBJ_MATOPT_NOCULL )==0) );
	state->setDepthTest( (( matopt & GPOBJ_MATOPT_NOZTEST )==0) );
	state->setDepthWrite( (( matopt & GPOBJ_MATOPT_NOZWRITE )==0) );

	state->setBlend(true);
	if ( matopt & GPOBJ_MATOPT_BLENDADD ) {
		state->setBlendSrc(RenderState::BLEND_SRC_ALPHA);
		state->setBlendDst(RenderState::BLEND_ONE);
	} else {
		state->setBlendSrc(RenderState::BLEND_SRC_ALPHA);
		state->setBlendDst(RenderState::BLEND_ONE_MINUS_SRC_ALPHA);
	}

}


float gamehsp::setMaterialBlend( Material* material, int gmode, int gfrate )
{
	//	プレンド描画設定
	//	gmdoe : HSPのgmode値
	//	gfrate : HSPのgfrate値
	//	(戻り値=alpha値(0.0～1.0))
	//
	RenderState::StateBlock *state;
	float alpha;

	state = material->getStateBlock();

    //ブレンドモード設定
    switch( gmode ) {
        case 0:                     //no blend
			state->setBlendSrc(RenderState::BLEND_ONE);
			state->setBlendDst(RenderState::BLEND_ZERO);
			alpha = 1.0f;
            break;
        case 1:                     //blend+alpha one
        case 2:                     //blend+alpha one
			state->setBlendSrc(RenderState::BLEND_SRC_ALPHA);
			state->setBlendDst(RenderState::BLEND_ONE_MINUS_SRC_ALPHA);
			alpha = 1.0f;
            break;
        case 5:                     //add
			state->setBlendSrc(RenderState::BLEND_SRC_ALPHA);
			state->setBlendDst(RenderState::BLEND_ONE);
			alpha = ((float)gfrate) * _colrate;
            break;
        case 6:                     //sub
			state->setBlendSrc(RenderState::BLEND_ONE_MINUS_DST_COLOR);
			state->setBlendDst(RenderState::BLEND_ZERO);
			alpha = ((float)gfrate) * _colrate;
            break;
        default:                    //normal blend
			state->setBlendSrc(RenderState::BLEND_SRC_ALPHA);
			state->setBlendDst(RenderState::BLEND_ONE_MINUS_SRC_ALPHA);
			alpha = ((float)gfrate) * _colrate;
            break;
    }
	return alpha;
}


int gamehsp::makeNewMat( Material* material, int mode )
{
	gpmat *mat = addMat();
	if ( mat == NULL ) return -1;
	mat->_material = material;
	mat->_mode = mode;
	return mat->_id;
}


int gamehsp::makeNewMat2D( char *fname, int matopt )
{
	gpmat *mat = addMat();
	if ( mat == NULL ) return -1;

	Material *mesh_material = makeMaterialTex2D( fname, matopt );
	if ( mesh_material == NULL ) return -1;

    VertexFormat::Element elements[] =
    {
        VertexFormat::Element(VertexFormat::POSITION, 3),
        VertexFormat::Element(VertexFormat::TEXCOORD0, 2),
        VertexFormat::Element(VertexFormat::COLOR, 4)
    };

	unsigned int elementCount = sizeof(elements) / sizeof(VertexFormat::Element);
	MeshBatch *meshBatch = MeshBatch::create(VertexFormat(elements, elementCount), Mesh::TRIANGLE_STRIP, mesh_material, true, 16, 256 );

	mat->_mesh = meshBatch;
	mat->_material = mesh_material;
	mat->_mode = GPMAT_MODE_2D;
	mat->_sx = _tex_width;
	mat->_sy = _tex_height;
	mat->_texratex = 1.0f / (float)_tex_width;
	mat->_texratey = 1.0f / (float)_tex_height;
	return mat->_id;
}


Material *gamehsp::makeMaterialFromShader( char *vshd, char *fshd, char *defs )
{
	Material *material;
	material = Material::create( vshd, fshd, defs );
	if ( material == NULL ) {
		return NULL;
	}
	return material;
}


Material *gamehsp::makeMaterialColor( int color, int matopt )
{
	Material *material;
	if ( matopt & GPOBJ_MATOPT_NOLIGHT ) {
		material = makeMaterialFromShader( "res/shaders/colored-unlit.vert", "res/shaders/colored-unlit.frag", "MODULATE_ALPHA" );
	} else {
		material = makeMaterialFromShader( "res/shaders/colored.vert", "res/shaders/colored.frag", "MODULATE_ALPHA" );
	}
	if ( material == NULL ) return NULL;

	setMaterialDefaultBinding( material, color, matopt );
	return material;
}


Material *gamehsp::makeMaterialTexture( char *fname, int matopt )
{
	Material *material;
	bool mipmap;
	mipmap = (matopt & GPOBJ_MATOPT_NOMIPMAP ) == 0;

	if ( matopt & GPOBJ_MATOPT_NOLIGHT ) {
		material = makeMaterialFromShader( "res/shaders/textured-unlit.vert", "res/shaders/textured-unlit.frag", "MODULATE_ALPHA" );
	} else {
		material = makeMaterialFromShader( "res/shaders/textured.vert", "res/shaders/textured.frag", "MODULATE_ALPHA" );
	}
	if ( material == NULL ) return NULL;

	setMaterialDefaultBinding( material, -1, matopt );

	material->getParameter("u_diffuseTexture")->setValue( fname, mipmap );

	return material;
}


Material *gamehsp::makeMaterialTex2D( char *fname, int matopt )
{
	bool mipmap;
	mipmap = (matopt & GPOBJ_MATOPT_NOMIPMAP ) == 0;

    Texture* texture = Texture::create(fname);
	if ( texture == NULL ) {
        Alertf("Texture not found.(%s)",fname);
		return NULL;
	}
	_tex_width = texture->getWidth();
	_tex_height = texture->getHeight();

    // Search for the first sampler uniform in the effect.
    Uniform* samplerUniform = NULL;
    for (unsigned int i = 0, count = _spriteEffect->getUniformCount(); i < count; ++i)
    {
        Uniform* uniform = _spriteEffect->getUniform(i);
        if (uniform && uniform->getType() == GL_SAMPLER_2D)
        {
            samplerUniform = uniform;
            break;
        }
    }
    if (!samplerUniform)
    {
        GP_ERROR("No uniform of type GL_SAMPLER_2D found in sprite effect.");
        return NULL;
    }

	RenderState::StateBlock *state;

	// Wrap the effect in a material
    Material* mesh_material = Material::create(_spriteEffect); // +ref effect

    // Bind the texture to the material as a sampler
    Texture::Sampler* sampler = Texture::Sampler::create(texture); // +ref texture
    mesh_material->getParameter(samplerUniform->getName())->setValue(sampler);

	/*
	Material* mesh_material = Material::create( SPRITE_VSH, SPRITE_FSH, NULL );
	if ( mesh_material == NULL ) {
        GP_ERROR("2D initalize failed.");
		return NULL;
	}
	mesh_material->getParameter("u_diffuseTexture")->setValue( fname, mipmap );
	*/

	mesh_material->getParameter("u_projectionMatrix")->setValue(_projectionMatrix2D);

	state = mesh_material->getStateBlock();

	state->setCullFace(false);
	state->setDepthTest(false);
	state->setDepthWrite(false);
	state->setBlend(true);
	state->setBlendSrc(RenderState::BLEND_SRC_ALPHA);
	state->setBlendDst(RenderState::BLEND_ONE_MINUS_SRC_ALPHA);

	SAFE_RELEASE( texture );
	return mesh_material;
}


int gamehsp::getTextureWidth( void )
{
	return _tex_width;
}


int gamehsp::getTextureHeight( void )
{
	return _tex_height;
}

bool hasParameter( Material* material, const char* name )
{
	unsigned int mc = material->getTechniqueCount();
	for (unsigned int i = 0; i < mc; ++i)
	{
		Technique *tech = material->getTechniqueByIndex( i );
		unsigned int pc = tech->getPassCount();
		for (unsigned int j = 0; j < pc; ++j)
		{
			Pass *pass = tech->getPassByIndex(j);
			Effect *effect = pass->getEffect();
			if (effect->getUniform( name ) != NULL)
				return true;
		}
	}
	return false;
}
