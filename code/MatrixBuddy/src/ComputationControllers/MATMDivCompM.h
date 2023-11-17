#include "MATView.h"
#include "MATBaseController.h"



typedef struct MATMDivCompMController MATMDivCompMController;

MATBaseController* matAllocMDivCompMController(size_t dimensions);
void matDeallocMDivCompMController(MATBaseController* con);

void matUpdateMDivCompMController(MATBaseController* controller);


