
#include "MATBaseController.h"


void matInitBaseController(
  MATBaseController* con,
  size_t dimensions,
  MATValueChangedHandler valuesChanged,
  MATUpdateHandler update,
  MATUpdateTabOrderHandler updateTabOrder)
{
  con->dimensions = dimensions;

  double viewWidth = 991;
  double viewHeight = 197;
  con->space = naNewSpace(naMakeSize(viewWidth, viewHeight));
  
  con->valuesChanged = valuesChanged;
  con->update = update;
  con->updateTabOrder = updateTabOrder;
}



size_t matGetControllerDimensions(MATBaseController* con){
  return con->dimensions;
}



NASpace* naGetControllerSpace(MATBaseController* con){
  return con->space;
}



void matNotifyControllerValuesChanged(MATBaseController* con, MATView* view){
  con->valuesChanged(con, view);
}



void matUpdateController(MATBaseController* con, NABool justResult){
  con->update(con, justResult);
}



void matUpdateControllerTabOrder(MATBaseController* con){
  con->updateTabOrder(con);
}
