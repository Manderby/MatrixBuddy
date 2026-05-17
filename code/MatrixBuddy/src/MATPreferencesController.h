
#ifndef MAT_PREFERENCES_CONTROLLER_INCLUDED
#define MAT_PREFERENCES_CONTROLLER_INCLUDED



typedef struct MATPreferencesController MATPreferencesController;

MATPreferencesController* matAllocPreferencesController(void);
void matDeallocPreferencesController(MATPreferencesController* con);

void matShowPreferencesController(MATPreferencesController* con);
void matUpdatePreferencesController(MATPreferencesController* con);



#endif // MAT_PREFERENCES_CONTROLLER_INCLUDED
