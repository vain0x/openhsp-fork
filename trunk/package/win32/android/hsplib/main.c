
#include <jni.h>
#include <android/sensor.h>
//#include <android_native_app_glue.h>

#include "javafunc.h"

#include <stdio.h>
#include <stdlib.h>
#include "hsp3/hsp3config.h"
#include "hsp3/hsp3struct.h"
#include "hsp3/hsp3ext.h"
#include "hsp3embed/hsp3embed.h"

static int *p_runmode;

void hgio_view( int sx, int sy );
void hgio_scale( float xx, float yy );
void hgio_autoscale( int mode );
void hgio_setstorage( char *path );

/**
 * デバイスに対してのEGLコンテキストの初期化
 */
static int engine_init_display(struct engine* engine) {
    // OepGL ES と EGLの初期化

    const EGLint attribs[] =
            { EGL_SURFACE_TYPE, EGL_WINDOW_BIT, EGL_BLUE_SIZE, 8,
                    EGL_GREEN_SIZE, 8, EGL_RED_SIZE, 8, EGL_NONE };
    EGLint w, h, dummy, format;
    EGLint numConfigs;
    EGLConfig config;
    EGLSurface surface;
    EGLContext context;

    EGLDisplay display = eglGetDisplay(EGL_DEFAULT_DISPLAY);

    eglInitialize(display, 0, 0);

    eglChooseConfig(display, attribs, &config, 1, &numConfigs);

    eglGetConfigAttrib(display, config, EGL_NATIVE_VISUAL_ID, &format);

    ANativeWindow_setBuffersGeometry(engine->app->window, 0, 0, format);

    surface = eglCreateWindowSurface(display, config, engine->app->window,
            NULL);
    context = eglCreateContext(display, config, NULL, NULL);

    if (eglMakeCurrent(display, surface, surface, context) == EGL_FALSE) {
        LOGW("Unable to eglMakeCurrent");
        return -1;
    }

    eglQuerySurface(display, surface, EGL_WIDTH, &w);
    eglQuerySurface(display, surface, EGL_HEIGHT, &h);

    engine->display = display;
    engine->context = context;
    engine->surface = surface;
    engine->width = w;
    engine->height = h;

    // ボックス表示の初期化
    //initBox(engine);
    //hgio_clsmode( 1, 0x000000, 0 );

    return 0;
}

/*
 * 毎フレーム描画
 */
static void engine_draw_frame(struct engine* engine) {

/*
    if (engine->display == NULL) {
        // displayが無い
        return;
    }
*/
    //glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    //drawBox();
    hgio_test();
    //eglSwapBuffers(engine->display, engine->surface);
}

/**
 * EGLコンテキストを破棄する
 */
static void engine_term_display(struct engine* engine) {
    if (engine->display != EGL_NO_DISPLAY) {
        eglMakeCurrent(engine->display, EGL_NO_SURFACE, EGL_NO_SURFACE,
                EGL_NO_CONTEXT);
        if (engine->context != EGL_NO_CONTEXT) {
            eglDestroyContext(engine->display, engine->context);
        }
        if (engine->surface != EGL_NO_SURFACE) {
            eglDestroySurface(engine->display, engine->surface);
        }
        eglTerminate(engine->display);
    }
    engine->animating = 0;
    engine->display = EGL_NO_DISPLAY;
    engine->context = EGL_NO_CONTEXT;
    engine->surface = EGL_NO_SURFACE;
}

/**
 * 入力イベントを処理する
 */
static int32_t engine_handle_input(struct android_app* app,
        AInputEvent* event) {
    struct engine* engine = (struct engine*) app->userData;
    if (AInputEvent_getType(event) == AINPUT_EVENT_TYPE_MOTION) {

        int i,keyid,pid;
		int xx,yy;
		int acttype;
        int action = AKeyEvent_getAction(event);
        acttype = action & AMOTION_EVENT_ACTION_MASK;
        size_t count = AMotionEvent_getPointerCount(event);
        //LOGI("***INPUT(TYPE%d)x%d",acttype, count);
        for (i = 0; i < count; i++){

            if (acttype == AMOTION_EVENT_ACTION_POINTER_DOWN || acttype == AMOTION_EVENT_ACTION_POINTER_UP) {
		        pid = ( action & AMOTION_EVENT_ACTION_POINTER_INDEX_MASK )>>AMOTION_EVENT_ACTION_POINTER_INDEX_SHIFT;
            } else {
				pid = i;
			}
            keyid = AMotionEvent_getPointerId(event, pid);
			xx = AMotionEvent_getX(event, pid);
			yy = AMotionEvent_getY(event, pid);
			if ( i == 0 ) {
		        engine->state.x = xx;
		        engine->state.y = yy;
		    }
	        //LOGI("***INPUT(#%d,%d)",i,keyid);
	        switch (acttype) {
			case AMOTION_EVENT_ACTION_DOWN:
	        case AMOTION_EVENT_ACTION_MOVE:
			case AMOTION_EVENT_ACTION_POINTER_DOWN:
		        hgio_mtouchid( keyid, xx, yy, 1, i );
				break;
	        case AMOTION_EVENT_ACTION_UP:
	        case AMOTION_EVENT_ACTION_POINTER_UP:
		        hgio_mtouchid( keyid, xx, yy, 0, i );
				break;
			}
	    }
/*
        switch (action & AMOTION_EVENT_ACTION_MASK) {
		case AMOTION_EVENT_ACTION_DOWN:
        	//LOGI("***DOWN(%d,%d)",xx,yy);
			hgio_touch( xx, yy, 1 );
			break;
        case AMOTION_EVENT_ACTION_MOVE:
        	//LOGI("***MOVE(%d,%d)",xx,yy);
			hgio_touch( xx, yy, 1 );
			break;
        case AMOTION_EVENT_ACTION_UP:
			hgio_touch( xx, yy, 0 );
			break;
		}
*/		
		
		
//		engine->animating = 1;
        return 1;
    }
    return 0;
}

/**
 * メインコマンドの処理
 */
static void engine_handle_cmd(struct android_app* app, int32_t cmd) {
    struct engine* engine = (struct engine*) app->userData;
    switch (cmd) {
    case APP_CMD_SAVE_STATE:
        engine->app->savedState = malloc(sizeof(struct saved_state));
        *((struct saved_state*) engine->app->savedState) = engine->state;
        engine->app->savedStateSize = sizeof(struct saved_state);
        break;
    case APP_CMD_INIT_WINDOW:
       	//LOGI("***CMD_INIT_WINDOW(%x)",engine->app->window);
        if (engine->app->window != NULL) {
			javafunc_init( engine );
            engine_init_display(engine);
            if ( engine->hspctx == NULL ) {
				HSPCTX *ctx;
				InitSysReq();
			    hgio_init( 0, engine->width, engine->height, engine );
				//hgio_view( 480, 800 );	// screen size
				//hgio_scale( 1.0f, 1.0f );	// scale value
				//hgio_autoscale( 0 );	// auto scale value
				hsp3eb_init();
				ctx = hsp3eb_getctx(); 
				engine->hspctx = ctx;
				p_runmode = &(ctx->runmode);
				hgio_setstorage( j_getinfo(JAVAFUNC_INFO_FILESDIR) );
			    hsp3dish_setdevinfo();

			} else {
		       	LOGI("[HSP Resume]");
		        hsp3eb_resume();
		        engine->animating = 1;
			}
            //engine_draw_frame(engine);
	        //engine->animating = 1;
        }
        break;
    case APP_CMD_TERM_WINDOW:
       	//LOGI("***CMD_TERM_WINDOW");
        engine->animating = 0;
        engine_term_display(engine);
        hsp3eb_pause();
        break;
    case APP_CMD_GAINED_FOCUS:
        engine->animating = 1;
/*
        if (engine->accelerometerSensor != NULL) {
            ASensorEventQueue_enableSensor(engine->sensorEventQueue,
                    engine->accelerometerSensor);
            ASensorEventQueue_setEventRate(engine->sensorEventQueue,
                    engine->accelerometerSensor, (1000L / 60) * 1000);
        }
        engine_draw_frame(engine);
*/
        break;
    case APP_CMD_LOST_FOCUS:
/*
        if (engine->accelerometerSensor != NULL) {
            ASensorEventQueue_disableSensor(engine->sensorEventQueue,
                    engine->accelerometerSensor);
        }
*/
        engine->animating = 0;
        break;
    }
}

/**
 * アプリケーション開始
 */
void android_main(struct android_app* state) {
    struct engine engine;
 
    // glueが削除されないように
    app_dummy();

    memset(&engine, 0, sizeof(engine));
    state->userData = &engine;
    state->onAppCmd = engine_handle_cmd;
    state->onInputEvent = engine_handle_input;
    engine.app = state;
    engine.hspctx = NULL;
    p_runmode = NULL;

    // センサーからのデータ取得に必要な初期化
/*
    engine.sensorManager = ASensorManager_getInstance();
    engine.accelerometerSensor = ASensorManager_getDefaultSensor(
            engine.sensorManager, ASENSOR_TYPE_ACCELEROMETER);
    engine.sensorEventQueue = ASensorManager_createEventQueue(
            engine.sensorManager, state->looper, LOOPER_ID_USER, NULL,
            NULL);
*/
   	//LOGI("***android_main(%x)",state->savedState);

    if (state->savedState != NULL) {
        // 以前の状態に戻す
        engine.state = *(struct saved_state*) state->savedState;
    }
    while (1) {

        int ident;
        int events;
        struct android_poll_source* source;

        // アプリケーションが動作することになれば、これらセンサーの制御を行う
        while ((ident = ALooper_pollAll(engine.animating ? 0 : -1, NULL,
                &events, (void**) &source)) >= 0) {

            // イベントを処理する
            if (source != NULL) {
                source->process(state, source);
            }

            // センサーに何かしらのデータが存在したら処理する
/*
            if (ident == LOOPER_ID_USER) {
                if (engine.accelerometerSensor != NULL) {
                    ASensorEvent event;
                    while (ASensorEventQueue_getEvents(
                            engine.sensorEventQueue, &event, 1) > 0) {
                        LOGI("accelerometer: x=%f y=%f z=%f",
                                event.acceleration.x, event.acceleration.y,
                                event.acceleration.z);
                    }
                }
            }
*/

            // 破棄要求があったか
            if (state->destroyRequested != 0) {
//				LOGI("[END Request]");
				if ( p_runmode != NULL ) *p_runmode = RUNMODE_END;
				break;
            }
        }

        if (engine.animating) {
            // 画面描画
			hsp3eb_exectime( hgio_gettick() );
			//hsp3eb_exec();
			//engine_draw_frame(&engine);
        }
        
        
         
        
			if ( (*p_runmode) >= RUNMODE_END ) {
//				if ( (*p_runmode) == RUNMODE_ERROR ) {
//					j_dispDialog( "HSPError", "Bye!", 0 );
//				}
				break;
			}
    }

    // 破棄
//	LOGI("[HSP Close]");
	hsp3eb_bye();
    hgio_term();
	engine_term_display(&engine);
	exit(0);
	//return;
}



