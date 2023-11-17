
#ifndef MAT_BASE_CONTROLLER_INCLUDED
#define MAT_BASE_CONTROLLER_INCLUDED

#include "MATView.h"
#include "MATTranslations.h"


struct MATBaseController{
  NASpace* space;
  NALabel* helpLine;
  size_t dimensions;
  MATValueChangedHandler valuesChanged;
  MATUpdateHandler update;
  MATUpdateTabOrderHandler updateTabOrder;
};

void matInitBaseController(
  MATBaseController* con,
  size_t dimensions,
  MATTranslation helpLineId,
  MATValueChangedHandler valuesChanged,
  MATUpdateHandler update,
  MATUpdateTabOrderHandler updateTabOrder);

NASpace* naGetControllerSpace(MATBaseController* con);

size_t matGetControllerDimensions(MATBaseController* con);

void matNotifyControllerValuesChanged(MATBaseController* con, MATView* view);

void matUpdateController(MATBaseController* con);

void matUpdateControllerTabOrder(MATBaseController* con);



// Alloc functions of the specific controllers.
MATBaseController* matAllocMDivCompMController(size_t dimensions);
MATBaseController* matAllocMMulCompMController(size_t dimensions);
MATBaseController* matAllocMDivCompVController(size_t dimensions);
MATBaseController* matAllocMMulCompVController(size_t dimensions);
MATBaseController* matAllocMDivSController(size_t dimensions);
MATBaseController* matAllocMMulSController(size_t dimensions);

// Dealloc functions of the specific controllers.
void matDeallocMDivCompMController(MATBaseController* con);
void matDeallocMMulCompMController(MATBaseController* con);
void matDeallocMDivCompVController(MATBaseController* con);
void matDeallocMMulCompVController(MATBaseController* con);
void matDeallocMDivSController(MATBaseController* con);
void matDeallocMMulSController(MATBaseController* con);



#endif // MAT_BASE_CONTROLLER_INCLUDED
