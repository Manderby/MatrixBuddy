
#include "MATView.h"
#include "MATBaseController.h"



typedef struct MATMulMSController MATMulMSController;

MATBaseController* matAllocMulMSController(size_t dimensions);
void matDeallocMulMSController(MATBaseController* con);

void naUpdateMulMSController(MATBaseController* controller, NABool justResult);

