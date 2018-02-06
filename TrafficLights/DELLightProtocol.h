#import <Foundation/Foundation.h>
#import "DELLightState.h"

@protocol DELLightProtocol <NSObject>

- (void)recieveOneTick;
- (void)changeStatusToNext;

@end
