
#include "MATView.h"
#include "MATBaseController.h"



typedef struct MATMMulCompMController MATMMulCompMController;

MATBaseController* matAllocMMulCompMController(size_t dimensions);
void matDeallocMMulCompMController(MATBaseController* con);

void matUpdateMMulCompMController(MATBaseController* controller);

