
#include "MatrixBuddyPreferences.h"
#include "MATTypes.h"

const char* MATPrefs[MATPrefCount] = {
  "showHelp",
  "showIdentifiers",
  "showCopyPaste",
  "useRowFirstTabOrder",
  "codeStyle",
  "valueAccuracy",
};

void initPreferences(){
  naInitPreferencesBool(MATPrefs[ShowHelp], NA_FALSE);
  naInitPreferencesBool(MATPrefs[ShowIdentifiers], NA_TRUE);
  naInitPreferencesBool(MATPrefs[ShowCopyPaste], NA_TRUE);
  naInitPreferencesBool(MATPrefs[UseRowFirstTabOrder], NA_TRUE);
  naInitPreferencesEnum(MATPrefs[CodeStyle], MAT_CODE_STYLE_C_ROW_FIRST_1D);
  naInitPreferencesEnum(MATPrefs[ValueAccuracy], MAT_VALUE_ACCURACY_NATURAL);
  
  // Legacy:
  if(naGetPreferencesEnum(MATPrefs[CodeStyle]) == MAT_CODE_STYLE_LEGACY_NONE){
    naSetPreferencesEnum(MATPrefs[CodeStyle], MAT_CODE_STYLE_C_ROW_FIRST_1D);
  }
}
