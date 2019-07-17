
#include "NATranslator.h"
#include "MATApplication.h"

#define MAT_TRANSLATE(id) naTranslate([(MATApplication*)NSApp getTranslatorGroup], id)

enum{
  MatrixBuddyApplicationDescription,
  MatrixBuddyNewVersionDescription,

  MATHelpVMulS,
  MATHelpVDivS,
  MATHelpVMulCompV,
  MATHelpVDivCompV,
  MATHelpNegV,
  MATHelpVAddV,
  MATHelpVSubV,
  MATHelpVDotV,
  MATHelpVCrossV,
  MATHelpLengthV,
  MATHelpNormalizeV,
  MATHelpOrthogonalizeV,
  MATHelpMirrorV,
  MATHelpMMulS,
  MATHelpMDivS,
  MATHelpMMulCompV,
  MATHelpMDivCompV,
  MATHelpMMulCompM,
  MATHelpMDivCompM,
  MATHelpNegM,
  MATHelpMAddM,
  MATHelpMSubM,
  MATHelpMMulV,
  MATHelpMMulM,
  MATHelpDiagS,
  MATHelpDiagV,
  MATHelpTransposeM,
  MATHelpInvertM,

  MATErrorMatrixDeterminantZero,
  MATErrorMatrixDeterminantAlmostZero,
  MATErrorVectorComponentZero,
  MATErrorVectorComponentAlmostZero,
  MATErrorMatrixComponentZero,
  MATErrorMatrixComponentAlmostZero,
  MATErrorScalarZero,
  MATErrorScalarAlmostZero,
  MATErrorVectorLengthZero,
  MATErrorVectorLengthAlmostZero,
  MATErrorVectorsCollinear,
  MATErrorVectorsAlmostCollinear,
  MATErrorVectorLengthUnequalOne,

};
