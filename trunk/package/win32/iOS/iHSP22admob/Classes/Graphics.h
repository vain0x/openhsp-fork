#import "Image.h"

//テキストバッファ
#define TEXT_BUFF 32

//色
#define rgba(red,green,blue,alpha) [Graphics makeColor_r:red g:green b:blue a:alpha]
#define rgb(red,green,blue) [Graphics makeColor_r:red g:green b:blue a:255]

//色定数
#define GRAPHICS_AQUA    rgb(0,255,255)       
#define GRAPHICS_BLACK   rgb(0,0,0)            
#define GRAPHICS_BLUE    rgb(0,0,55)            
#define GRAPHICS_FUCHSIA rgb(255,0,255)            
#define GRAPHICS_GRAY    rgb(128,128,128)             
#define GRAPHICS_GREEN   rgb(0,128,0)            
#define GRAPHICS_LIME    rgb(0,255,0)            
#define GRAPHICS_MAROON  rgb(128,0,0)            
#define GRAPHICS_NAVY    rgb(0,0,128)            
#define GRAPHICS_OLIVE   rgb(128,128,0)            
#define GRAPHICS_PURPLE  rgb(128,0,128)
#define GRAPHICS_RED     rgb(255,0,0)
#define GRAPHICS_SILVER  rgb(192,192,192)
#define GRAPHICS_TEAL    rgb(0,128,128)
#define GRAPHICS_WHITE   rgb(255,255,255)
#define GRAPHICS_YELLOW  rgb(255,255,0)

//フリップ定数
#define GRAPHICS_FLIP_NONE       -1        
#define GRAPHICS_FLIP_HORIZONTAL  0
#define GRAPHICS_FLIP_VERTICAL    2

//色
typedef struct{
    int r;
    int g;
    int b;
    int a;
} Color;
                
//Graphicsの宣言
@interface Graphics : NSObject {
@private
    //サイズ
    CGSize _bgSize;//背景サイズ

    //グラフィックス設定
    Color _color;   //色
    int   _flipMode;//フリップ
    int   _originX; //原点X
    int   _originY; //原点Y
    GLint  _filter;
    
    //文字列設定
    int                  _fontSize;//フォントサイズ
    NSMutableDictionary* _textMap; //テキストマップ
    NSMutableArray*      _textList;//テキストリスト
}

//初期化
- (void)initSize:(CGSize)size;
- (void)clear;
- (void)clear_r:(int)rval g:(int)gbal b:(int)bval;

//クリッピング
- (void)clipRect_x:(GLfloat)x y:(GLfloat)y w:(GLfloat)w h:(GLfloat)h;
- (void)clearClip;

//色
- (void)setColor:(Color)color;
+ (Color)makeColor_r:(int)r g:(int)g b:(int)b a:(int)a;

//グラフィックス設定
- (void)setLineWidth:(int)lineWidth;
- (void)setFlipMode:(int)flipMode;
- (void)setFilterMode:(int)mode;
- (void)setOrigin_x:(int)x y:(int)y;
- (void)setBlendMode:(int)mode alpha:(int)aval;
- (void)setBlendModeFlat:(int)mode;
- (void)setColorVertex:(int)color alpha:(int)aval;

//文字列設定
- (void)setFontSize:(int)fontSize;
- (int)getFontSize;
- (int)stringWidth:(NSString*)text;
- (int)stringHeight:(NSString*)text;

//描画
- (void)drawLine_x0:(int)x0 y0:(int)y0 x1:(int)x1 y1:(int)y1;
- (void)drawRect_x:(int)x y:(int)y w:(int)w h:(int)h;
- (void)fillRect_x:(int)x y:(int)y w:(int)w h:(int)h;
- (void)drawCircle_x:(float)x y:(float)y rx:(float)rx ry:(float)ry;
- (void)fillCircle_x:(float)x y:(float)y rx:(float)rx ry:(float)ry;
- (void)drawImage:(Image*)image x:(int)x y:(int)y;
- (void)drawScaledImage:(Image*)image 
    x:(int)x y:(int)y w:(int)w h:(int)h
    sx:(int)sx sy:(int)sy sw:(int)sw sh:(int)sh;
- (void)drawScaledFlipImage:(Image*)image 
					  x:(int)x y:(int)y w:(int)w h:(int)h
					 sx:(int)sx sy:(int)sy sw:(int)sw sh:(int)sh;
- (void)drawImageClipped:(Image*)image x:(int)x y:(int)y sx:(int)sx sy:(int)sy sw:(int)sw sh:(int)sh;
- (void)drawString:(NSString*)text x:(int)x y:(int)y;
@end
