#import "Graphics.h"

//テクスチャ頂点情報
GLfloat panelVertices[]={
     0,  0, //左上
     0, -1, //左下
     1,  0, //右上
     1, -1, //右下
};

//テクスチャUV情報
const GLfloat panelUVs[]={
    0.0f, 0.0f, //左上
    0.0f, 1.0f, //左下
    1.0f, 0.0f, //右上
    1.0f, 1.0f, //右下
};

static GLbyte panelColors[]={
    0xff, 0xff, 0xff, 0xff,
    0xff, 0xff, 0xff, 0xff,
    0xff, 0xff, 0xff, 0xff,
    0xff, 0xff, 0xff, 0xff,
};

#define FVAL_BYTE1 (1.0f/256.0f)

//Graphicsの実装
@implementation Graphics



//====================
//初期化
//====================
//初期化
- (id)init {
    if (self=[super init]) {
        //背景サイズ
        _bgSize=CGSizeMake(320,480);
          
        //色
        _color=GRAPHICS_BLACK;
        
        //グラフィックス設定
        _flipMode=GRAPHICS_FLIP_NONE;
        _originX =0;
        _originY =0;
        _filter = GL_NEAREST;
        //文字列設定
        _fontSize=12;
        _textList=[[NSMutableArray alloc] init];
        _textMap =[[NSMutableDictionary alloc] init];
    }
    return self;
}

//メモリ解放
- (void)dealloc {
    [_textList release];
    [_textMap release];
    [super dealloc];
}

//初期化
- (void)initSize:(CGSize)size {    
    _bgSize=size;

    //ビューポート変換
    //glViewport(0,0,_bgSize.width,_bgSize.height);
    
    //投影変換
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
//    glOrthof(-_bgSize.width/2,_bgSize.width/2,
//        -_bgSize.height/2,_bgSize.height/2,-100,100);
//    glTranslatef(-_bgSize.width/2,_bgSize.height/2,0);
/*
    //モデリング変換    
    glMatrixMode(GL_MODELVIEW);
*/
    //クリア色の設定
    glClearColor(0,0,0,1);
    
    //頂点配列の設定
    glVertexPointer(2,GL_FLOAT,0,panelVertices);
    glEnableClientState(GL_VERTEX_ARRAY);

    //UVの設定
    glTexCoordPointer(2,GL_FLOAT,0,panelUVs);
        
    //テクスチャの設定
    glEnableClientState(GL_TEXTURE_COORD_ARRAY);
    glEnable(GL_TEXTURE_2D);
        
    //ブレンドの設定
    glEnable(GL_BLEND);
    glBlendEquationOES(GL_FUNC_ADD_OES);
    glBlendFunc(GL_ONE,GL_ONE_MINUS_SRC_ALPHA);

    //ポイントの設定
    glEnable(GL_POINT_SMOOTH);
    
    glCullFace(GL_FRONT_AND_BACK);
}

//クリア
- (void)clear {
    //クリア色の設定
    glClear(GL_COLOR_BUFFER_BIT); 
}

- (void)clear_r:(int)rval g:(int)gval b:(int)bval
{
    glClearColor((GLclampf)(FVAL_BYTE1 * (float)rval), (GLclampf)(FVAL_BYTE1 * (float)gval), (GLclampf)(FVAL_BYTE1 * (float)bval), 1 );
}

- (void)setFilterMode:(int)mode {
    switch( mode ) {
        case 0:
            _filter = GL_NEAREST;
            break;
        default:
            _filter = GL_LINEAR;
            break;
    }
}


- (void)setBlendMode:(int)mode alpha:(int)aval {
    //ブレンドモード設定
    switch( mode ) {
        case 0:                     //no blend
            glDisable(GL_BLEND);
            break;
        case 3:                     //blend+alpha
        case 4:                     //blend+alpha
            glEnable(GL_BLEND);
            glBlendEquationOES(GL_FUNC_ADD_OES);
            glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
            break;
        case 5:                     //add
            glEnable(GL_BLEND);
            glBlendEquationOES(GL_FUNC_ADD_OES);
            glBlendFunc(GL_SRC_ALPHA,GL_ONE);
            break;
        case 6:                     //sub
            glEnable(GL_BLEND);
            glBlendEquationOES(GL_FUNC_REVERSE_SUBTRACT_OES);
            glBlendFunc(GL_SRC_ALPHA,GL_ONE);
            break;
        default:                    //normal blend
            glEnable(GL_BLEND);
            glBlendEquationOES(GL_FUNC_ADD_OES);
            glBlendFunc(GL_ONE,GL_ONE_MINUS_SRC_ALPHA);
            break;
    }
    if ( mode >= 3 ) {
        panelColors[3] = panelColors[4+3] = panelColors[8+3] = panelColors[12+3] = aval;
        glEnableClientState(GL_COLOR_ARRAY);
        glColorPointer(4,GL_UNSIGNED_BYTE,0,panelColors);
    } else {
        glDisableClientState(GL_COLOR_ARRAY);
    }

    glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,_filter); 
    glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,_filter); 
}


- (void)setBlendModeFlat:(int)mode{
    //ブレンドモード設定
    switch( mode ) {
        case 0:                     //no blend
            glDisable(GL_BLEND);
            break;
        case 3:                     //blend+alpha
        case 4:                     //blend+alpha
            glEnable(GL_BLEND);
            glBlendEquationOES(GL_FUNC_ADD_OES);
            glBlendFunc(GL_ONE,GL_ONE_MINUS_SRC_ALPHA);
            break;
        case 5:                     //add
            glEnable(GL_BLEND);
            glBlendEquationOES(GL_FUNC_ADD_OES);
            glBlendFunc(GL_SRC_ALPHA,GL_ONE);
            break;
        case 6:                     //sub
            glEnable(GL_BLEND);
            glBlendEquationOES(GL_FUNC_REVERSE_SUBTRACT_OES);
            glBlendFunc(GL_SRC_ALPHA,GL_ONE);
            break;
        default:                    //normal blend
            glEnable(GL_BLEND);
            glBlendEquationOES(GL_FUNC_ADD_OES);
            glBlendFunc(GL_ONE,GL_ONE_MINUS_SRC_ALPHA);
            break;
    }
}


//====================
//クリッピング
//====================
//クリッピングの指定
- (void)clipRect_x:(GLfloat)x y:(GLfloat)y w:(GLfloat)w h:(GLfloat)h {
    GLfloat area0[4]={ 0,-1, 0,-y  };
    GLfloat area1[4]={ 0, 1, 0, y+h};
    GLfloat area2[4]={ 1, 0, 0,-x  };
    GLfloat area3[4]={-1, 0, 0, x+w};
    glClipPlanef(GL_CLIP_PLANE0,area0);
    glClipPlanef(GL_CLIP_PLANE1,area1);
    glClipPlanef(GL_CLIP_PLANE2,area2);
    glClipPlanef(GL_CLIP_PLANE3,area3);
    glEnable(GL_CLIP_PLANE0);
    glEnable(GL_CLIP_PLANE1);
    glEnable(GL_CLIP_PLANE2);
    glEnable(GL_CLIP_PLANE3);
}

//クリッピングのクリア
- (void)clearClip {
    glDisable(GL_CLIP_PLANE0);
    glDisable(GL_CLIP_PLANE1);
    glDisable(GL_CLIP_PLANE2);
    glDisable(GL_CLIP_PLANE3);
}


//====================
//色
//====================
//色の指定
- (void)setColor:(Color)color {
    _color=color;
}

//色の生成
+ (Color)makeColor_r:(int)r g:(int)g b:(int)b a:(int)a {
    Color color;
    color.r=r;
    color.g=g;
    color.b=b;
    color.a=a;
    return color;
}


//====================
//グラフィックス設定
//====================
//ライン幅の指定
- (void)setLineWidth:(int)lineWidth {
    glLineWidth(lineWidth);
    glPointSize(lineWidth*0.6f);
}

//フリップモードの指定
- (void)setFlipMode:(int)flipMode {
    _flipMode=flipMode;
}

//原点の指定
/*
- (void)setOrigin_x:(int)x y:(int)y {
    _originX=x;
    _originY=y;
}
*/

//====================
//文字列設定
//====================
//フォントサイズの指定
- (void)setFontSize:(int)fontSize {
    _fontSize=fontSize;			
}
        
//フォントサイズの取得
- (int)getFontSize {
    return _fontSize;
}

//文字列幅の取得
- (int)stringWidth:(NSString*)text {
    return [text sizeWithFont:[UIFont systemFontOfSize:_fontSize]].width;  
}

//文字列高さの取得
- (int)stringHeight:(NSString*)text {
    return [text sizeWithFont:[UIFont systemFontOfSize:_fontSize]].height;  
}


//====================
//描画
//====================
//
- (void)setColorVertex:(int)color alpha:(int)aval {

    int rval,gval,bval;
    rval = (color>>16)&0xff;
    gval = (color>>8)&0xff;
    bval = (color)&0xff;
    
    for (int i=0;i<4;i++) {
        panelColors[i*4  ]=rval;
        panelColors[i*4+1]=gval;
        panelColors[i*4+2]=bval;
        panelColors[i*4+3]=aval;
    }
    glEnableClientState(GL_COLOR_ARRAY);
    glColorPointer(4,GL_UNSIGNED_BYTE,0,panelColors);
}

//ラインの描画
- (void)drawLine_x0:(int)x0 y0:(int)y0 x1:(int)x1 y1:(int)y1 {
    GLfloat _vertexs[256*3];
    GLbyte  _colors[256*4];

     //頂点配列情報
     _vertexs[0]= x0;_vertexs[1]=-y0;_vertexs[2]=0;
     _vertexs[3]= x1;_vertexs[4]=-y1;_vertexs[5]=0;     
     
     //カラー配列情報
     for (int i=0;i<2;i++) {
         _colors[i*4  ]=_color.r;
         _colors[i*4+1]=_color.g;
         _colors[i*4+2]=_color.b;
         _colors[i*4+3]=_color.a;
     }

    //ラインの描画
    [self setBlendModeFlat:0];
    glBindTexture(GL_TEXTURE_2D,0);
    glEnableClientState(GL_COLOR_ARRAY);
    glVertexPointer(3,GL_FLOAT,0,_vertexs);
    glColorPointer(4,GL_UNSIGNED_BYTE,0,_colors);
    glPushMatrix();
        glTranslatef(_originX,-_originY,0);
        glDrawArrays(GL_LINE_STRIP,0,2);
    glPopMatrix();
}

//矩形の描画
- (void)drawRect_x:(int)x y:(int)y w:(int)w h:(int)h {
    GLfloat _vertexs[256*3];
    GLbyte  _colors[256*4];

    //頂点配列情報
    _vertexs[0]= x;  _vertexs[1] =-y;  _vertexs[2] =0;
    _vertexs[3]= x;  _vertexs[4] =-y-h;_vertexs[5] =0;  
    _vertexs[6]= x+w;_vertexs[7] =-y-h;_vertexs[8] =0;
    _vertexs[9]= x+w;_vertexs[10]=-y;  _vertexs[11]=0;  
     
    //カラー配列情報
    for (int i=0;i<4;i++) {
        _colors[i*4  ]=_color.r;
        _colors[i*4+1]=_color.g;
        _colors[i*4+2]=_color.b;
        _colors[i*4+3]=_color.a;
    }

    //ラインの描画
    [self setBlendModeFlat:0];
    glBindTexture(GL_TEXTURE_2D,0);
    glEnableClientState(GL_COLOR_ARRAY);
    glVertexPointer(3,GL_FLOAT,0,_vertexs);
    glColorPointer(4,GL_UNSIGNED_BYTE,0,_colors);
    glPushMatrix();
        glTranslatef(_originX,-_originY,0);
        glDrawArrays(GL_LINE_LOOP,0,4);
    glPopMatrix();
}

//矩形の塗り潰し
- (void)fillRect_x:(int)x y:(int)y w:(int)w h:(int)h {
    GLfloat _vertexs[256*3];
    GLbyte  _colors[256*4];

     //頂点配列情報
     _vertexs[0]= x;  _vertexs[1] =-y;  _vertexs[2] =0;
     _vertexs[3]= x;  _vertexs[4] =-y-h;_vertexs[5] =0;  
     _vertexs[6]= x+w;_vertexs[7] =-y;  _vertexs[8] =0;
     _vertexs[9]= x+w;_vertexs[10]=-y-h;_vertexs[11]=0;  
     
     //カラー配列情報
     for (int i=0;i<4;i++) {
         _colors[i*4  ]=_color.r;
         _colors[i*4+1]=_color.g;
         _colors[i*4+2]=_color.b;
         _colors[i*4+3]=_color.a;
     }

    //三角形の描画
    [self setBlendModeFlat:0];
    glBindTexture(GL_TEXTURE_2D,0);
    glEnableClientState(GL_COLOR_ARRAY);
    glVertexPointer(3,GL_FLOAT,0,_vertexs);
    glColorPointer(4,GL_UNSIGNED_BYTE,0,_colors);
    glPushMatrix();
        glTranslatef(_originX,-_originY,0);
        glDrawArrays(GL_TRIANGLE_STRIP,0,4);
    glPopMatrix();
}

//円の描画
- (void)drawCircle_x:(float)x y:(float)y rx:(float)rx ry:(float)ry {
    GLfloat _vertexs[256*3];
    GLbyte  _colors[256*4];
    int length=16;
    
     //頂点配列情報
     for (int i=0;i<length;i++) {
         float angle=2*M_PI*i/length;
         _vertexs[i*3+0]= x+cos(angle)*rx;
         _vertexs[i*3+1]=-y+sin(angle)*ry;
         _vertexs[i*3+2]=0;
     }
     
     //カラー配列情報
     for (int i=0;i<length;i++) {
         _colors[i*4  ]=_color.r;
         _colors[i*4+1]=_color.g;
         _colors[i*4+2]=_color.b;
         _colors[i*4+3]=_color.a;
     }

    //ラインの描画
    [self setBlendModeFlat:0];
    glBindTexture(GL_TEXTURE_2D,0);
    glEnableClientState(GL_COLOR_ARRAY);
    glVertexPointer(3,GL_FLOAT,0,_vertexs);
    glColorPointer(4,GL_UNSIGNED_BYTE,0,_colors);
    glPushMatrix();
        glTranslatef(_originX,-_originY,0);
        glDrawArrays(GL_LINE_LOOP,0,length);
        glDrawArrays(GL_POINTS,0,length);
    glPopMatrix();
}

//円の塗り潰し
- (void)fillCircle_x:(float)x y:(float)y rx:(float)rx ry:(float)ry {
    GLfloat _vertexs[256*3];
    GLbyte  _colors[256*4];
    int length=16+2;
    
     //頂点配列情報
     _vertexs[0]= x;
     _vertexs[1]=-y;
     _vertexs[2]=0;
     for (int i=1;i<length;i++) {
         float angle=2*M_PI*i/(length-2);
         _vertexs[i*3+0]= x+cos(angle)*rx;
         _vertexs[i*3+1]=-y+sin(angle)*ry;
         _vertexs[i*3+2]=0;
     }
     
     //カラー配列情報
     for (int i=0;i<length;i++) {
         _colors[i*4  ]=_color.r;
         _colors[i*4+1]=_color.g;
         _colors[i*4+2]=_color.b;
         _colors[i*4+3]=_color.a;
     }

    //ラインの描画
    [self setBlendModeFlat:0];
    glBindTexture(GL_TEXTURE_2D,0);
    glEnableClientState(GL_COLOR_ARRAY);
    glVertexPointer(3,GL_FLOAT,0,_vertexs);
    glColorPointer(4,GL_UNSIGNED_BYTE,0,_colors);
    glPushMatrix();
        glTranslatef(_originX,-_originY,0);
        glDrawArrays(GL_TRIANGLE_FAN,0,length);
    glPopMatrix();
}

//イメージの描画
- (void)drawImage:(Image*)image x:(int)x y:(int)y {
    if (image==nil) return;
    int dx=_originX+x;
    int dy=_originY+y;
    int dw=image.sizex;
    int dh=image.sizey;
#if 0
    if (_flipMode==GRAPHICS_FLIP_HORIZONTAL) {
        dx+=image.width;
        dw=-image.width;
    } else if (_flipMode==GRAPHICS_FLIP_VERTICAL) {
        dy+=image.height;
        dh=-image.height;
    }
#endif
    [self setBlendMode:1 alpha:0];
    glBindTexture(GL_TEXTURE_2D,image.name);
    glVertexPointer(2,GL_FLOAT,0,panelVertices);
    glDisableClientState(GL_COLOR_ARRAY);
    glPushMatrix();
        glTranslatef(dx,-dy,0);
        glScalef(dw,dh,1);
        glDrawArrays(GL_TRIANGLE_STRIP,0,4);
    glPopMatrix();
}

//イメージの描画
- (void)drawScaledFlipImage:(Image*)image
    x:(int)x y:(int)y w:(int)w h:(int)h
    sx:(int)sx sy:(int)sy sw:(int)sw sh:(int)sh {    

    int xx,yy,dw,dh,dx,dy,ww,hh;
	
	if (image==nil) return;
#if 0
    if (_flipMode==GRAPHICS_FLIP_HORIZONTAL) {
        sx=image.width-sw-sx;
    } else if (_flipMode==GRAPHICS_FLIP_VERTICAL) {
        sy=image.height-sh-sy;
    }
#endif

	xx = x;
    if ( w >= 0 ) {
		ww = w;
		dw = image.width*ww/sw;
		dx = _originX+x-sx*ww/sw;
	} else {
		ww = -w;
		xx += w;
        sx = image.width-sw-sx;
		dw = image.width*ww/sw;
		dx = _originX+xx-sx*ww/sw;
        dx+=dw;
        dw=-dw;
	}

	yy = y;
	if ( h >= 0 ) {
		hh = h;
		dh = image.height*hh/sh;
		dy = _originY+y-sy*hh/sh;
	} else {
		hh = -h;
		yy += h;
        sy=image.height-sh-sy;
		dh = image.height*hh/sh;
		dy = _originY+yy-sy*hh/sh;
        dy+=dh;
        dh=-dh;
	}


#if 0
    if (_flipMode==GRAPHICS_FLIP_HORIZONTAL) {
        dx+=dw;
        dw=-dw;
    } else if (_flipMode==GRAPHICS_FLIP_VERTICAL) {
        dy+=dh;
        dh=-dh;
    }
#endif
    [self setBlendMode:1 alpha:0];
    [self clipRect_x:_originX+xx y:_originY+yy w:ww h:hh];
    glBindTexture(GL_TEXTURE_2D,image.name);
    glVertexPointer(2,GL_FLOAT,0,panelVertices);
    glTexCoordPointer(2,GL_FLOAT,0,panelUVs);
    glDisableClientState(GL_COLOR_ARRAY);
    glPushMatrix();
        glTranslatef(dx,-dy,0);
        glScalef(dw,dh,1);
        glDrawArrays(GL_TRIANGLE_STRIP,0,4);
    glPopMatrix();
    [self clearClip];
}


//イメージの描画
- (void)drawScaledImage:(Image*)image
					  x:(int)x y:(int)y w:(int)w h:(int)h
					 sx:(int)sx sy:(int)sy sw:(int)sw sh:(int)sh {    
	
    int dw,dh,dx,dy;
	
	if (image==nil) return;
    
	dw = image.width*w/sw;
    dx = _originX+x-sx*w/sw;
	
    dh = image.height*h/sh;
    dy = _originY+y-sy*h/sh;
	
    [self setBlendMode:1 alpha:0];
    [self clipRect_x:_originX+x y:_originY+y w:w h:h];
    glBindTexture(GL_TEXTURE_2D,image.name);
    glVertexPointer(2,GL_FLOAT,0,panelVertices);
    glTexCoordPointer(2,GL_FLOAT,0,panelUVs);
    glDisableClientState(GL_COLOR_ARRAY);
    glPushMatrix();
	glTranslatef(dx,-dy,0);
	glScalef(dw,dh,1);
	glDrawArrays(GL_TRIANGLE_STRIP,0,4);
    glPopMatrix();
    [self clearClip];
}


//イメージの描画
- (void)drawImageClipped:(Image*)image x:(int)x y:(int)y sx:(int)sx sy:(int)sy sw:(int)sw sh:(int)sh {
    if (image==nil) return;
    int dx=_originX+x;
    int dy=_originY+y;
    int dw=image.width;
    int dh=image.height;

    [self setBlendMode:1 alpha:0];
    glBindTexture(GL_TEXTURE_2D,image.name);
    glVertexPointer(2,GL_FLOAT,0,panelVertices);
    glTexCoordPointer(2,GL_FLOAT,0,panelUVs);
    glDisableClientState(GL_COLOR_ARRAY);
    glPushMatrix();
	glTranslatef(dx,-dy,0);
	glScalef(dw,dh,1);
	glDrawArrays(GL_TRIANGLE_STRIP,0,4);
    glPopMatrix();
}



//テキストイメージの生成
- (Image*)makeTextImage:(NSString*)text {
    NSString* key=[NSString stringWithFormat:@"%d,%d,%d,%d,%d,%@",
        _fontSize,_color.r,_color.g,_color.b,_color.a,text];
    
    //イメージの取得
    Image* image=[_textMap objectForKey:key];
    if (image!=nil) {
        [_textList removeObject:key];
        [_textList insertObject:key atIndex:0];
        return image;
    }
    
    //イメージの生成
    image=[Image makeTextImage:text
        font:[UIFont systemFontOfSize:_fontSize] 
        color:[UIColor colorWithRed:_color.r/255.0f green:_color.g/255.0f 
        blue:_color.b/255.0f alpha:_color.a/255.0f]];
    //image.sizex =image.sizex/2;
    //image.sizey=image.sizey/2;
    [_textMap setObject:image forKey:key];
    [_textList insertObject:key atIndex:0];
        
    //イメージの削除
    if (_textList.count>TEXT_BUFF) {
        key=[_textList objectAtIndex:_textList.count-1];
        
        Image *old_image;
        old_image = [_textMap objectForKey:key];
        [old_image deletTexture];
        
        [_textMap removeObjectForKey:key];
        [_textList removeObjectAtIndex:_textList.count-1];
    }
    return image;
}

//文字列の描画
- (void)drawString:(NSString*)text x:(int)x y:(int)y {

    Image *img;
    img = [self makeTextImage:text];
    [self drawImage:img x:x y:y];
}
@end
