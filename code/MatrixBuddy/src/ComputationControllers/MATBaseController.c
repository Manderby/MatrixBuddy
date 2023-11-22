
#include "MATBaseController.h"
#include "MATPreferences.h"
#include "MATApplication.h"


void matInitBaseController(
  MATBaseController* con,
  size_t dimensions,
  MATTranslation helpLineId,
  MATValueChangedHandler valuesChanged,
  MATUpdateHandler update,
  MATUpdateTabOrderHandler updateTabOrder)
{
  con->dimensions = dimensions;

  double viewWidth = 1105;
  double viewHeight = 231;
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
  naSetLabelVisible(con->helpLine, matGetShowHelp());

  con->update(con);
}



void matUpdateControllerTabOrder(MATBaseController* con){
  con->updateTabOrder(con);
}



// This is free and unencumbered software released into the public domain.

// Anyone is free to copy, modify, publish, use, compile, sell, or
// distribute this software, either in source code form or as a compiled
// binary, for any purpose, commercial or non-commercial, and by any
// means.

// In jurisdictions that recognize copyright laws, the author or authors
// of this software dedicate any and all copyright interest in the
// software to the public domain. We make this dedication for the benefit
// of the public at large and to the detriment of our heirs and
// successors. We intend this dedication to be an overt act of
// relinquishment in perpetuity of all present and future rights to this
// software under copyright law.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
// IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
// OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
// ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
// OTHER DEALINGS IN THE SOFTWARE.

// For more information, please refer to <http://unlicense.org/>
