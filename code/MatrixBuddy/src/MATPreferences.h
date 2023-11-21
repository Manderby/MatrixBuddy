
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

extern const char* matPrefs[MATPrefCount];

void initPreferences(void);
