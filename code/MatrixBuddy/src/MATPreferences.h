
#ifndef MAT_PREFERENCES_INCLUDED
#define MAT_PREFERENCES_INCLUDED



#include "NAPreferences.h"
#include "MATTypes.h"



void initPreferences(void);

NABool matGetShowHelp(void);
void matToggleShowHelp(void);

NABool matGetShowIdentifiers(void);
void matToggleShowIdentifiers(void);

NABool matGetShowCopyPaste(void);
void matToggleShowCopyPaste(void);

NABool matGetUseRowFirstTabOrder(void);
void matSetUseRowFirstTabOrder(NABool useRowFirst);

MATCodeStyle matGetCodeStyle(void);
void matSetCodeStyle(MATCodeStyle codeStyle);

MATValueAccuracy matGetValueAccuracy(void);
void matSetValueAccuracy(MATValueAccuracy valueAccuracy);



#endif // MAT_PREFERENCES_INCLUDED
