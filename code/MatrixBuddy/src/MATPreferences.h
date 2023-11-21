
#include "NAPreferences.h"

enum{
  MATPrefShowHelp,
  MATPrefShowIdentifiers,
  MATPrefShowCopyPaste,
  MATPrefUseRowFirstTabOrder,
  MATPrefCodeStyle,
  MATPrefValueAccuracy,
  
  MATPrefCount
};

extern const char* matPrefs[MATPrefCount];

void initPreferences(void);
