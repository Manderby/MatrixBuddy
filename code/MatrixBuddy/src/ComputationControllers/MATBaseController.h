
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
MATBaseController* matAllocMAddMController(size_t dimensions);
MATBaseController* matAllocMDiagSController(size_t dimensions);
MATBaseController* matAllocMDiagVController(size_t dimensions);
MATBaseController* matAllocMDivCompMController(size_t dimensions);
MATBaseController* matAllocMDivCompVController(size_t dimensions);
MATBaseController* matAllocMDivSController(size_t dimensions);
MATBaseController* matAllocMInvertController(size_t dimensions);
MATBaseController* matAllocMMulCompMController(size_t dimensions);
MATBaseController* matAllocMMulCompVController(size_t dimensions);
MATBaseController* matAllocMMulMController(size_t dimensions);
MATBaseController* matAllocMMulSController(size_t dimensions);
MATBaseController* matAllocMMulVController(size_t dimensions);
MATBaseController* matAllocMNegController(size_t dimensions);
MATBaseController* matAllocMSubMController(size_t dimensions);
MATBaseController* matAllocMTransposeController(size_t dimensions);
MATBaseController* matAllocVMirrorController(size_t dimensions);
MATBaseController* matAllocVNormalizeController(size_t dimensions);
MATBaseController* matAllocVOrthoController(size_t dimensions);

// Dealloc functions of the specific controllers.
void matDeallocMAddMController(MATBaseController* con);
void matDeallocMDiagSController(MATBaseController* con);
void matDeallocMDiagVController(MATBaseController* con);
void matDeallocMDivCompMController(MATBaseController* con);
void matDeallocMDivCompVController(MATBaseController* con);
void matDeallocMDivSController(MATBaseController* con);
void matDeallocMInvertController(MATBaseController* con);
void matDeallocMMulCompMController(MATBaseController* con);
void matDeallocMMulCompVController(MATBaseController* con);
void matDeallocMMulMController(MATBaseController* con);
void matDeallocMMulSController(MATBaseController* con);
void matDeallocMMulVController(MATBaseController* con);
void matDeallocMNegController(MATBaseController* con);
void matDeallocMSubMController(MATBaseController* con);
void matDeallocMTransposeController(MATBaseController* con);
void matDeallocVMirrorController(MATBaseController* con);
void matDeallocVNormalizeController(MATBaseController* con);
void matDeallocVOrthoController(MATBaseController* con);



#endif // MAT_BASE_CONTROLLER_INCLUDED
