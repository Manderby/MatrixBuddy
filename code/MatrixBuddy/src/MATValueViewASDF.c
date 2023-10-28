
#include "MATValueViewASDF.h"
#include "MATCommonC.h"


void mat_InitValueView(
  MATValueViewASDF* valueView,
  size_t valueCount)
{
  valueView->values = naMalloc(valueCount * sizeof(double));

  valueView->space = naNewSpace(naMakeSize(100, 100));
  
  NAFont* font = naCreateFontWithPreset(NA_FONT_KIND_MATH, NA_FONT_SIZE_HUGE);
  
  valueView->label = naNewLabel("s\u207b\u00b9\u1d40", MAT_TEXTFIELD_WIDTH);
  naSetLabelFont(valueView->label, font);
  naSetLabelTextAlignment(valueView->label, NA_TEXT_ALIGNMENT_CENTER);
  naSetLabelHeight(valueView->label, 40);
  naAddSpaceChild(valueView->space, valueView->label, naMakePos(10, 50));
  
  naRelease(font);
}



void mat_ClearValueView(MATValueViewASDF* valueView){
  naFree(valueView->values);
}



void mat_UpdateValueView(MATValueViewASDF* valueView){
  NA_UNUSED(valueView);
}



NASpace* matGetValueViewSpace(void* view){
  MATValueViewASDF* valueView = (MATValueViewASDF*)view;
  return valueView->space;
}



void matSetValueViewLabel(void* view, const NAUTF8Char* text){
  MATValueViewASDF* valueView = (MATValueViewASDF*)view;
  naSetLabelText(valueView->label, text);
}



const double* matGetValueViewValues(const void* view){
  MATValueViewASDF* valueView = (MATValueViewASDF*)view;
  return valueView->values;
}

void mat_SetValueViewValue(const void* view, size_t index, double value){
  MATValueViewASDF* valueView = (MATValueViewASDF*)view;
  valueView->values[index] = value;
}


