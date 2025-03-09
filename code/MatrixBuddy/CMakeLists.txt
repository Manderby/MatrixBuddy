cmake_minimum_required(VERSION 3.13)
project(MatrixBuddy)



# ######### define target ################

set(TARGET_NAME MatrixBuddy)

set(BUNDLE_IDENTIFIER_PREFIX "ch.manderim.")
set(VERSION_STRING 1.2.2)
set(BUILD_NUMBER_STRING 1.2.2)

if(MSVC)
  add_executable(${TARGET_NAME} WIN32 src/main.c)
elseif(APPLE)
  add_executable(${TARGET_NAME})
endif()



# ######### compiler settings ################

set_target_properties(${TARGET_NAME} PROPERTIES LINKER_LANGUAGE CXX)

set(CMAKE_CXX_STANDARD 99)
set(CMAKE_CXX_STANDARD_REQUIRED True)



# ######### Define package settings ################

if(MSVC)
  add_definitions(-DNA_USE_WINDOWS_COMMON_CONTROLS_6=1)
  
  # multi processor compilation
  target_compile_options(${TARGET_NAME} PRIVATE /MP)
  # unicode. Theoretically, needs _MBCS to be undefined, but cmake does that.
  add_definitions(-D_UNICODE)

  # working directory
  set_property(TARGET ${TARGET_NAME} PROPERTY VS_DEBUGGER_WORKING_DIRECTORY $(OutDir))

  set(OUTPUT_DIRECTORY $(OutDir))

elseif(APPLE)

  set(OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/$CONFIGURATION/${TARGET_NAME}.app/Contents/Resources/)

endif()



# ######### Copying resources ################

add_custom_command(TARGET ${TARGET_NAME} POST_BUILD
  COMMAND ${CMAKE_COMMAND} -E copy
      ${CMAKE_CURRENT_SOURCE_DIR}/res/MatrixBuddyChangelog.txt
      \"${OUTPUT_DIRECTORY}MatrixBuddyChangelog.txt\"
  COMMAND ${CMAKE_COMMAND} -E copy
      ${CMAKE_CURRENT_SOURCE_DIR}/res/copy.png
      \"${OUTPUT_DIRECTORY}copy.png\"
  COMMAND ${CMAKE_COMMAND} -E copy
      ${CMAKE_CURRENT_SOURCE_DIR}/res/paste.png
      \"${OUTPUT_DIRECTORY}paste.png\"
  COMMAND ${CMAKE_COMMAND} -E copy
      ${CMAKE_CURRENT_SOURCE_DIR}/res/settings.png
      \"${OUTPUT_DIRECTORY}settings.png\"
)

if(APPLE)
  add_custom_command(TARGET ${TARGET_NAME} POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy
        ${CMAKE_CURRENT_SOURCE_DIR}/res/mac/MatrixBuddy.icns
        \"${OUTPUT_DIRECTORY}MatrixBuddy.icns\"
    COMMAND ${CMAKE_COMMAND} -E copy
        ${CMAKE_CURRENT_SOURCE_DIR}/res/mac/en.lproj/InfoPlist.strings
        \"${OUTPUT_DIRECTORY}en.lproj/InfoPlist.strings\"
    COMMAND ibtool --compile
        \"${OUTPUT_DIRECTORY}en.lproj/MainMenu.nib\"
        ${CMAKE_CURRENT_SOURCE_DIR}/res/mac/en.lproj/MainMenu.xib
  )

  set(BUNDLE_IDENTIFIER "${BUNDLE_IDENTIFIER_PREFIX}$(PRODUCT_NAME:rfc1034identifier)")

  set_target_properties(${TARGET_NAME} PROPERTIES
    MACOSX_BUNDLE YES
    MACOSX_BUNDLE_BUNDLE_NAME $(PRODUCT_NAME)
    XCODE_ATTRIBUTE_PRODUCT_BUNDLE_IDENTIFIER ${BUNDLE_IDENTIFIER}
    MACOSX_BUNDLE_GUI_IDENTIFIER ${BUNDLE_IDENTIFIER}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${VERSION_STRING}
    MACOSX_BUNDLE_BUNDLE_VERSION ${BUILD_NUMBER_STRING}
    MACOSX_BUNDLE_ICON_FILE "MatrixBuddy.icns"
    XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY ""
  )
endif()

if(MSVC)
  add_custom_command(TARGET ${TARGET_NAME} POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy
        ${CMAKE_CURRENT_SOURCE_DIR}/res/win/icon.png
        \"${OUTPUT_DIRECTORY}icon.png\"
  )
endif()



# ######### Sources ################

set(resourceFiles
  res/MatrixBuddyChangelog.txt
  res/MatrixBuddyStrings_deu.h
  res/MatrixBuddyStrings_eng.h
  res/copy.png
  res/paste.png
  res/settings.png
)

set(macResourceFiles
  res/mac/MatrixBuddy.icns
  res/mac/Matrix\ Buddy.entitlements
  res/mac/en.lproj/InfoPlist.strings
  res/mac/en.lproj/MainMenu.xib
)

set(sourceFiles
  src/main.c
  src/main.m
  src/MATAboutController.c
  src/MATAboutController.h
  src/MATApplication.c
  src/MATApplication.h
  src/MATCommonC.h
  src/MATNSApplication.h
  src/MATNSApplication.m
  src/MATPreferences.c
  src/MATPreferences.h
  src/MATTranslations.c
  src/MATTranslations.h
  src/MATTypes.h
  src/MATView.c
  src/MATView.h
  src/MATWindowController.c
  src/MATWindowController.h
)

set(computationControllersSourceFiles
  src/ComputationControllers/MATBaseController.c
  src/ComputationControllers/MATBaseController.h
  src/ComputationControllers/MATMAddM.c
  src/ComputationControllers/MATMDiagS.c
  src/ComputationControllers/MATMDiagV.c
  src/ComputationControllers/MATMDivCompM.c
  src/ComputationControllers/MATMDivCompV.c
  src/ComputationControllers/MATMDivS.c
  src/ComputationControllers/MATMInvert.c
  src/ComputationControllers/MATMMulCompM.c
  src/ComputationControllers/MATMMulCompV.c
  src/ComputationControllers/MATMMulM.c
  src/ComputationControllers/MATMMulS.c
  src/ComputationControllers/MATMMulV.c
  src/ComputationControllers/MATMNeg.c
  src/ComputationControllers/MATMSubM.c
  src/ComputationControllers/MATMTranspose.c
  src/ComputationControllers/MATVAddV.c
  src/ComputationControllers/MATVCrossV.c
  src/ComputationControllers/MATVDivCompV.c
  src/ComputationControllers/MATVDivS.c
  src/ComputationControllers/MATVDotV.c
  src/ComputationControllers/MATVLength.c
  src/ComputationControllers/MATVMirror.c
  src/ComputationControllers/MATVMulCompV.c
  src/ComputationControllers/MATVMulS.c
  src/ComputationControllers/MATVNeg.c
  src/ComputationControllers/MATVNormalize.c
  src/ComputationControllers/MATVOrtho.c
  src/ComputationControllers/MATVSubV.c
)



# ######### Group sources in project browser ################

source_group("res" FILES ${resourceFiles})
target_sources(${TARGET_NAME} PRIVATE ${resourceFiles})

if(APPLE)
  source_group("res/mac" FILES ${macResourceFiles})
  target_sources(${TARGET_NAME} PRIVATE ${macResourceFiles})
endif()

source_group("src/ComputationControllers" FILES ${computationControllersSourceFiles})
target_sources(${TARGET_NAME} PRIVATE ${computationControllersSourceFiles})

source_group("src" FILES ${sourceFiles})
target_sources(${TARGET_NAME} PRIVATE ${sourceFiles})



# ######### Macro definitions ################

add_definitions(-DMAT_VERSION_STRING=\"${VERSION_STRING}\")
add_definitions(-DMAT_BUILD_NUMBER_STRING=\"${BUILD_NUMBER_STRING}\")



# ######### Linking to NALib ################

# Define GUI to be in use and hide the CMake GUI options.
add_definitions(-DNA_COMPILE_GUI=1)
set(COMPILE_NALIB_GUI 1 CACHE INTERNAL "GUI required")

set(NALIB_DIR "../../lib/NALib/code/NALib")
target_include_directories(${TARGET_NAME} PRIVATE ${NALIB_DIR}/src)
add_subdirectory(${NALIB_DIR} NALib)
target_link_libraries(${TARGET_NAME} PRIVATE NALib)



# ######### Linking to other libraries ################

if(MSVC)
  target_link_libraries(${TARGET_NAME} PRIVATE ComCtl32.lib)
elseif(APPLE)
  FIND_LIBRARY(CARBON_FRAMEWORK Carbon)
  FIND_LIBRARY(COCOA_FRAMEWORK Cocoa)
  FIND_LIBRARY(UTYPE_FRAMEWORK UniformTypeIdentifiers)
  target_link_libraries(${TARGET_NAME} PRIVATE ${CARBON_FRAMEWORK})
  target_link_libraries(${TARGET_NAME} PRIVATE ${COCOA_FRAMEWORK})
  target_link_libraries(${TARGET_NAME} PRIVATE ${UTYPE_FRAMEWORK})
  
endif()



# this hack removes the xxx-CMakeForceLinker.cxx dummy file
set_target_properties(${TARGET_NAME} PROPERTIES LINKER_LANGUAGE C)
