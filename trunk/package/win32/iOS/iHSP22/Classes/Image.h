#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import <QuartzCore/QuartzCore.h>

//Imageの宣言
@interface Image : NSObject {
    unsigned char* _data;  //データ
    GLuint         _name;  //名前
    int            _width; //幅
    int            _height;//高さ
    int            _sizex; //テクスチャの幅
    int            _sizey;//テクスチャの高さ
    float          _ratex;
    float          _ratey;
}

//プロパティ
@property unsigned char* data;
@property GLuint         name;
@property int            width;
@property int            height;
@property int            sizex;
@property int            sizey;
@property float          ratex;
@property float          ratey;

- (void)deletTexture;

//イメージの生成
+ (Image*)makeImage:(UIImage*)image;
+ (Image*)makeTextImage:(NSString*)text 
    font:(UIFont*)font color:(UIColor*)color;
+ (Image*)makeImageFromFile:(NSString *)fname;
@end
