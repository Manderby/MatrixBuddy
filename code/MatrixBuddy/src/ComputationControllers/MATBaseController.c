
#include "MATBaseController.h"


void matInitBaseController(
  MATBaseController* con,
  size_t dimensions,
  MATValueChangedHandler updateValues,
  MATUpdateTabOrderHandler updateTabOrder)
{
  con->dimensions = dimensions;

  double viewWidth = 991;
  double viewHeight = 197;
  con->space = naNewSpace(naMakeSize(viewWidth, viewHeight));
  
  con->updateValues = updateValues;
  con->updateTabOrder = updateTabOrder;
}



size_t matGetControllerDimensions(MATBaseController* con){
  return con->dimensions;
}



NASpace* naGetControllerSpace(MATBaseController* con){
  return con->space;
}



void matUpdateControllerValues(MATBaseController* con, MATView* view){
  con->updateValues(con, view);
}



void matUpdateControllerTabOrder(MATBaseController* con){
  con->updateTabOrder(con);
}
