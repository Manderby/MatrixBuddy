
#include "MATCommonC.h"

typedef struct MATViewSASDF MATViewSASDF;

MATViewSASDF* matAllocViewS(
  MATValueChangedHandler handler,
  void* con,
  const double* initValues);
void matDeallocViewS(MATViewSASDF* view);

void matSetViewSStatus(MATViewSASDF* view, MATStatus status);

void matUpdateViewS(MATViewSASDF* view);

const double* matGetViewSValues(const MATViewSASDF* view);
const NASpace* matGetViewSSpace(const MATViewSASDF* view);
