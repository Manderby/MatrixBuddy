
#ifndef MAT_BASE_CONTROLLER_INCLUDED
#define MAT_BASE_CONTROLLER_INCLUDED

#include "MATView.h"



struct MATBaseController{
  NASpace* space;
  size_t dimensions;
  MATValueChangedHandler updateValues;
  MATUpdateTabOrderHandler updateTabOrder;
};

void matInitBaseController(
  MATBaseController* con,
  size_t dimensions,
  MATValueChangedHandler updateValues,
  MATUpdateTabOrderHandler updateTabOrder);

NASpace* naGetControllerSpace(MATBaseController* con);

size_t matGetControllerDimensions(MATBaseController* con);

void matUpdateControllerValues(MATBaseController* con, MATView* view);

void matUpdateControllerTabOrder(MATBaseController* con);

#endif // MAT_BASE_CONTROLLER_INCLUDED
