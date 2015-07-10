■LLVMのビルド方法
VC++用のプロジェクトの生成には cmake を使います。
# http://www.cmake.org の http://www.cmake.org/cmake/resources/software.html
# からダウンロードできます。

CMAKE_INSTALL_PREFIX でインストール先が hsp3ll/llvm/lib になるよう
指定してください。

cmake-gui.exe を使う場合は、以下のようにします。
1. Where is the source code に hsp3ll/llvm/build を
   Where to build the binaries に一時ディレクトリを指定する。
2. Configure ボタンを押すと、開発環境を聞かれるので設定する。
3. CMAKE_INSTALL_PREFIX を hsp3ll/llvm/lib をさすように変更する。
4. Generate を押す。

cmake.exe でもOKです。
$ cd hsp3ll/llvm/build
$ cmake -G "Visual Studio 9 2008" -DCMAKE_INSTALL_PREFIX=../lib ../

指定したフォルダにllvm.sln が作られるので、 ALL_BUILD と INSTALL を
ビルドしてください。
ソリューション構成は HSP 本体にあわせます。
＃現状では RelWithDebInfo を使っています。

詳細は http://llvm.org/docs/GettingStartedVS.html を参照してください。
