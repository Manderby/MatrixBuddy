
#include "NAPreferences.h"

enum{
  ShowHelp,
  ShowIdentifiers,
  UseRowFirstTabOrder,
  CodeStyle,
  ValueAccuracy,
  
  MATPrefCount
};

extern const char* MATPrefs[MATPrefCount];

void initPreferences();
