
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


void prestartup(void* arg){
  NA_UNUSED(arg);
  
//  naSetApplicationName("Matrix Buddy");
//  //naSetApplicationCompanyName("ASuppaCombbany");
//  naSetApplicationVersionString("1.1.1");
//  naSetApplicationBuildString("1.1.4");
//  naSetApplicationIconPath("icon.png");

  initTranslations();
  initPreferences();
}

void poststartup(void* arg){
  NA_UNUSED(arg);
  
  naLoadNib("MainMenu", NA_NULL);
  matPrepareFirstView();

  //mandAlertNewVersion(matTranslate(MATNewVersionDescription));
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

