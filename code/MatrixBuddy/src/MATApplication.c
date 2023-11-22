
#include "MATApplication.h"
#include "MATTypes.h"
#include "MATTranslations.h"
#include "MATPreferences.h"
#include "MATWindowController.h"
#include "MATAboutController.h"





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



void matFillBabyColor(NABabyColor* babyColor, MATColor color){
  static const NABabyColor matColors[] = {
    [MAT_COLOR_NORMAL]  = {0., 0., 0., 0.,},
    [MAT_COLOR_RESULT]  = {0., .4, .025, 1.,},
    [MAT_COLOR_ERROR]   = {.7, .025, 0., 1.,},
    [MAT_COLOR_WARNING] = {.4, .25, 0., 1.,},
  };
  naCopyn(*babyColor, &matColors[color], sizeof(NABabyColor));
}










typedef struct MATApplication MATApplication;
struct MATApplication{
  NAFont* mathFont;
  NAFont* helpLineFont;
  NAUIImage* copyImage;
  NAUIImage* pasteImage;
  MATAboutController* aboutController;
  MATWindowController* windowController;
};

static MATApplication* mat_App = NA_NULL;



void preStartup(void* arg){
  NA_UNUSED(arg);
  
  mat_App = naAlloc(MATApplication);
  
//  naSetApplicationName("Matrix Buddy");
//  //naSetApplicationCompanyName("ASuppaCombbany");
//  naSetApplicationVersionString("1.1.1");
//  naSetApplicationBuildString("1.1.4");
//  naSetApplicationIconPath("icon.png");

  initTranslations();
  initPreferences();

  NAString* copyImagePath = naNewApplicationResourcePath(NA_NULL, "copy", "png");
  NABabyImage* mainCopyImage = naCreateBabyImageFromFilePath(naGetStringUTF8Pointer(copyImagePath));
  mat_App->copyImage = naCreateUIImage(mainCopyImage, NA_UIIMAGE_RESOLUTION_SCREEN_2x, NA_BLEND_ERODE_LIGHT);

  NAString* pasteImagePath = naNewApplicationResourcePath(NA_NULL, "paste", "png");
  NABabyImage* mainPasteImage = naCreateBabyImageFromFilePath(naGetStringUTF8Pointer(pasteImagePath));
  mat_App->pasteImage = naCreateUIImage(mainPasteImage, NA_UIIMAGE_RESOLUTION_SCREEN_2x, NA_BLEND_ERODE_LIGHT);
}



void postStartup(void* arg){
  NA_UNUSED(arg);
  
  naLoadNib("MainMenu", NA_NULL);
  
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
  naRelease(mat_App->copyImage);
  naRelease(mat_App->pasteImage);

  naFree(mat_App);
  naStopRuntime();
}



NAFont* matGetMathFont(){
  return mat_App->mathFont;
}
NAFont* matGetHelpLineFont(){
  return mat_App->helpLineFont;
}



NAUIImage* matGetCopyImage(){
  return mat_App->copyImage;
}


NAUIImage* matGetPasteImage(){
  return mat_App->pasteImage;
}



void matShowApplicationAbout(){
  matShowAboutController(mat_App->aboutController);
}
void matShowApplicationHelp(){
  naOpenURLInBrowser(matTranslate(MATApplicationHelpURL));
}
