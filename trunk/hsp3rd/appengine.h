#ifndef APPENGINE_H
#define APPENGINE_H


/**
 * アプリケーション内で共通して利用する情報
 */
struct engine
{
    int width;
    int height;
    void *hspctx;
};

#endif
