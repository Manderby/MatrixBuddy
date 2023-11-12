
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

void matUpdateController(MATBaseController* con, NABool justResult);

void matUpdateControllerTabOrder(MATBaseController* con);

#endif // MAT_BASE_CONTROLLER_INCLUDED
