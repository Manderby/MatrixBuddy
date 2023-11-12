
#include "MATView.h"



typedef struct MATMulM33SController MATMulM33SController;

MATMulM33SController* matAllocMulM33SController(size_t dimensions);

NASpace* naGetMulM33SSpace(MATMulM33SController* con);

void naUpdateMulM33SController(MATMulM33SController* con);

