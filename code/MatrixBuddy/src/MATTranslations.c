#include "MATTranslations.h"

NAInt translatorGroup;

void initTranslations(){
  translatorGroup = naRegisterTranslatorGroup();
  #include "MatrixBuddyStrings_eng.h"
  #include "MatrixBuddyStrings_deu.h"
}

const NAUTF8Char* matTranslate(NAInt id){
  return naTranslate(translatorGroup, id);
}
