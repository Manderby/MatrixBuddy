#include "MATView.h"
#include "MATBaseController.h"



typedef struct MATMDivCompVController MATMDivCompVController;

MATBaseController* matAllocMDivCompVController(size_t dimensions);
void matDeallocMDivCompVController(MATBaseController* con);

void matUpdateMDivCompVController(MATBaseController* controller);


