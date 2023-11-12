
#include "MATView.h"
#include "MATBaseController.h"



typedef struct MATMDivSController MATMDivSController;

MATBaseController* matAllocMDivSController(size_t dimensions);
void matDeallocMDivSController(MATBaseController* con);

void matUpdateMDivSController(MATBaseController* controller);
