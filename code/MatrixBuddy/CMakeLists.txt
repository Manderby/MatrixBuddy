cmake_minimum_required(VERSION 3.13)
project(MatrixBuddy)



# ######### define target ################

set(TARGET_NAME MatrixBuddy)

set(BUNDLE_IDENTIFIER_PREFIX "ch.manderim.")
set(BUNDLE_IDENTIFIER_MAC "Matrix-Buddy")

set(VERSION_STRING 1.3.1)
set(BUILD_NUMBER_STRING 1.3.2)

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
    COMMAND ${CMAKE_COMMAND} -E copy
        ${CMAKE_CURRENT_SOURCE_DIR}/res/mac/de.lproj/InfoPlist.strings
        \"${OUTPUT_DIRECTORY}de.lproj/InfoPlist.strings\"
    COMMAND ${CMAKE_COMMAND} -E copy
        ${CMAKE_CURRENT_SOURCE_DIR}/res/mac/es.lproj/InfoPlist.strings
        \"${OUTPUT_DIRECTORY}es.lproj/InfoPlist.strings\"
    COMMAND ${CMAKE_COMMAND} -E copy
        ${CMAKE_CURRENT_SOURCE_DIR}/res/mac/fr.lproj/InfoPlist.strings
        \"${OUTPUT_DIRECTORY}fr.lproj/InfoPlist.strings\"
    COMMAND ${CMAKE_COMMAND} -E copy
        ${CMAKE_CURRENT_SOURCE_DIR}/res/mac/ja.lproj/InfoPlist.strings
        \"${OUTPUT_DIRECTORY}ja.lproj/InfoPlist.strings\"
    COMMAND ${CMAKE_COMMAND} -E copy
        ${CMAKE_CURRENT_SOURCE_DIR}/res/mac/zh.lproj/InfoPlist.strings
        \"${OUTPUT_DIRECTORY}zh.lproj/InfoPlist.strings\"
    COMMAND ibtool --compile
        \"${OUTPUT_DIRECTORY}en.lproj/MainMenu.nib\"
        ${CMAKE_CURRENT_SOURCE_DIR}/res/mac/MainMenu.xib
  )

  set(BUNDLE_IDENTIFIER "${BUNDLE_IDENTIFIER_PREFIX}${BUNDLE_IDENTIFIER_MAC}")

  set_target_properties(${TARGET_NAME} PROPERTIES
    MACOSX_BUNDLE YES
    MACOSX_BUNDLE_BUNDLE_NAME $(PRODUCT_NAME)
    XCODE_ATTRIBUTE_PRODUCT_BUNDLE_IDENTIFIER ${BUNDLE_IDENTIFIER}
    MACOSX_BUNDLE_GUI_IDENTIFIER ${BUNDLE_IDENTIFIER}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${VERSION_STRING}
    MACOSX_BUNDLE_BUNDLE_VERSION ${BUILD_NUMBER_STRING}
    MACOSX_BUNDLE_ICON_FILE "MatrixBuddy.icns"
    XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY ""
    XCODE_ATTRIBUTE_INSTALL_PATH "$(LOCAL_APPS_DIR)"
    XCODE_ATTRIBUTE_DEBUG_INFORMATION_FORMAT "dwarf-with-dsym"
    XCODE_ATTRIBUTE_GCC_GENERATE_DEBUGGING_SYMBOLS "YES"
    XCODE_ATTRIBUTE_DEPLOYMENT_POSTPROCESSING "YES"
    XCODE_ATTRIBUTE_SKIP_INSTALL "NO"

    # Uncomment the following line when you are planning to archive and upload.
    # Beware: The debug build will not have the proper resource folder copied
    # but the archive will contain it.
    # Note: Sometimes, it works without uncommenting it.
    # XCODE_ATTRIBUTE_CONFIGURATION_BUILD_DIR "$(inherited)"
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
  res/MatrixBuddyStrings_eng.h
  res/MatrixBuddyStrings_deu.h
  res/MatrixBuddyStrings_spa.h
  res/MatrixBuddyStrings_fra.h
  res/MatrixBuddyStrings_tlh.h
  res/MatrixBuddyStrings_jpn.h
  res/MatrixBuddyStrings_zho.h
  res/copy.png
  res/paste.png
  res/settings.png
)

set(macResourceFiles
  res/mac/MatrixBuddy.icns
  res/mac/MainMenu.xib
  res/mac/en.lproj/InfoPlist.strings
  res/mac/de.lproj/InfoPlist.strings
  res/mac/es.lproj/InfoPlist.strings
  res/mac/fr.lproj/InfoPlist.strings
  res/mac/ja.lproj/InfoPlist.strings
  res/mac/zh.lproj/InfoPlist.strings
)

set(winResourceFiles
  res/win/icon.png
)

set(winResourceStringEnFiles
  res/win/Strings/en-US/Resources.resw
)
set(winResourceStringDeFiles
  res/win/Strings/de-DE/Resources.resw
)
set(winResourceStringEsFiles
  res/win/Strings/es-ES/Resources.resw
)
set(winResourceStringFrFiles
  res/win/Strings/fr-FR/Resources.resw
)
set(winResourceStringJaFiles
  res/win/Strings/ja-JP/Resources.resw
)
set(winResourceStringZhFiles
  res/win/Strings/zh-cn/Resources.resw
)

set(sourceFiles
  src/main.c
  src/MATAboutController.c
  src/MATAboutController.h
  src/MATApplication.c
  src/MATApplication.h
  src/MATCommonC.h
  src/MATNSApplication.m
  src/MATPreferences.c
  src/MATPreferences.h
  src/MATPreferencesController.c
  src/MATPreferencesController.h
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

source_group("res/mac" FILES ${macResourceFiles})
target_sources(${TARGET_NAME} PRIVATE ${macResourceFiles})

source_group("res/win" FILES ${winResourceFiles})
target_sources(${TARGET_NAME} PRIVATE ${winResourceFiles})

source_group("res/win/Strings/en-US" FILES ${winResourceStringEnFiles})
target_sources(${TARGET_NAME} PRIVATE ${winResourceStringEnFiles})
source_group("res/win/Strings/de-DE" FILES ${winResourceStringDeFiles})
target_sources(${TARGET_NAME} PRIVATE ${winResourceStringDeFiles})
source_group("res/win/Strings/es-ES" FILES ${winResourceStringEsFiles})
target_sources(${TARGET_NAME} PRIVATE ${winResourceStringEsFiles})
source_group("res/win/Strings/fr-FR" FILES ${winResourceStringFrFiles})
target_sources(${TARGET_NAME} PRIVATE ${winResourceStringFrFiles})
source_group("res/win/Strings/ja-JP" FILES ${winResourceStringJaFiles})
target_sources(${TARGET_NAME} PRIVATE ${winResourceStringJaFiles})
source_group("res/win/Strings/zh-CN" FILES ${winResourceStringZhFiles})
target_sources(${TARGET_NAME} PRIVATE ${winResourceStringZhFiles})

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
