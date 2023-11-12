
#include "MATCommon.h"
#include "MATApplication.h"
#include "MATTranslations.h"
#include "MATPreferences.h"
#include "NAApp.h"


const char* MATPrefShowHelp = "showHelp";
const char* MATPrefShowIdentifiers = "showIdentifiers";
const char* MATPrefUseRowFirstTabOrder = "useRowFirstTabOrder";
const char* MATPrefCodeStyle = "codeStyle";
const char* MATPrefValueAccuracy = "valueAccuracy";


void preStartup(void* arg){
  NA_UNUSED(arg);
  
//  naSetApplicationName("Matrix Buddy");
//  //naSetApplicationCompanyName("ASuppaCombbany");
//  naSetApplicationVersionString("1.1.1");
//  naSetApplicationBuildString("1.1.4");
//  naSetApplicationIconPath("icon.png");

  initTranslations();
  initPreferences();
}

void postStartup(void* arg){
  NA_UNUSED(arg);
  
  naLoadNib("MainMenu", NA_NULL);
  matPrepareFirstView();

  //mandAlertNewVersion(matTranslate(MATNewVersionDescription));
}

void stopApplication(void* arg){
  NA_UNUSED(arg);
}

int main(int argc, char *argv[]){
  NA_UNUSED(argc);
  NA_UNUSED(argv);
  naStartRuntime();
  [MATApplication sharedApplication];
  naStartApplication(preStartup, postStartup, stopApplication, NA_NULL);
  naStopRuntime();
  return 0;
}

