
#include "NAApp/NAApp.h"
#include "MATTypes.h"

#define MAT_TEXTFIELD_WIDTH 70.
#define MAT_TEXTFIELD_HEIGHT 22.
#define MAT_TEXTFIELD_SPACE_H 5.
#define MAT_TEXTFIELD_SPACE_V 5.
#define MAT_TEXTFIELD_SPACE_V 5.
#define MAT_VIEW_MARGIN_V 10.
#define MAT_MATRIX_MARGIN_RIGHT 7.
#define MAT_MATRIX_MARGIN_TOP 9.
#define MAT_MATRIX_MARGIN_LEFT 7.
#define MAT_MATRIX_MARGIN_BOTTOM 4.
#define MAT_MATRIX_DISTANCE_VTOP 4.
#define MAT_MATRIX_DISTANCE_VBOTTOM 10.
#define MAT_COPYPASTE_BUTTON_SIZE 19.
#define MAT_COPYPASTE_BUTTON_DISTANCE 20.
#define MAT_SIGN_WIDTH 70.
#define MAT_LABEL_SHIFT_Y -3.

#if NA_OS == NA_OS_MAC_OS_X
  #define MAT_MATRIX_LABEL_HEIGHT 29.
  #define MAT_ERROR_LABEL_SHIFT_Y 4.
  #define MAT_SIGN_LABEL_SHIFT_Y -10.
#else
  #define MAT_MATRIX_LABEL_HEIGHT 25.
  #define MAT_ERROR_LABEL_SHIFT_Y 0.
  #define MAT_SIGN_LABEL_SHIFT_Y 0.
#endif

#define MAT_EQUAL_SIGN u8"="
#define MAT_ADD_SIGN u8"+"
#define MAT_SUB_SIGN u8"\u2013" // en Dash
#define MAT_MUL_SIGN u8"\u00d7"
#define MAT_DIV_SIGN u8"\u00f7"
#define MAT_MUL_CIRCLE_SIGN u8"\u2299"
#define MAT_DIV_CIRCLE_SIGN u8"\u2298"
#define MAT_ARROW_SIGN u8"\u27f6"
#define MAT_DOUBLE_ARROW_SIGN u8"\u27f7"
#define MAT_SUPERSCRIPT_T u8"\u1d40"
#define MAT_SUPERSCRIPT_MINUS_ONE u8"\u207b\u00b9"
#define MAT_MIRROR_SIGN u8"\u21a5"
#define MAT_ORTHO_SIGN u8"\u22a5"
#define MAT_DOT_SIGN u8"\u00b7"

typedef struct MATAboutController MATAboutController;
typedef struct MATBaseController MATBaseController;
typedef struct MATView MATView;

typedef void(*MATValueChangedHandler)(MATBaseController* controller, MATView* view);
typedef void(*MATUpdateHandler)(MATBaseController* controller);
typedef void (*MATUpdateTabOrderHandler)(MATBaseController* controller);

NAImageSet* matGetCopyImageSet(void);
NAImageSet* matGetPasteImageSet(void);

void matSetTextFieldCellProperties(NATextField* textField);

const NAUTF8Char* matGetUTF8StringWithStatus(MATStatus status);
MATColor matGetColorWithStatus(MATStatus status);
void matFillColor(NAColor* naColor, MATColor matColor);



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
