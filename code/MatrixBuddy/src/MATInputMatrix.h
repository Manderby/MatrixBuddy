
#include "NAApp.h"
#include "MATCommonC.h"

typedef struct MATInputMatrix MATInputMatrix;
struct MATInputMatrix{
  NASpace* space;
  NALabel* label;
  NAButton* copyButton;
  NAButton* pasteButton;
};


// Init and clear
void mat_InitInputMatrix(
  MATInputMatrix* matrix,
  const NAUTF8Char* labelText);
void mat_ClearInputMatrix(
  MATInputMatrix* matrix);

// View methods
void mat_UpdateInputMatrix(
  MATInputMatrix* matrix);
NASpace* matGetValueViewSpace(
  void* object);

