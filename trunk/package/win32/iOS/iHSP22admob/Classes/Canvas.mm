#import "Canvas.h"

#define USE_DEPTH_BUFFER 0

//Canvasのプライベートメソッド
@interface Canvas ()
- (BOOL)createFrameBuff;
- (void)destroyFrameBuff;
- (void)drawView;
@end


//Canvasの実装
@implementation Canvas

//描画
@synthesize context   =_context;
@synthesize animeTimer=_animeTimer;
@synthesize bgWidth   =_bgWidth;
@synthesize bgHeight  =_bgHeight;


//====================
//初期化
//====================
//レイヤーの取得
+ (Class)layerClass {
    return [CAEAGLLayer class];
}

//初期化
- (id)init {
    if ((self=[super init])) {
        _initFlag=NO;
    }
    return self;
}

//フレームの初期化
- (id)initWithFrame:(CGRect)frame {
    if (self=[super initWithFrame:frame]) {
        //レイヤーの生成
        CAEAGLLayer* eaglLayer=(CAEAGLLayer*)self.layer;
        eaglLayer.opaque=YES;
        eaglLayer.drawableProperties=[NSDictionary dictionaryWithObjectsAndKeys:
            [NSNumber numberWithBool:NO], 
            kEAGLDrawablePropertyRetainedBacking, 
            kEAGLColorFormatRGBA8, 
            kEAGLDrawablePropertyColorFormat, 
            nil];
        
        //コンテキストの生成
        _context=[[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
        if (!_context || ![EAGLContext setCurrentContext:_context]) {
            [self release];
            return nil;
        }

        //アニメ
        _animeTimer=nil;
    }
    return self;
}

//メモリの解放
- (void)dealloc {
    //描画    
    if ([EAGLContext currentContext]==_context) {
        [EAGLContext setCurrentContext:nil];
    }    
    [_context release];
    
    //アニメ
    [_animeTimer release];
    [super dealloc];
}


//====================
//描画
//====================
//ビューの描画
- (void)drawView {
    //前処理
    //[EAGLContext setCurrentContext:_context];
    //glBindFramebufferOES(GL_FRAMEBUFFER_OES,_viewFrameBuff);

    //描画
    if (!_initFlag) {
        [self setup];
        _initFlag=YES;
    }
    [self onTick];
    
    //後処理
    //glBindRenderbufferOES(GL_RENDERBUFFER_OES,_viewRenderBuff);
    //[_context presentRenderbuffer:GL_RENDERBUFFER_OES];
}

//セットアップ(オーバーライド用)
- (void)setup {
}

//定期処理(オーバーライド用)
- (void)onTick {
}

//サブビューのレイアウト
- (void)layoutSubviews {
    [EAGLContext setCurrentContext:_context];
    [self destroyFrameBuff];
    [self createFrameBuff];
    [self drawView];
}

//フレームバッファの生成
- (BOOL)createFrameBuff {
    glGenFramebuffersOES(1,&_viewFrameBuff);
    glGenRenderbuffersOES(1,&_viewRenderBuff);
    glBindFramebufferOES(GL_FRAMEBUFFER_OES,_viewFrameBuff);
    glBindRenderbufferOES(GL_RENDERBUFFER_OES,_viewRenderBuff);
    [_context renderbufferStorage:GL_RENDERBUFFER_OES fromDrawable:(CAEAGLLayer*)self.layer];
    glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES,
        GL_COLOR_ATTACHMENT0_OES,GL_RENDERBUFFER_OES,_viewRenderBuff);   
    glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES,GL_RENDERBUFFER_WIDTH_OES,&_bgWidth);
    glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES,GL_RENDERBUFFER_HEIGHT_OES,&_bgHeight);
    if (USE_DEPTH_BUFFER) {
        glGenRenderbuffersOES(1,&_depthRenderBuff);
        glBindRenderbufferOES(GL_RENDERBUFFER_OES,_depthRenderBuff);
        glRenderbufferStorageOES(GL_RENDERBUFFER_OES,
            GL_DEPTH_COMPONENT16_OES,_bgWidth,_bgHeight);
        glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES,
            GL_DEPTH_ATTACHMENT_OES,GL_RENDERBUFFER_OES,_depthRenderBuff);
    }
    if(glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES)!=GL_FRAMEBUFFER_COMPLETE_OES) {
        return NO;
    }
    return YES;
}

//フレームバッファの破棄
- (void)destroyFrameBuff {    
    glDeleteFramebuffersOES(1,&_viewFrameBuff);
    _viewFrameBuff=0;
    glDeleteRenderbuffersOES(1,&_viewRenderBuff);
    _viewRenderBuff=0;    
    if (_depthRenderBuff) {
        glDeleteRenderbuffersOES(1,&_depthRenderBuff);
        _depthRenderBuff=0;
    }
}


//====================
//アニメ
//====================
- (void)startFrame:(float)fps {
    [self stopFrame];
    self.animeTimer=[NSTimer scheduledTimerWithTimeInterval:1.0f/fps 
        target:self selector:@selector(drawView)userInfo:nil repeats:YES];
}

//アニメの停止
- (void)stopFrame {
    if (_animeTimer!=nil) {
        [_animeTimer invalidate];
        self.animeTimer=nil;
    }
}
@end
