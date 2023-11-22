
#include "NAApp/NAApp.h"
#include "MATTypes.h"

#define MAT_TEXTFIELD_WIDTH 70
#define MAT_TEXTFIELD_HEIGHT 22
#define MAT_TEXTFIELD_SPACE_H 5
#define MAT_TEXTFIELD_SPACE_V 5
#define MAT_TEXTFIELD_SPACE_V 5
#define MAT_VIEW_MARGIN_V 10
#define MAT_MATRIX_MARGIN_RIGHT 7
#define MAT_MATRIX_MARGIN_TOP 9
#define MAT_MATRIX_MARGIN_LEFT 7
#define MAT_MATRIX_MARGIN_BOTTOM 4
#define MAT_MATRIX_DISTANCE_VTOP 4
#define MAT_MATRIX_DISTANCE_VBOTTOM 10
#define MAT_MATRIX_LABEL_HEIGHT 29
#define MAT_ERROR_LABEL_SHIFT_Y 8
#define MAT_COPYPASTE_BUTTON_SIZE 19
#define MAT_COPYPASTE_BUTTON_DISTANCE 20
#define MAT_SIGN_WIDTH 70
#define MAT_SIGN_LABEL_SHIFT_Y -10
#define MAT_LABEL_SHIFT_Y -3

#define MAT_EQUAL_SIGN "="
#define MAT_ADD_SIGN "+"
#define MAT_SUB_SIGN "\u2013" // en Dash
#define MAT_MUL_SIGN "\u00d7"
#define MAT_DIV_SIGN "\u00f7"
#define MAT_MUL_CIRCLE_SIGN "\u2299"
#define MAT_DIV_CIRCLE_SIGN "\u2298"
#define MAT_ARROW_SIGN "\u27f6"
#define MAT_DOUBLE_ARROW_SIGN "\u27f7"
#define MAT_SUPERSCRIPT_T "\u1d40"
#define MAT_SUPERSCRIPT_MINUS_ONE "\u207b\u00b9"
#define MAT_MIRROR_SIGN "\u21a5"
#define MAT_ORTHO_SIGN "\u22a5"
#define MAT_DOT_SIGN "\u00b7"

typedef struct MATAboutController MATAboutController;
typedef struct MATBaseController MATBaseController;
typedef struct MATView MATView;

typedef void(*MATValueChangedHandler)(MATBaseController* controller, MATView* view);
typedef void(*MATUpdateHandler)(MATBaseController* controller);
typedef void (*MATUpdateTabOrderHandler)(MATBaseController* controller);

NAUIImage* matGetCopyImage(void);
NAUIImage* matGetPasteImage(void);

void matPutStringToPasteboard(const NAString* string);
NAString* matNewStringFromPasteboard(void);
void matSetTextFieldCellProperties(NATextField* textField);

const NAUTF8Char* matGetUTF8StringWithStatus(MATStatus status);
MATColor matGetColorWithStatus(MATStatus status);
void matFillBabyColor(NABabyColor* babyColor, MATColor color);

