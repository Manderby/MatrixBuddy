
#include "MATInputMatrix.h"
#include "MATCommonC.h"


NABool mat_PressCopy(NAReaction reaction){

  return NA_TRUE;
}

NABool mat_PressPaste(NAReaction reaction){

  return NA_TRUE;
}



void mat_InitInputMatrix(
  MATInputMatrix* matrix,
  const NAUTF8Char* labelText)
{
  matrix->space = naNewSpace(naMakeSize(100, 100));
   
  matrix->label = naNewLabel(labelText, MAT_TEXTFIELD_WIDTH);
  naSetLabelFont(matrix->label, matGetMathFont());
  naSetLabelTextAlignment(matrix->label, NA_TEXT_ALIGNMENT_CENTER);
  naSetLabelHeight(matrix->label, 40);
  naAddSpaceChild(matrix->space, matrix->label, naMakePos(10, 50));
    
  matrix->copyButton = naNewImagePushButton(matGetCopyImage(), naMakeSize(30, 20));
  naAddUIReaction(matrix->copyButton, NA_UI_COMMAND_PRESSED, mat_PressCopy, matrix);
  naAddSpaceChild(matrix->space, matrix->copyButton, naMakePos(10, 10));

  matrix->pasteButton = naNewImagePushButton(matGetPasteImage(), naMakeSize(30, 20));
  naAddUIReaction(matrix->pasteButton, NA_UI_COMMAND_PRESSED, mat_PressPaste, matrix);
  naAddSpaceChild(matrix->space, matrix->pasteButton, naMakePos(50, 10));
}



void mat_ClearInputMatrix(MATInputMatrix* matrix){
  NA_UNUSED(matrix);
}



void mat_UpdateInputMatrix(MATInputMatrix* matrix){
  NA_UNUSED(matrix);
}



NASpace* matGetValueViewSpace(void* object){
  MATInputMatrix* matrix = (MATInputMatrix*)object;
  return matrix->space;
}



