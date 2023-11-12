#include "MATView.h"
#include "MATBaseController.h"



typedef struct MATMMulCompVController MATMMulCompVController;

MATBaseController* matAllocMMulCompVController(size_t dimensions);
void matDeallocMMulCompVController(MATBaseController* con);

void matUpdateMMulCompVController(MATBaseController* controller);

