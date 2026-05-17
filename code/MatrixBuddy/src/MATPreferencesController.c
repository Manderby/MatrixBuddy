
#include "MATPreferencesController.h"

#include "MATTranslations.h"
#include "MATPreferences.h"

#include "NAApp/NAApp.h"
#include "NAUtility/NAMemory.h"



struct MATPreferencesController {
  NAWindow* window;
  
  NALabel* languageLabel;
  NASelect* languageSelect;
  NAMenuItem* languageSystem;
  NAMenuItem* languageDeutsch;
  NAMenuItem* languageEnglish;
  NAMenuItem* languageEspanol;
  NAMenuItem* languageFrancais;
  NAMenuItem* languageKlingon;
  NAMenuItem* languageJapanese;
  NAMenuItem* languageChinese;
  NAMenuItem* languageReport;
};



void mat_ChangePreferencesLanguage(NAReaction reaction){
  MATPreferencesController* con = reaction.controller;

  if(reaction.uiElement == con->languageSystem){
    matSetPrefsPreferredLanguage((NALanguageCode3)0);
  }else if(reaction.uiElement == con->languageDeutsch){
    matSetPrefsPreferredLanguage(NA_LANG_DEU);
  }else if(reaction.uiElement == con->languageEnglish){
    matSetPrefsPreferredLanguage(NA_LANG_ENG);
  }else if(reaction.uiElement == con->languageEspanol){
    matSetPrefsPreferredLanguage(NA_LANG_SPA);
  }else if(reaction.uiElement == con->languageFrancais){
    matSetPrefsPreferredLanguage(NA_LANG_FRA);
  }else if(reaction.uiElement == con->languageKlingon){
    matSetPrefsPreferredLanguage(NA_LANG_TLH);
  }else if(reaction.uiElement == con->languageJapanese){
    matSetPrefsPreferredLanguage(NA_LANG_JPN);
  }else if(reaction.uiElement == con->languageChinese){
    matSetPrefsPreferredLanguage(NA_LANG_ZHO);
  }

  naPresentAlertBox(
    NA_ALERT_BOX_INFO,
    matTranslate(MATPreferencesLanguageChangeAlertTitle),
    matTranslate(MATPreferencesLanguageChangeAlertText));

  matUpdatePreferencesController(con);
}



void mat_ReportBadTranslation(NAReaction reaction){
  MATPreferencesController* con = reaction.controller;

  naPresentAlertBox(
    NA_ALERT_BOX_INFO,
    matTranslate(MATPreferencesLanguageBadTranslationTitle),
    matTranslate(MATPreferencesLanguageBadTranslationText));

  matUpdatePreferencesController(con);
}



MATPreferencesController* matAllocPreferencesController(void) {
  MATPreferencesController* con = naAlloc(MATPreferencesController);

  NARect windowRect = naMakeRectS(20, 300, 440, 65);
  con->window = naNewWindow(matTranslate(MATPreferences), windowRect, NA_FALSE);

  NASpace* contentSpace = naGetWindowContentSpace(con->window);

  con->languageLabel = naNewLabel(matTranslate(MATPreferencesLanguage), 250);
  con->languageSelect = naNewSelect(150);
  con->languageSystem = naNewMenuItem(matTranslate(MATPreferencesLanguageSameAsSystem), NA_NULL);
  con->languageDeutsch = naNewMenuItem(matTranslate(MATPreferencesLanguageDeutsch), NA_NULL);
  con->languageEnglish = naNewMenuItem(matTranslate(MATPreferencesLanguageEnglish), NA_NULL);
  con->languageEspanol = naNewMenuItem(matTranslate(MATPreferencesLanguageEspanol), NA_NULL);
  con->languageFrancais = naNewMenuItem(matTranslate(MATPreferencesLanguageFrancais), NA_NULL);
  con->languageKlingon = naNewMenuItem(matTranslate(MATPreferencesLanguageKlingon), NA_NULL);
  con->languageJapanese = naNewMenuItem(matTranslate(MATPreferencesLanguageJapanese), NA_NULL);
  con->languageChinese = naNewMenuItem(matTranslate(MATPreferencesLanguageChinese), NA_NULL);
  con->languageReport = naNewMenuItem(matTranslate(MATPreferencesLanguageReport), NA_NULL);
  naAddSelectMenuItem(con->languageSelect, con->languageSystem, NA_NULL);
  naAddSelectMenuItem(con->languageSelect, naNewMenuSeparator(), NA_NULL);
  naAddSelectMenuItem(con->languageSelect, con->languageDeutsch, NA_NULL);
  naAddSelectMenuItem(con->languageSelect, con->languageEnglish, NA_NULL);
  naAddSelectMenuItem(con->languageSelect, con->languageEspanol, NA_NULL);
  naAddSelectMenuItem(con->languageSelect, con->languageFrancais, NA_NULL);
  naAddSelectMenuItem(con->languageSelect, con->languageKlingon, NA_NULL);
  naAddSelectMenuItem(con->languageSelect, con->languageJapanese, NA_NULL);
  naAddSelectMenuItem(con->languageSelect, con->languageChinese, NA_NULL);
  naAddSelectMenuItem(con->languageSelect, naNewMenuSeparator(), NA_NULL);
  naAddSelectMenuItem(con->languageSelect, con->languageReport, NA_NULL);

  naAddSpaceChild(contentSpace, con->languageLabel, naMakePos(20, 20));
  naAddSpaceChild(contentSpace, con->languageSelect, naMakePos(270, 20));

  naAddUIReaction(con->languageSystem, NA_UI_COMMAND_PRESSED, mat_ChangePreferencesLanguage, con);
  naAddUIReaction(con->languageDeutsch, NA_UI_COMMAND_PRESSED, mat_ChangePreferencesLanguage, con);
  naAddUIReaction(con->languageEnglish, NA_UI_COMMAND_PRESSED, mat_ChangePreferencesLanguage, con);
  naAddUIReaction(con->languageEspanol, NA_UI_COMMAND_PRESSED, mat_ChangePreferencesLanguage, con);
  naAddUIReaction(con->languageFrancais, NA_UI_COMMAND_PRESSED, mat_ChangePreferencesLanguage, con);
  naAddUIReaction(con->languageKlingon, NA_UI_COMMAND_PRESSED, mat_ChangePreferencesLanguage, con);
  naAddUIReaction(con->languageJapanese, NA_UI_COMMAND_PRESSED, mat_ChangePreferencesLanguage, con);
  naAddUIReaction(con->languageChinese, NA_UI_COMMAND_PRESSED, mat_ChangePreferencesLanguage, con);

  naAddUIReaction(con->languageReport, NA_UI_COMMAND_PRESSED, mat_ReportBadTranslation, con);

  return con;
}



void matDeallocPreferencesController(MATPreferencesController* con) {
  naFree(con);
}



void matShowPreferencesController(MATPreferencesController* con) {
  naShowWindow(con->window);
}



void matUpdatePreferencesController(MATPreferencesController* con) {
  NALanguageCode3 languageCode = matGetPrefsPreferredLanguage();

  switch(languageCode){
  case NA_LANG_DEU: naSetSelectItemSelected(con->languageSelect, con->languageDeutsch); break;
  case NA_LANG_ENG: naSetSelectItemSelected(con->languageSelect, con->languageEnglish); break;
  case NA_LANG_SPA: naSetSelectItemSelected(con->languageSelect, con->languageEspanol); break;
  case NA_LANG_FRA: naSetSelectItemSelected(con->languageSelect, con->languageFrancais); break;
  case NA_LANG_TLH: naSetSelectItemSelected(con->languageSelect, con->languageKlingon); break;
  case NA_LANG_JPN: naSetSelectItemSelected(con->languageSelect, con->languageJapanese); break;
  case NA_LANG_ZHO: naSetSelectItemSelected(con->languageSelect, con->languageChinese); break;
  default: naSetSelectItemSelected(con->languageSelect, con->languageSystem); break;
  }
}
