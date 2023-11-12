
#include "MATCommonC.h"

MATView* matAllocView(
  const NAUTF8Char* label,
  NAInt dimensionX,
  NAInt dimensionY,
  void* con,
  const double* initValues);

void matDeallocView(MATView* view);

void matSetViewStatus(MATView* view, MATStatus status);

void matUpdateView(MATView* view);

const double* matGetViewValues(const MATView* view);
void matSetViewValues(MATView* view, const double* values);

NASpace* matGetViewSpace(const MATView* view);

void matUpdateViewTabOrder(MATView* view);

void matSetViewPasteEnabled(MATView* view, NABool enabled);
