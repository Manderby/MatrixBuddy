
#include "MATApplication.h"
#include "MATTypes.h"
#include "MATTranslations.h"
#include "MATPreferences.h"
#include "MATWindowController.h"
#include "MATAboutController.h"

#include "NAVisual/NAColor.h"
#include "NAVisual/NAImage.h"
#include "NAUtility/NAString.h"
#include "NAApp/NAImageSet.h"
#include "NAApp/NAApp.h"





const NAUTF8Char* matGetUTF8StringWithStatus(MATStatus status){
  static MATTranslation errorStringTranslations[] = {
    MATDummyTranslation,      // MAT_STATUS_NORMAL results in ""
    MATDummyTranslation,      // MAT_STATUS_RESULT results in ""
    MATErrorMatrixDeterminantZero,
    MATErrorMatrixDeterminantAlmostZero,
    MATErrorVectorComponentZero,
    MATErrorVectorComponentAlmostZero,
    MATErrorMatrixComponentZero,
    MATErrorMatrixComponentAlmostZero,
    MATErrorScalarZero,
    MATErrorScalarAlmostZero,
    MATErrorVectorLengthZero,
    MATErrorVectorLengthAlmostZero,
    MATErrorVectorsCollinear,
    MATErrorVectorsAlmostCollinear,
    MATErrorVectorLengthUnequalOne
  };
  
  return matTranslate(errorStringTranslations[status]);
}



MATColor matGetColorWithStatus(MATStatus status){
  static MATColor statusColors[] = {
    [MAT_STATUS_NORMAL]                         = MAT_COLOR_NORMAL,
    [MAT_STATUS_RESULT]                         = MAT_COLOR_RESULT,
    [MAT_STATUS_MATRIX_DETERMINANT_ZERO]        = MAT_COLOR_ERROR,
    [MAT_STATUS_MATRIX_DETERMINANT_ALMOST_ZERO] = MAT_COLOR_WARNING,
    [MAT_STATUS_VECTOR_COMPONENT_ZERO]          = MAT_COLOR_ERROR,
    [MAT_STATUS_VECTOR_COMPONENT_ALMOST_ZERO]   = MAT_COLOR_WARNING,
    [MAT_STATUS_MATRIX_COMPONENT_ZERO]          = MAT_COLOR_ERROR,
    [MAT_STATUS_MATRIX_COMPONENT_ALMOST_ZERO]   = MAT_COLOR_WARNING,
    [MAT_STATUS_SCALAR_ZERO]                    = MAT_COLOR_ERROR,
    [MAT_STATUS_SCALAR_ALMOST_ZERO]             = MAT_COLOR_WARNING,
    [MAT_STATUS_VECTOR_LENGTH_ZERO]             = MAT_COLOR_ERROR,
    [MAT_STATUS_VECTOR_LENGTH_ALMOST_ZERO]      = MAT_COLOR_WARNING,
    [MAT_STATUS_VECTORS_COLINEAR]               = MAT_COLOR_ERROR,
    [MAT_STATUS_VECTORS_ALMOST_COLINEAR]        = MAT_COLOR_WARNING,
    [MAT_STATUS_VECTOR_LENGTH_UNEQUAL_ONE]      = MAT_COLOR_WARNING,
  };
  
  return statusColors[status];
}



void matFillColor(NAColor* naColor, MATColor matColor){
  static const NAColor matColors[] = {
    [MAT_COLOR_NORMAL]  = {0.f, 0.f, 0.f, 0.f,},
    [MAT_COLOR_RESULT]  = {0.f, .4f, .025f, 1.f,},
    [MAT_COLOR_ERROR]   = {.7f, .025f, 0.f, 1.f,},
    [MAT_COLOR_WARNING] = {.4f, .25f, 0.f, 1.f,},
  };
  naCopyn(naColor, &matColors[matColor], sizeof(NAColor));
}










typedef struct MATApplication MATApplication;
struct MATApplication{
  NAFont* mathFont;
  NAFont* helpLineFont;
  NAImageSet* copyImageSet;
  NAImageSet* pasteImageSet;
  NAImageSet* settingsImageSet;
  MATAboutController* aboutController;
  MATWindowController* windowController;
};

static MATApplication* mat_App = NA_NULL;



void preStartup(void* arg){
  NA_UNUSED(arg);
  
  mat_App = naAlloc(MATApplication);
  
  NAString* appPath = naNewExecutablePath();
  naSetApplicationResourceBasePath(naGetStringUTF8Pointer(appPath));
  //naPresentAlertBox(NA_ALERT_BOX_INFO, "Resource directory", naGetStringUTF8Pointer(appPath));
  naDelete(appPath);

  naSetApplicationName("Matrix Buddy");
  naSetApplicationVersionString(MAT_VERSION_STRING);
  naSetApplicationBuildString(MAT_BUILD_NUMBER_STRING);
  
  #if NA_OS == NA_OS_WINDOWS
    naSetApplicationIconPath("icon.png");
  #endif

  initTranslations();
  initPreferences();

  NAString* copyImagePath = naNewApplicationResourcePath(NA_NULL, "copy", "png");
  NAImage* mainCopyImage = naCreateImageWithFilePath(naGetStringUTF8Pointer(copyImagePath));
  mat_App->copyImageSet = naCreateImageSet(mainCopyImage, NA_UI_RESOLUTION_2x, NA_BLEND_ERODE_LIGHT);

  NAString* pasteImagePath = naNewApplicationResourcePath(NA_NULL, "paste", "png");
  NAImage* mainPasteImage = naCreateImageWithFilePath(naGetStringUTF8Pointer(pasteImagePath));
  mat_App->pasteImageSet = naCreateImageSet(mainPasteImage, NA_UI_RESOLUTION_2x, NA_BLEND_ERODE_LIGHT);

  NAString* settingsImagePath = naNewApplicationResourcePath(NA_NULL, "settings", "png");
  NAImage* mainSettingsImage = naCreateImageWithFilePath(naGetStringUTF8Pointer(settingsImagePath));
  mat_App->settingsImageSet = naCreateImageSet(mainSettingsImage, NA_UI_RESOLUTION_2x, NA_BLEND_ERODE_LIGHT);
}


void postStartup(void* arg){
  NA_UNUSED(arg);
  
  #if NA_OS == NA_OS_MAC_OS_X
    naLoadNib("MainMenu", NA_NULL);
  #endif

  mat_App->mathFont = naCreateFontWithPreset(
    NA_FONT_KIND_MATH,
    NA_FONT_SIZE_HUGE);
  mat_App->helpLineFont = naCreateFontWithPreset(
    NA_FONT_KIND_SYSTEM,
    NA_FONT_SIZE_SMALL);

  mat_App->aboutController = matAllocAboutController();
  mat_App->windowController = matAllocWindowController();
}



void stopApplication(void* arg){
  NA_UNUSED(arg);
  
  matDeallocAboutController(mat_App->aboutController);
  matDeallocWindowController(mat_App->windowController);
  
  naRelease(mat_App->mathFont);
  naRelease(mat_App->helpLineFont);
  naRelease(mat_App->copyImageSet);
  naRelease(mat_App->pasteImageSet);
}



NAFont* matGetMathFont(){
  return mat_App->mathFont;
}
NAFont* matGetHelpLineFont(){
  return mat_App->helpLineFont;
}



NAImageSet* matGetCopyImageSet(){
  return mat_App->copyImageSet;
}
NAImageSet* matGetPasteImageSet(){
  return mat_App->pasteImageSet;
}
NAImageSet* matGetSettingsImageSet(){
  return mat_App->settingsImageSet;
}



void matShowApplicationAbout(){
  matShowAboutController(mat_App->aboutController);
}
void matShowApplicationHelp(){
  naOpenURLInBrowser(matTranslate(MATApplicationHelpURL));
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
