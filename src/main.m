
#include "MATCommon.h"
#include "MATApplication.h"
#include "MatrixBuddyTranslations.h"
#include "MatrixBuddyPreferences.h"
#include "NAUI.h"
#include "ManderAppAbout.h"


const char* MATPrefShowHelp = "showHelp";
const char* MATPrefShowIdentifiers = "showIdentifiers";
const char* MATPrefUseRowFirstTabOrder = "useRowFirstTabOrder";
const char* MATPrefCodeStyle = "codeStyle";
const char* MATPrefValueAccuracy = "valueAccuracy";


void prestartup(void* arg){
  NA_UNUSED(arg);
  mandInitManderApp();
  initTranslations();
  initPreferences();
}

void poststartup(void* arg){
  NA_UNUSED(arg);
  mandCreateUI();
  naLoadNib("MainMenu");
  
  mandSetAboutDescriptionAndHelpURL(matTranslate(MatrixBuddyApplicationDescription), matTranslate(MatrixBuddyApplicationHelpURL));
  mandAlertNewVersion(matTranslate(MatrixBuddyNewVersionDescription));
}

int main(int argc, char *argv[]){
  NA_UNUSED(argc);
  NA_UNUSED(argv);
  naStartRuntime();
  [MATApplication sharedApplication];
  naStartApplication(prestartup, poststartup, NA_NULL);
  return 0;
}
