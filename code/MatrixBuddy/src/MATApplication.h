#include "NAApp/NAApp.h"



void preStartup(void* arg);
void postStartup(void* arg);
void stopApplication(void* arg);

NAFont* matGetMathFont(void);
NAFont* matGetHelpLineFont(void);

NAUIImage* matGetCopyImage(void);
NAUIImage* matGetPasteImage(void);

void matShowApplicationAbout(void);
void matShowApplicationHelp(void);
