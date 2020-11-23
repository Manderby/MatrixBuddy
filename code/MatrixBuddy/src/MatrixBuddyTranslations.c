
#include "MatrixBuddyTranslations.h"

NAInt translatorGroup;

const NAUTF8Char* matTranslate(NAInt id){
  return naTranslate(translatorGroup, id);
}

void initTranslations(){
  translatorGroup = naRegisterTranslatorGroup();
  #include "MatrixBuddyStrings_eng.h"
  #include "MatrixBuddyStrings_deu.h"
}
