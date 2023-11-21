
#include "MATCommon.h"
#include "MATApplication.h"
#include "MATTranslations.h"
#include "MATPreferences.h"
#include "NAApp.h"


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

