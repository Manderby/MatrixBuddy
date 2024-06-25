
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
  naInitPreferencesEnum(matPrefs[MATPrefCodeStyle], MAT_CODE_STYLE_C_ROW_FIRST_1D, MAT_CODE_STYLE_COUNT);
  naInitPreferencesEnum(matPrefs[MATPrefValueAccuracy], MAT_VALUE_ACCURACY_NATURAL, MAT_VALUE_ACCURACY_COUNT);
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



// This is free and unencumbered software released into the public domain.

// Anyone is free to copy, modify, publish, use, compile, sell, or
// distribute this software, either in source code form or as a compiled
// binary, for any purpose, commercial or non-commercial, and by any
// means.

// In jurisdictions that recognize copyright laws, the author or authors
// of this software dedicate any and all copyright interest in the
// software to the public domain. We make this dedication for the benefit
// of the public at large and to the detriment of our heirs and
// successors. We intend this dedication to be an overt act of
// relinquishment in perpetuity of all present and future rights to this
// software under copyright law.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
// IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
// OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
// ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
// OTHER DEALINGS IN THE SOFTWARE.

// For more information, please refer to <http://unlicense.org/>
