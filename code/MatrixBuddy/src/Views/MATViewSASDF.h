
#include "../MATInputMatrix.h"
#include "MATCommonC.h"

typedef struct MATViewSASDF MATViewSASDF;

MATViewSASDF* matAllocViewS(MATValueChangedHandler handler, void* con);
void matDeallocViewS(MATViewSASDF* view);

void mat_UpdateViewS(MATViewSASDF* view);

// Value methods
const double* matGetViewSValues(const MATViewSASDF* view);
