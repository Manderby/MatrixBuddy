
#include "NAApp.h"
#include "MATCommonC.h"

typedef struct MATInputMatrix MATInputMatrix;
struct MATInputMatrix{
  double* values;
  NASpace* space;
  NALabel* label;
  NAButton* copyButton;
  NAButton* pasteButton;
};


// Init and clear
void mat_InitInputMatrix(
  MATInputMatrix* matrix,
  const NAUTF8Char* labelText,
  size_t valueCount);
void mat_ClearInputMatrix(
  MATInputMatrix* matrix);

// View methods
void mat_UpdateInputMatrix(
  MATInputMatrix* matrix);
NASpace* matGetValueViewSpace(
  void* object);

// Value methods
const double* matGetInputMatrixValues(
  const void* object);
void mat_SetInputMatrixValue(
  const void* object,
  size_t index,
  double value);

