
#include "MATBaseController.h"


void matInitBaseController(
  MATBaseController* con,
  size_t dimensions,
  MATTranslation helpLineId,
  MATValueChangedHandler valuesChanged,
  MATUpdateHandler update,
  MATUpdateTabOrderHandler updateTabOrder)
{
  con->dimensions = dimensions;

  double viewWidth = 991;
  double viewHeight = 197;
  con->space = naNewSpace(naMakeSize(viewWidth, viewHeight));
  con->helpLine = naNewLabel(matTranslate(helpLineId), viewWidth);
  naSetLabelTextAlignment(con->helpLine, NA_TEXT_ALIGNMENT_CENTER);
  naSetLabelFont(con->helpLine, matGetHelpLineFont());
  naAddSpaceChild(
    con->space,
    con->helpLine,
    naMakePos(0, viewHeight - naGetUIElementRect(con->helpLine).size.height + MAT_LABEL_SHIFT_Y));
  
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



void matUpdateController(MATBaseController* con){
  naSetLabelVisible(con->helpLine, matHasShowHelp());

  con->update(con);
}



void matUpdateControllerTabOrder(MATBaseController* con){
  con->updateTabOrder(con);
}
