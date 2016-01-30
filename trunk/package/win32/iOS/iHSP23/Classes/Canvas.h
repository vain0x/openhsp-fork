#import <UIKit/UIKit.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import <QuartzCore/CAEAGLLayer.h>

//Canvasの実装
@interface Canvas : UIView {    
    //描画
    EAGLContext* _context;        //コンテキスト
    GLint        _bgWidth;        //背景幅
    GLint        _bgHeight;       //背景高さ
    GLuint       _viewRenderBuff; //レンダーバッファ
    GLuint       _viewFrameBuff;  //フレームバッファ
    GLuint       _depthRenderBuff;//デプスレンダーバッファ
    BOOL         _initFlag;       //初期化フラグ
@private
    //アニメ
    NSTimer* _animeTimer;//アニメタイマー
}

//描画
@property(readonly) GLint bgWidth;
@property(readonly) GLint bgHeight;
@property (nonatomic,retain) EAGLContext *context;
@property (nonatomic,assign) NSTimer     *animeTimer;
@property(readonly) GLuint viewRenderBuff;
@property(readonly) GLuint viewFrameBuff;

//描画
- (void)setup;
- (void)onTick;

//アニメ
- (void)startFrame:(float)fps;
- (void)stopFrame;
@end
