
#include "NAApp/NAApp.h"
#include "MATAboutController.h"
#include "MATTranslations.h"
#include "NAUtility/NAMemory.h"
#include "NAUtility/NAString.h"
#include "NAVisual/NAImage.h"



#define MAT_WINDOW_TAG_ABOUT 1



struct MATAboutController{
  NAWindow* window;
  NAImageSpace* iconSpace;
  NALabel* appNameLabel;
  NALabel* appVersionLabel;
  NAImageSpace* manderCSpace;
  NALabel* helpLinkLabel;
  NAButton* doneButton;
};



void mat_pressAboutDone(NAReaction reaction){
  MATAboutController* con = (MATAboutController*)reaction.controller;
  naCloseWindow(con->window);
}



MATAboutController* matAllocAboutController(void){
  MATAboutController* con = naAlloc(MATAboutController);

  NAString* bundleApplicationName = naNewApplicationName();

  NARect windowrect = naMakeRectS(20, 300, 340, 308);
  const NAUTF8Char* aboutWindowTitleFormatString = matTranslate(MATAbout);
  NAString* aboutWindowTitleString = naNewStringWithFormat(aboutWindowTitleFormatString, naGetStringUTF8Pointer(bundleApplicationName));
  // We have no storage tag as the about window is not really part of the application
  con->window = naNewWindow(naGetStringUTF8Pointer(aboutWindowTitleString), windowrect, NA_FALSE);
  naSetWindowStorageTag(con->window, MAT_WINDOW_TAG_ABOUT);
  naDelete(aboutWindowTitleString);
  
  NASpace* space = naGetWindowContentSpace(con->window);

  NAString* iconPath = naNewApplicationIconPath();
  if(iconPath) {
    NAImage* iconImage = naCreateImageWithFilePath(naGetStringUTF8Pointer(iconPath));
    NAImageSet* iconImageSet = naCreateImageSet(iconImage, NA_UI_RESOLUTION_2x, NA_BLEND_ZERO);
    naRelease(iconImage);
    naDelete(iconPath);
    con->iconSpace = naNewImageSpace(iconImageSet, naMakeSize(128, 128));
    naAddSpaceChild(space, con->iconSpace, naMakePos(106., 160.));
    naRelease(iconImageSet);
  }

  con->appNameLabel = naNewLabel(naGetStringUTF8Pointer(bundleApplicationName), 300);
  NAFont* titleFont = naCreateFontWithPreset(NA_FONT_KIND_TITLE, NA_FONT_SIZE_BIG);
  naSetLabelFont(con->appNameLabel, titleFont);
  naSetLabelTextAlignment(con->appNameLabel, NA_TEXT_ALIGNMENT_CENTER);
  naSetLabelHeight(con->appNameLabel, 24);
  naRelease(titleFont);
  naAddSpaceChild(space, con->appNameLabel, naMakePos(20., 126.));

  NAString* bundleVersionString = naNewApplicationVersionString();
  NAString* bundleBuildString = naNewApplicationBuildString();
  const NAUTF8Char* aboutVersionFormatString = matTranslate(MATVersionBuild);
  NAString* aboutVersionString = naNewStringWithFormat(aboutVersionFormatString, naGetStringUTF8Pointer(bundleVersionString), naGetStringUTF8Pointer(bundleBuildString));
  con->appVersionLabel = naNewLabel(naGetStringUTF8Pointer(aboutVersionString), 300);
  naDelete(aboutVersionString);
  naDelete(bundleVersionString);
  naDelete(bundleBuildString);
  naSetLabelTextAlignment(con->appVersionLabel, NA_TEXT_ALIGNMENT_CENTER);
  naAddSpaceChild(space, con->appVersionLabel, naMakePos(20., 100.));

  con->helpLinkLabel = naNewLabel(matTranslate(MATOnlineHelp), 300);
  naSetLabelTextAlignment(con->helpLinkLabel, NA_TEXT_ALIGNMENT_CENTER);
  naSetLabelLink(con->helpLinkLabel, matTranslate(MATApplicationHelpURL));
  naAddSpaceChild(space, con->helpLinkLabel, naMakePos(20., 54.));

  con->doneButton = naNewTextPushButton(matTranslate(MATDone), 80);
  naAddUIReaction(con->doneButton, NA_UI_COMMAND_PRESSED, mat_pressAboutDone, con);
  naAddSpaceChild(space, con->doneButton, naMakePos(130., 20.));

  naSetButtonSubmit(con->doneButton, mat_pressAboutDone, con);
  naSetButtonAbort(con->doneButton, mat_pressAboutDone, con);

  naDelete(bundleApplicationName);
  
  return con;
}



void matDeallocAboutController(MATAboutController* con){
  naFree(con);
}



void matShowAboutController(MATAboutController* con){
  naShowWindow(con->window);
}



// This is free and unencumbered software released into the public domain.

// Anyone is free to copy, modify, publish, use, compile, sell, or
// distribute this software, either in source code form or as a compiled
// binary, for any purpose, commercial or non-commercial, and by any
// means.

// In jurisdictions that recognize copyright laws, the author or authors
// of this software dedicate any and all copyright interest in the
// software to the public domain. We make this dedication for the benefit
// of the public at large and to the detriment of our heirs and
// successors. We intend this dedication to be an overt act of
// relinquishment in perpetuity of all present and future rights to this
// software under copyright law.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
// IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
// OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
// ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
// OTHER DEALINGS IN THE SOFTWARE.

// For more information, please refer to <http://unlicense.org/>
