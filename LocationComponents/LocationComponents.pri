INCLUDEPATH += ../LocationComponents

DEFINES += LOCATION_COMPONENTS_PWD="\"$$PWD/.."\"
#message($$DEFINES)
HEADERS += ../LocationComponents/qmlsystemenvironment.h \
           ../LocationComponents/locationcomponents.h

SOURCES += ../LocationComponents/qmlsystemenvironment.cpp

contains(ANDROID_TARGET_ARCH,armeabi-v7a) {
    ANDROID_EXTRA_LIBS = /media/paolo/qdata/AndroidDev/ssl/android_ssl_armv7a/libcrypto.so \
                         /media/paolo/qdata/AndroidDev/ssl/android_ssl_armv7a/libssl.so
}
