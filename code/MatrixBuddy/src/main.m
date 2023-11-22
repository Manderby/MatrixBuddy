
#import "MATNSApplication.h"
#include "MATApplication.h"



int main(int argc, char *argv[]){
  NA_UNUSED(argc);
  NA_UNUSED(argv);
  naStartRuntime();
  [MATNSApplication sharedApplication];
  naStartApplication(preStartup, postStartup, stopApplication, NA_NULL);
  return 0;
}

