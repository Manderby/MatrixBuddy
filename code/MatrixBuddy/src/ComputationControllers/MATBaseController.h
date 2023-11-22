
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
MATBaseController* matAllocMAddMController      (size_t dimensions);
MATBaseController* matAllocMDiagSController     (size_t dimensions);
MATBaseController* matAllocMDiagVController     (size_t dimensions);
MATBaseController* matAllocMDivCompMController  (size_t dimensions);
MATBaseController* matAllocMDivCompVController  (size_t dimensions);
MATBaseController* matAllocMDivSController      (size_t dimensions);
MATBaseController* matAllocMInvertController    (size_t dimensions);
MATBaseController* matAllocMMulCompMController  (size_t dimensions);
MATBaseController* matAllocMMulCompVController  (size_t dimensions);
MATBaseController* matAllocMMulMController      (size_t dimensions);
MATBaseController* matAllocMMulSController      (size_t dimensions);
MATBaseController* matAllocMMulVController      (size_t dimensions);
MATBaseController* matAllocMNegController       (size_t dimensions);
MATBaseController* matAllocMSubMController      (size_t dimensions);
MATBaseController* matAllocMTransposeController (size_t dimensions);
MATBaseController* matAllocVAddVController      (size_t dimensions);
MATBaseController* matAllocVCrossVController    (size_t dimensions);
MATBaseController* matAllocVDivCompVController  (size_t dimensions);
MATBaseController* matAllocVDivSController      (size_t dimensions);
MATBaseController* matAllocVDotVController      (size_t dimensions);
MATBaseController* matAllocVLengthController    (size_t dimensions);
MATBaseController* matAllocVMirrorController    (size_t dimensions);
MATBaseController* matAllocVMulCompVController  (size_t dimensions);
MATBaseController* matAllocVMulSController      (size_t dimensions);
MATBaseController* matAllocVNegController       (size_t dimensions);
MATBaseController* matAllocVNormalizeController (size_t dimensions);
MATBaseController* matAllocVOrthoController     (size_t dimensions);
MATBaseController* matAllocVSubVController      (size_t dimensions);

// Dealloc functions of the specific controllers.
void matDeallocMAddMController      (MATBaseController* con);
void matDeallocMDiagSController     (MATBaseController* con);
void matDeallocMDiagVController     (MATBaseController* con);
void matDeallocMDivCompMController  (MATBaseController* con);
void matDeallocMDivCompVController  (MATBaseController* con);
void matDeallocMDivSController      (MATBaseController* con);
void matDeallocMInvertController    (MATBaseController* con);
void matDeallocMMulCompMController  (MATBaseController* con);
void matDeallocMMulCompVController  (MATBaseController* con);
void matDeallocMMulMController      (MATBaseController* con);
void matDeallocMMulSController      (MATBaseController* con);
void matDeallocMMulVController      (MATBaseController* con);
void matDeallocMNegController       (MATBaseController* con);
void matDeallocMSubMController      (MATBaseController* con);
void matDeallocMTransposeController (MATBaseController* con);
void matDeallocVAddVController      (MATBaseController* con);
void matDeallocVCrossVController    (MATBaseController* con);
void matDeallocVDivCompVController  (MATBaseController* con);
void matDeallocVDivSController      (MATBaseController* con);
void matDeallocVDotVController      (MATBaseController* con);
void matDeallocVLengthController    (MATBaseController* con);
void matDeallocVMirrorController    (MATBaseController* con);
void matDeallocVMulCompVController  (MATBaseController* con);
void matDeallocVMulSController      (MATBaseController* con);
void matDeallocVNegController       (MATBaseController* con);
void matDeallocVNormalizeController (MATBaseController* con);
void matDeallocVOrthoController     (MATBaseController* con);
void matDeallocVSubVController      (MATBaseController* con);



#endif // MAT_BASE_CONTROLLER_INCLUDED



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
