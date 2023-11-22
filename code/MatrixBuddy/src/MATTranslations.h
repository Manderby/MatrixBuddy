
#ifndef MAT_TRANSLATIONS_INCLUDED
#define MAT_TRANSLATIONS_INCLUDED



#include "NATranslator.h"



typedef enum{
  MATDummyTranslation,

  MATAbout,
  MATDone,
  MATVersionBuild,
  MATOnlineHelp,
  MATApplicationDescription,
  MATApplicationHelpURL,

  MATMenuItemShowHelp,
  MATMenuItemShowIdentifiers,
  MATMenuItemRowFirstTabOrder,
  MATMenuItemColumnFirstTabOrder,
  MATMenuItemShowCopyPaste,
  MATMenuItemCodeCRowFirstItem1D,
  MATMenuItemCodeCRowFirstItem2D,
  MATMenuItemCodeCColumnFirstItem1D,
  MATMenuItemCodeCColumnFirstItem2D,
  MATMenuItemCodeMathematica,
  MATMenuItemCodeMatlab,
  MATMenuItemCodeMaple,
  MATMenuItemValueAccuracyNatural,
  MATMenuItemValueAccuracyFloat,
  MATMenuItemAbout,
  MATMenuItemHelp,

  MATButtonVMulS,
  MATButtonVDivS,
  MATButtonVMulCompV,
  MATButtonVDivCompV,
  MATButtonVNeg,
  MATButtonVAddV,
  MATButtonVSubV,
  MATButtonVDotV,
  MATButtonVCrossV,
  MATButtonVLength,
  MATButtonVNormalize,
  MATButtonVOrtho,
  MATButtonVMirror,
  MATButtonMMulS,
  MATButtonMDivS,
  MATButtonMMulCompV,
  MATButtonMDivCompV,
  MATButtonMMulCompM,
  MATButtonMDivCompM,
  MATButtonMNeg,
  MATButtonMAddM,
  MATButtonMSubM,
  MATButtonMMulV,
  MATButtonMMulM,
  MATButtonMDiagS,
  MATButtonMDiagV,
  MATButtonMTranspose,
  MATButtonMInvert,

  MATHelpVMulS,
  MATHelpVDivS,
  MATHelpVMulCompV,
  MATHelpVDivCompV,
  MATHelpVNeg,
  MATHelpVAddV,
  MATHelpVSubV,
  MATHelpVDotV,
  MATHelpVCrossV,
  MATHelpVLength,
  MATHelpVNormalize,
  MATHelpVOrtho,
  MATHelpVMirror,
  MATHelpMMulS,
  MATHelpMDivS,
  MATHelpMMulCompV,
  MATHelpMDivCompV,
  MATHelpMMulCompM,
  MATHelpMDivCompM,
  MATHelpMNeg,
  MATHelpMAddM,
  MATHelpMSubM,
  MATHelpMMulV,
  MATHelpMMulM,
  MATHelpMDiagS,
  MATHelpMDiagV,
  MATHelpMTranspose,
  MATHelpMInvert,

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

} MATTranslation;



void initTranslations(void);

const NAUTF8Char* matTranslate(NAInt id);



#endif // MAT_TRANSLATIONS_INCLUDED
