
#include "MATPreferences.h"


enum{
  MATPrefShowHelp,
  MATPrefShowIdentifiers,
  MATPrefShowCopyPaste,
  MATPrefUseRowFirstTabOrder,
  MATPrefCodeStyle,
  MATPrefValueAccuracy,
  
  MATPrefCount
};



const char* matPrefs[MATPrefCount] = {
  [MATPrefShowHelp] = "showHelp",
  [MATPrefShowIdentifiers] = "showIdentifiers",
  [MATPrefShowCopyPaste] = "showCopyPaste",
  [MATPrefUseRowFirstTabOrder] = "useRowFirstTabOrder",
  [MATPrefCodeStyle] = "codeStyle",
  [MATPrefValueAccuracy] = "valueAccuracy",
};



void initPreferences(){
  naInitPreferencesBool(matPrefs[MATPrefShowHelp], NA_FALSE);
  naInitPreferencesBool(matPrefs[MATPrefShowIdentifiers], NA_TRUE);
  naInitPreferencesBool(matPrefs[MATPrefShowCopyPaste], NA_TRUE);
  naInitPreferencesBool(matPrefs[MATPrefUseRowFirstTabOrder], NA_TRUE);
  naInitPreferencesEnum(matPrefs[MATPrefCodeStyle], MAT_CODE_STYLE_C_ROW_FIRST_1D);
  naInitPreferencesEnum(matPrefs[MATPrefValueAccuracy], MAT_VALUE_ACCURACY_NATURAL);
}



NABool matGetShowHelp(){
  return naGetPreferencesBool(matPrefs[MATPrefShowHelp]);
}
void matToggleShowHelp(){
  naTogglePreferencesBool(matPrefs[MATPrefShowHelp]);
}



NABool matGetShowIdentifiers(){
  return naGetPreferencesBool(matPrefs[MATPrefShowIdentifiers]);
}
void matToggleShowIdentifiers(){
  naTogglePreferencesBool(matPrefs[MATPrefShowIdentifiers]);
}



NABool matGetShowCopyPaste(){
  return naGetPreferencesBool(matPrefs[MATPrefShowCopyPaste]);
}
void matToggleShowCopyPaste(){
  naTogglePreferencesBool(matPrefs[MATPrefShowCopyPaste]);
}



NABool matGetUseRowFirstTabOrder(){
  return naGetPreferencesBool(matPrefs[MATPrefUseRowFirstTabOrder]);
}
void matSetUseRowFirstTabOrder(NABool useRowFirst){
  naSetPreferencesBool(matPrefs[MATPrefUseRowFirstTabOrder], useRowFirst);
}



MATCodeStyle matGetCodeStyle(){
  return (MATCodeStyle)naGetPreferencesEnum(matPrefs[MATPrefCodeStyle]);
}
void matSetCodeStyle(MATCodeStyle codeStyle){
  naSetPreferencesEnum(matPrefs[MATPrefCodeStyle], codeStyle);
}



MATValueAccuracy matGetValueAccuracy(){
  return (MATValueAccuracy)naGetPreferencesEnum(matPrefs[MATPrefValueAccuracy]);
}
void matSetValueAccuracy(MATValueAccuracy valueAccuracy){
  naSetPreferencesEnum(matPrefs[MATPrefValueAccuracy], valueAccuracy);
}
