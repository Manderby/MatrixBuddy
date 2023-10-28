
#include "NAApp.h"
#include "MATCommonC.h"

typedef struct MATValueViewASDF MATValueViewASDF;
struct MATValueViewASDF{
  double* values;
  NASpace* space;
  NALabel* label;
};


// Init and clear
void mat_InitValueView(
  MATValueViewASDF* valueView,
  size_t valueCount);
void mat_ClearValueView(
  MATValueViewASDF* valueView);

// View methods
void mat_UpdateValueView(
  MATValueViewASDF* valueView);
NASpace* matGetValueViewSpace(
  void* view);
void matSetValueViewLabel(
  void* view,
  const NAUTF8Char* text);

// Value methods
const double* matGetValueViewValues(
  const void* view);
void mat_SetValueViewValue(
  const void* view,
  size_t index,
  double value);

