#import "Image.h"
//#include "stb_image_custom.h"

//Imageの実装
@implementation Image

//シンセサイズ
@synthesize data  =_data;
@synthesize name  =_name;
@synthesize width =_width;
@synthesize height=_height;
@synthesize ratex=_ratex;
@synthesize ratey=_ratey;
@synthesize sizex=_sizex;
@synthesize sizey=_sizey;

//====================
//初期化
//====================
//初期化
- (id)init {
    if ((self=[super init])) {
        _data  =NULL;
        _name  =0;
        _width =0;
        _height=0;
        _sizex =0;
        _sizey =0;
        _ratex =1.0f;
        _ratey =1.0f;
    }
    return self;
}

//メモリ解放
- (void)dealloc {
    GLuint num=self.name;
    glBindTexture(GL_TEXTURE_2D,0);
    if (num!=0) {
        glDeleteTextures(1,&num);
    }
    if (_data!=NULL) free(_data);    
    [super dealloc];
}

- (void)deletTexture {
    GLuint num=self.name;
    if (num!=0) {
        glBindTexture(GL_TEXTURE_2D,0);
        glDeleteTextures(1,&num);
        self.name = 0;
    }
    if (_data!=NULL) {
        free(_data);
        _data=NULL;
    }
}


//====================
//イメージの生成
//====================
//テクスチャの生成
+ (BOOL)makeTeture:(UIImage*)image toOutput:(unsigned char**)textureData 
    andImageSizeX:(int*)pImageSizeX andImageSizeY:(int*)pImageSizeY
    andImageWidth:(int*)pImageWidth andImageHeight:(int*)pImageHeight {
    CGImageRef       imageRef;
    NSUInteger       i;
    int              textureSizeX;
    int              textureSizeY;
    int              imageWidth;
    int              imageHeight;
    CGContextRef     context;
    CGColorSpaceRef  colorSpace;
    BOOL             hasAlpha;
    size_t           bitsPerComponent;
    CGImageAlphaInfo info;
    if (!image) return NO;

    //イメージ情報の取得
    imageRef=[image CGImage];   
    imageWidth=CGImageGetWidth(imageRef);
    imageHeight=CGImageGetHeight(imageRef);
    for (i=1;i<=2048;i*=2) {
        if (i>=imageWidth) {
            textureSizeX=i;
            break;
        }
    }
    for (i=1;i<=2048;i*=2) {
        if (i>=imageHeight) {
            textureSizeY=i;
            break;
        }
    }

    *pImageSizeX  =textureSizeX;
    *pImageSizeY  =textureSizeY;
    *pImageWidth  =imageWidth;
    *pImageHeight =imageHeight;
    info=CGImageGetAlphaInfo(imageRef);
    
    //アルファ成分チェック
    hasAlpha=((info==kCGImageAlphaPremultipliedLast) || 
        (info==kCGImageAlphaPremultipliedFirst) || 
        (info==kCGImageAlphaLast) || 
        (info==kCGImageAlphaFirst)?YES:NO);
    colorSpace=CGColorSpaceCreateDeviceRGB();
    *textureData=(unsigned char*)malloc(textureSizeX*textureSizeY*4);
    if (!*textureData) {
		CGColorSpaceRelease(colorSpace);
		return NO;
    }
	if (hasAlpha) {
        bitsPerComponent=kCGImageAlphaPremultipliedLast;
    } else {
        bitsPerComponent=kCGImageAlphaNoneSkipLast;
    }
    context=CGBitmapContextCreate(*textureData,textureSizeX,textureSizeY, 
        8,4*textureSizeX,colorSpace,bitsPerComponent|kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);

    //画像ファイルの画像サイズ!=テクスチャのサイズの時
/*
    if ((textureSize!=imageWidth) || (textureSize!=imageHeight)) {
        CGContextScaleCTM(context,
            (CGFloat)textureSize/imageWidth,
            (CGFloat)textureSize/imageHeight);
    }
*/
    CGRect rect=CGRectMake(0,0,CGImageGetWidth(imageRef), CGImageGetHeight(imageRef));

    int SizeGapX, SizeGapY;
    SizeGapX = 0;//(textureSizeX - imageWidth)
    SizeGapY = (textureSizeY - imageHeight);

    CGContextClearRect(context,rect);
    CGContextTranslateCTM(context, (CGFloat)SizeGapX, (CGFloat)SizeGapY );
    CGContextDrawImage(context,rect,imageRef);
    CGContextRelease(context);
    return YES;
}

//イメージの生成
+ (Image*)makeImage:(UIImage*)image {
    unsigned char* textureData;
    GLuint         textureName;
    GLsizei        textureSizeX;
    GLsizei        textureSizeY;
    GLsizei        textureWidth;
    GLsizei        textureHeight;
    
    //テクスチャの生成
    if ([Image makeTeture:image toOutput:(unsigned char**)&textureData 
        andImageSizeX:&textureSizeX andImageSizeY:&textureSizeY 
        andImageWidth:&textureWidth andImageHeight:&textureHeight]) {

        /*
        textureSizeX = 512;
        textureSizeY = 512;
        textureWidth = 512;
        textureHeight = 512;
        textureData = (unsigned char *)malloc( 512*512*4 );
        */
         
        //テクスチャの設定
        glGenTextures(1,&textureName);
        //NSLog(@"#GenTex(%d)",textureName);
        glBindTexture(GL_TEXTURE_2D,textureName);
        glTexImage2D(GL_TEXTURE_2D,0,GL_RGBA,textureSizeX,textureSizeY,
            0,GL_RGBA,GL_UNSIGNED_BYTE,textureData);
        glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_WRAP_S,GL_CLAMP_TO_EDGE);
        glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_WRAP_T,GL_CLAMP_TO_EDGE);
        glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_LINEAR); 
//        glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_NEAREST); 
        glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_NEAREST); 

        //テクスチャオブジェクトの生成
        Image* texture=[[[Image alloc] init] autorelease];
        //texture.data=textureData;
        texture.data=NULL;//textureData;
        texture.name=textureName;
        texture.width=textureWidth;
        texture.height=textureHeight;
        texture.sizex=textureSizeX;
        texture.sizey=textureSizeY;
        texture.ratex=1.0f/textureSizeX;
        texture.ratey=1.0f/textureSizeY;

        free( textureData );

        return texture;
    } else {
        return nil;
    }
}


+ (Image*)makeImageFromFile:(NSString *)fname {
    unsigned char* textureData;
    GLuint         textureName;
    GLsizei        textureComp;
    GLsizei        textureWidth;
    GLsizei        textureHeight;
    char           fpath_tmp[1024];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:fname ofType:nil inDirectory:nil];
    if ( path == nil ) {
        NSLog(@"No File(%s)",fname);
        return nil;
    }
    sprintf( fpath_tmp, "%s", [path cStringUsingEncoding:1] );
#if 0
    textureData = stbi_load( fpath_tmp, &textureWidth, &textureHeight, &textureComp, 4 );
    NSLog(@"Size(%d x %d)",textureWidth,textureHeight);
    if ( !textureData ) {
        NSLog(@"Invalid File(%s)[%s]",fpath_tmp,stbi_failure_reason() );
        return nil;
    }
    //テクスチャの設定
    glGenTextures(1,&textureName);
    glBindTexture(GL_TEXTURE_2D,textureName);
    glTexImage2D(GL_TEXTURE_2D,0,GL_RGBA,textureWidth,textureHeight,
                 0,GL_RGBA,GL_UNSIGNED_BYTE,textureData);
    glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_WRAP_S,GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_WRAP_T,GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_NEAREST); 
    glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_NEAREST); 
    
    //テクスチャオブジェクトの生成
    Image* texture=[[[Image alloc] init] autorelease];
    texture.data=NULL;//textureData;
    texture.name=textureName;
    texture.width=textureWidth;
    texture.height=textureHeight;
    texture.ratex=1.0f/textureWidth;
    texture.ratey=1.0f/textureHeight;

    free( textureData );

    return texture;
#else
    return nil;
#endif
}


//テキストUIイメージの生成
+ (UIImage*)makeTextUIImage:(NSString*)text font:(UIFont*)font 
    color:(UIColor*)color bgcolor:(UIColor*)bgcolor {

    int sizex,sizey;
    
    //ラベルの生成
    UILabel* label=[[[UILabel alloc] init] autorelease]; 
	CGSize size=[text sizeWithFont:font constrainedToSize:CGSizeMake(1024,CGFLOAT_MAX)
        lineBreakMode:UILineBreakModeWordWrap];

    sizex = size.width;
    sizey = size.height;
    
    [label setFrame:CGRectMake(0,0,size.width,size.height)];
    [label setText:text];
    [label setFont:font];
    [label setTextColor:color];
    [label setTextAlignment:UITextAlignmentLeft];
    [label setBackgroundColor:bgcolor];
    [label setNumberOfLines:0];

    //コンテキストの生成
    if (sizex<32)  sizex=32;
    if (sizey<32) sizey=32;

    unsigned char *bmpData;
    CGContextRef context;	
    CGColorSpaceRef colorSpace;
    int msize;
    msize = sizex * sizey * sizeof(unsigned char) * 4;
	bmpData=(unsigned char *)malloc(msize); 
    //memset( bmpData, 0, msize );
	colorSpace=CGColorSpaceCreateDeviceRGB();
    context=CGBitmapContextCreate(bmpData, 
        sizex, sizey, 8, sizex * 4,
        colorSpace,
		kCGImageAlphaPremultipliedFirst);
    CGContextSetShouldAntialias(context,0);
    CGContextClearRect(context,CGRectMake(0,0,sizex,sizey));
    
    //コンテキストの設定
    UIGraphicsPushContext(context);
    CGContextTranslateCTM(context,0,sizey);
    CGContextScaleCTM(context,1,-1);    
    
    //ラベルの描画
    [label.layer renderInContext:context];
    CGImageRef imageRef=CGBitmapContextCreateImage(context);
    UIImage* image=[[[UIImage alloc] initWithCGImage:imageRef] autorelease];
    
    //コンテキストの設定解放
    UIGraphicsPopContext();
    
    //コンテキストの解放
    CGImageRelease(imageRef);
	CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);   
    free(bmpData);
    return image;
}

//テキストテクスチャの生成
+ (Image*)makeTextImage:(NSString*)text font:(UIFont*)font color:(UIColor*)color {
    UIImage* image=[Image makeTextUIImage:text 
        font:font color:color bgcolor:[UIColor clearColor]];
    Image *img = [Image makeImage:image];
    return img;
}
@end
