
#include "MATCommon.h"
#include "MATApplication.h"


const char* MATPrefShowHelp = "showHelp";
const char* MATPrefShowIdentifiers = "showIdentifiers";
const char* MATPrefUseRowFirstTabOrder = "useRowFirstTabOrder";
const char* MATPrefCodeStyle = "codeStyle";
const char* MATPrefValueAccuracy = "valueAccuracy";


void poststartup(void* arg){
  NA_UNUSED(arg);
  [NSBundle loadNibNamed:@"MainMenu" owner:NSApp];
}

int main(int argc, char *argv[]){
  NA_UNUSED(argc);
  NA_UNUSED(argv);
  naStartRuntime();
  [MATApplication sharedApplication];
  naStartApplication(NA_NULL, poststartup, NA_NULL);
  return 0;
}
