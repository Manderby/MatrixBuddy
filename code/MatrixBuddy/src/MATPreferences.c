
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
  naInitPreferencesBool(matPrefs[MATPrefShowHelp], NA_FALSE);
  naInitPreferencesBool(matPrefs[MATPrefShowIdentifiers], NA_TRUE);
  naInitPreferencesBool(matPrefs[MATPrefShowCopyPaste], NA_TRUE);
  naInitPreferencesBool(matPrefs[MATPrefUseRowFirstTabOrder], NA_TRUE);
  naInitPreferencesEnum(matPrefs[MATPrefCodeStyle], MAT_CODE_STYLE_C_ROW_FIRST_1D);
  naInitPreferencesEnum(matPrefs[MATPrefValueAccuracy], MAT_VALUE_ACCURACY_NATURAL);
  
  // Legacy:
  if(naGetPreferencesEnum(matPrefs[MATPrefCodeStyle]) == MAT_CODE_STYLE_LEGACY_NONE){
    naSetPreferencesEnum(matPrefs[MATPrefCodeStyle], MAT_CODE_STYLE_C_ROW_FIRST_1D);
  }
}
