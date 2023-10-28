
#include "MATInputMatrix.h"
#include "MATCommonC.h"


void mat_InitInputMatrix(
  MATInputMatrix* matrix,
  const NAUTF8Char* labelText,
  size_t valueCount)
{
  matrix->values = naMalloc(valueCount * sizeof(double));

  matrix->space = naNewSpace(naMakeSize(100, 100));
  
  NAFont* font = naCreateFontWithPreset(NA_FONT_KIND_MATH, NA_FONT_SIZE_HUGE);
  
  matrix->label = naNewLabel(labelText, MAT_TEXTFIELD_WIDTH);
  naSetLabelFont(matrix->label, font);
  naSetLabelTextAlignment(matrix->label, NA_TEXT_ALIGNMENT_CENTER);
  naSetLabelHeight(matrix->label, 40);
  naAddSpaceChild(matrix->space, matrix->label, naMakePos(10, 50));
    
  naRelease(font);
  
}



void mat_ClearInputMatrix(MATInputMatrix* matrix){
  naFree(matrix->values);
}



void mat_UpdateInputMatrix(MATInputMatrix* matrix){
  NA_UNUSED(matrix);
}



NASpace* matGetValueViewSpace(void* object){
  MATInputMatrix* matrix = (MATInputMatrix*)object;
  return matrix->space;
}



const double* matGetInputMatrixValues(const void* object){
  MATInputMatrix* matrix = (MATInputMatrix*)object;
  return matrix->values;
}

void mat_SetInputMatrixValue(const void* object, size_t index, double value){
  MATInputMatrix* matrix = (MATInputMatrix*)object;
  matrix->values[index] = value;
}


