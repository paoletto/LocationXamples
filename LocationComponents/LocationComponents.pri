INCLUDEPATH += $$PWD #../LocationComponents

DEFINES += LOCATION_COMPONENTS_PWD="\"$$PWD/.."\"
#message($$DEFINES)
HEADERS += $$PWD//locationcomponents.h

#RESOURCES += ../LocationComponents/LocationComponents.qrc

contains(ANDROID_TARGET_ARCH,armeabi-v7a) {
    ANDROID_EXTRA_LIBS = $$PWD/../libs/android_ssl_armv7a/libcrypto.so \
                         $$PWD/../libs/android_ssl_armv7a/libssl.so
}
