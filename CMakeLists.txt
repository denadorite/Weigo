cmake_minimum_required(VERSION 3.16)

project(weigo VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_CXX_STANDARD 17)

find_package(Qt6 6.2 COMPONENTS Quick REQUIRED)
find_package(Qt6Svg REQUIRED)
include_directories(${Qt6Svg_INCLUDE_DIRS})

qt_add_executable(appweigo
    main.cpp
    qml.qrc
    goboard.cpp
    goboard.h
    sgf_reader.cpp
    sgf_reader.h
)

qt_add_qml_module(appweigo
    URI weigo
    VERSION 1.0
    QML_FILES
)

set_target_properties(appweigo PROPERTIES
    #MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    #MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    #MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    #MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appweigo
    PRIVATE Qt6::Core Qt6::Quick Qt6::Qml Qt6::Svg)

install(TARGETS appweigo
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})



# Old CMAKE
#cmake_minimum_required(VERSION 3.5)

#project(weigo LANGUAGES CXX)

#set(CMAKE_INCLUDE_CURRENT_DIR ON)

#set(CMAKE_AUTOUIC ON)
#set(CMAKE_AUTOMOC ON)
#set(CMAKE_AUTORCC ON)

#set(CMAKE_CXX_STANDARD 17 )
#set(CMAKE_CXX_STANDARD_REQUIRED ON)

## QtCreator supports the following variables for Android, which are identical to qmake Android variables.
## Check http://doc.qt.io/qt-5/deployment-android.html for more information.
## They need to be set before the find_package(Qt5 ...) call.

##if(ANDROID)
##    set(ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/android")
##    if (ANDROID_ABI STREQUAL "armeabi-v7a")
##        set(ANDROID_EXTRA_LIBS
##            ${CMAKE_CURRENT_SOURCE_DIR}/path/to/libcrypto.so
##            ${CMAKE_CURRENT_SOURCE_DIR}/path/to/libssl.so)
##    endif()
##endif()
#if(WIN32)
#    set(CMAKE_PREFIX_PATH "C:\\Qt\\6.2.1\\msvc2019_64\\lib\\cmake")
#endif()
#find_package(Qt6 COMPONENTS Core Quick REQUIRED)

#find_package(Qt6Svg REQUIRED)
#include_directories(${Qt6Svg_INCLUDE_DIRS})
##########################################################
##include_directories(${Qt6Widgets_INCLUDE_DIRS} ${QtQml_INCLUDE_DIRS})
##add_definitions(${Qt6Widgets_DEFINITIONS} ${QtQml_DEFINITIONS} ${${Qt6Quick_DEFINITIONS}})

##set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${Q65Widgets_EXECUTABLE_COMPILE_FLAGS}")

#if(NOT DEFINED HEADERS)
#    file(GLOB HEADERS ${CMAKE_CURRENT_SOURCE_DIR}⁄*.h)
#endif()
#if(NOT DEFINED SOURCES)
#    file(GLOB SOURCES ${CMAKE_CURRENT_SOURCE_DIR}⁄*.cpp)
#endif()

##list(APPEND QML_DIRS ":/")
##set(QML_IMPORT_PATH "${QML_DIRS}" CACHE STRING "Qt Creator 4.1 extra qml import paths")

##add_executable(${PROJECT} ${HEADERS} ${SOURCES} ${QT_RESOURCES})
##########################################################

#if(ANDROID)
#    add_library(weigo SHARED
#      main.cpp
#      qml.qrc
#      goboard.cpp
#      goboard.h
#    )
#else()
#    add_executable(weigo
#      main.cpp
#      qml.qrc
#      goboard.cpp
#      goboard.h
#    )
#endif()
#
#target_compile_definitions(weigo
#  PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
#target_link_libraries(weigo
#  PRIVATE Qt6::Core Qt6::Quick Qt6::Qml Qt6::Svg)
#
#

