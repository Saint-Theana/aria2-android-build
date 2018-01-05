if [ -z "$ANDROID_HOME" ]; then
    echo 'No $ANDROID_HOME specified.'
    exit 1
fi
PREFIX=$ANDROID_HOME/usr/local
TOOLCHAIN=$ANDROID_HOME/toolchain
PATH=$TOOLCHAIN/bin:$PATH
HOST=aarch64-linux-android
./configure \
    --host=$HOST \
    --build=`dpkg-architecture -qDEB_BUILD_GNU_TYPE` \
    --disable-nls \
    --without-gnutls \
    --with-openssl \
    --without-sqlite3 \9
    --without-libxml2 \
    --with-libexpat \
    --with-libcares \
    --with-libz \
    --with-libssh2 \
    --with-ca-bundle='/sdcard/ca-certificates.crt' \
    CC="$TOOLCHAIN"/bin/"$HOST"-clang \
    CXX="$TOOLCHAIN"/bin/"$HOST"-clang++ \
    CXXFLAGS="-Os -g" \
    CFLAGS="-Os -g" \
    CPPFLAGS="-fPIE" \
    LDFLAGS="-fPIE -pie -L$PREFIX/lib" \
    PKG_CONFIG_LIBDIR="$PREFIX/lib/pkgconfig"
