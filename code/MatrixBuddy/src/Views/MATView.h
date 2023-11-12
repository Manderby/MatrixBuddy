
#include "MATCommonC.h"

typedef struct MATView MATView;

MATView* matAllocView(
  const NAUTF8Char* label,
  NAInt dimensionX,
  NAInt dimensionY,
  MATValueChangedHandler handler,
  void* con,
  const double* initValues);

void matDeallocView(MATView* view);

void matSetViewStatus(MATView* view, MATStatus status);

void matUpdateView(MATView* view);

const double* matGetViewValues(const MATView* view);
void matSetViewValues(MATView* view, const double* values);

NASpace* matGetViewSpace(const MATView* view);
