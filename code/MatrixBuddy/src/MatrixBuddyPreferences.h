
#include "NAPreferences.h"

enum{
  ShowHelp,
  ShowIdentifiers,
  ShowCopyPaste,
  UseRowFirstTabOrder,
  CodeStyle,
  ValueAccuracy,
  
  MATPrefCount
};

extern const char* MATPrefs[MATPrefCount];

void initPreferences();
