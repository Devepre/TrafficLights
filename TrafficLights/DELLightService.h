#import <Foundation/Foundation.h>
#import "DELLight.h"

@interface DELLightService : NSObject

- (void)addStateToLight:(DELLight *)light withInterval:(NSUInteger)interval andLightStateColor:(LightColor)color;
- (void)setNightStateToLight:(DELLight *)light withInterval:(NSUInteger)interval andLightStateColor:(LightColor)color;
- (void)recieveOneTickForLight:(DELLight *)light;
- (void)changeStatusToNextForLight:(DELLight *)light;
- (void)setNightMode:(BOOL)nightMode forLight:(DELLight *)light;

@end
