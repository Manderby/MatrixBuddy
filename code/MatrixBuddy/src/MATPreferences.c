
#include "MATPreferences.h"
#include "MATTypes.h"

const char* matPrefs[MATPrefCount] = {
  "showHelp",
  "showIdentifiers",
  "showCopyPaste",
  "useRowFirstTabOrder",
  "codeStyle",
  "valueAccuracy",
};

void initPreferences(){
  naInitPreferencesBool(matPrefs[ShowHelp], NA_FALSE);
  naInitPreferencesBool(matPrefs[ShowIdentifiers], NA_TRUE);
  naInitPreferencesBool(matPrefs[ShowCopyPaste], NA_TRUE);
  naInitPreferencesBool(matPrefs[UseRowFirstTabOrder], NA_TRUE);
  naInitPreferencesEnum(matPrefs[CodeStyle], MAT_CODE_STYLE_C_ROW_FIRST_1D);
  naInitPreferencesEnum(matPrefs[ValueAccuracy], MAT_VALUE_ACCURACY_NATURAL);
  
  // Legacy:
  if(naGetPreferencesEnum(matPrefs[CodeStyle]) == MAT_CODE_STYLE_LEGACY_NONE){
    naSetPreferencesEnum(matPrefs[CodeStyle], MAT_CODE_STYLE_C_ROW_FIRST_1D);
  }
}
