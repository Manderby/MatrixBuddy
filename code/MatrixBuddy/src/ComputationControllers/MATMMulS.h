
#include "MATView.h"
#include "MATBaseController.h"



typedef struct MATMMulSController MATMMulSController;

MATBaseController* matAllocMMulSController(size_t dimensions);
void matDeallocMMulSController(MATBaseController* con);

void matUpdateMMulSController(MATBaseController* controller);

