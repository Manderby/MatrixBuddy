
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



// This is free and unencumbered software released into the public domain.

// Anyone is free to copy, modify, publish, use, compile, sell, or
// distribute this software, either in source code form or as a compiled
// binary, for any purpose, commercial or non-commercial, and by any
// means.

// In jurisdictions that recognize copyright laws, the author or authors
// of this software dedicate any and all copyright interest in the
// software to the public domain. We make this dedication for the benefit
// of the public at large and to the detriment of our heirs and
// successors. We intend this dedication to be an overt act of
// relinquishment in perpetuity of all present and future rights to this
// software under copyright law.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
// IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
// OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
// ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
// OTHER DEALINGS IN THE SOFTWARE.

// For more information, please refer to <http://unlicense.org/>
