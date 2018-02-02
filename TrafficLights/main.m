#import <Foundation/Foundation.h>
#import "DELControllerWorld.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        DELControllerWorld *world = [[DELControllerWorld alloc] init];
        [world start];
    }
    return 0;
}
