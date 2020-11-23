
#include "MatrixBuddyPreferences.h"
#include "MATTypes.h"

const char* MATPrefs[MATPrefCount] = {
  "showHelp",
  "showIdentifiers",
  "useRowFirstTabOrder",
  "codeStyle",
  "valueAccuracy",
};

void initPreferences(){
  naInitPreferencesBool(MATPrefs[ShowHelp], NA_FALSE);
  naInitPreferencesBool(MATPrefs[ShowIdentifiers], NA_TRUE);
  naInitPreferencesBool(MATPrefs[UseRowFirstTabOrder], NA_TRUE);
  naInitPreferencesEnum(MATPrefs[CodeStyle], MAT_CODE_STYLE_NONE);
  naInitPreferencesEnum(MATPrefs[ValueAccuracy], MAT_VALUE_ACCURACY_NATURAL);
}
