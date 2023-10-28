
#include "MATCommon.h"
#include "MATApplication.h"
#include "MatrixBuddyTranslations.h"
#include "MatrixBuddyPreferences.h"
#include "NAApp.h"
#include "ManderAppAbout.h"


const char* MATPrefShowHelp = "showHelp";
const char* MATPrefShowIdentifiers = "showIdentifiers";
const char* MATPrefUseRowFirstTabOrder = "useRowFirstTabOrder";
const char* MATPrefCodeStyle = "codeStyle";
const char* MATPrefValueAccuracy = "valueAccuracy";

#define MAT_WINDOW_TAG_ABOUT 1

void prestartup(void* arg){
  NA_UNUSED(arg);
  
//  naSetApplicationName("Matrix Buddy");
//  //naSetApplicationCompanyName("ASuppaCombbany");
//  naSetApplicationVersionString("1.1.1");
//  naSetApplicationBuildString("1.1.4");
//  naSetApplicationIconPath("icon.png");

  mandInitManderApp();
  initTranslations();
  initPreferences();
}

void poststartup(void* arg){
  NA_UNUSED(arg);
  
  mandCreateUI();
  mandSetAboutWindowStorageTag(MAT_WINDOW_TAG_ABOUT);

  naLoadNib("MainMenu", NA_NULL);
  matPrepareFirstView();

  mandSetAboutDescriptionAndHelpURL(matTranslate(MatrixBuddyApplicationDescription), matTranslate(MatrixBuddyApplicationHelpURL));
  mandAlertNewVersion(matTranslate(MatrixBuddyNewVersionDescription));
}

int main(int argc, char *argv[]){
  NA_UNUSED(argc);
  NA_UNUSED(argv);
  naStartRuntime();
  [MATApplication sharedApplication];
  naStartApplication(prestartup, poststartup, NA_NULL, NA_NULL);
  naStopRuntime();
  return 0;
}

