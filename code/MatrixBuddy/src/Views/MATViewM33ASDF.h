
#include "MATCommonC.h"

typedef struct MATViewM33ASDF MATViewM33ASDF;

MATViewM33ASDF* matAllocViewM33(
  MATValueChangedHandler handler,
  void* con,
  NAInt dimensionX,
  NAInt dimensionY,
  const double* initValues);

void matDeallocViewM33(MATViewM33ASDF* con);

void matSetViewM33Status(MATViewM33ASDF* con, MATStatus status);

void matUpdateViewM33(MATViewM33ASDF* con);

const double* matGetViewM33Values(const MATViewM33ASDF* con);
void matSetViewM33Values(MATViewM33ASDF* con, const double* values);

const NASpace* matGetViewM33Space(const MATViewM33ASDF* con);
