#import "DELLightService.h"

@implementation DELLightService

- (void)addStateToLight:(DELLight *)light withInterval:(NSUInteger)interval andLightStateColor:(LightColor)color  {
    DELLightState *state = [[DELLightState alloc] initWithInterval:[NSNumber numberWithUnsignedInteger:interval] andColor:color];
    [[light lightStates] addObject:state];
}

- (void)setNightStateToLight:(DELLight *)light withInterval:(NSUInteger)interval andLightStateColor:(LightColor)color {
    [light setNightLightState:[[DELLightState alloc] initWithInterval:[NSNumber numberWithUnsignedInteger:interval] andColor:color]];
}

- (void)recieveOneTickForLight:(DELLight *)light {
    DebugLog(@"calling: %s", __func__);
    light.currentTicks++;
    NSNumber *intervalNumber = [[light valueForKey:@"nightMode"] boolValue] ? [light.nightLightState interval] : [[[light lightStates] objectAtIndex:light.currentStateNumber] interval];
    if ([intervalNumber integerValue] == light.currentTicks) {
        [self changeStatusToNextForLight:light];
    }
}

- (void)changeStatusToNextForLight:(DELLight *)light {
    light.currentTicks = 0;
    if ([[light valueForKey:@"nightMode"] boolValue]) {
        [light setValue:@NO forKey:@"nightMode"];
        [light setCurrentStateNumber:0];
    } else {
        NSUInteger maxStateNumber = [[light lightStates] count];
        light.currentStateNumber = [light currentStateNumber] == --maxStateNumber ? 0 : ++light.currentStateNumber;
    }
    [light.delegate recieveLightChange:light];
    DebugLog(@"!_change status_! to: %@\n", self);
}

- (void)setNightMode:(BOOL)nightMode forLight:(DELLight *)light {
    [light setValue:@YES forKey:@"nightMode"];
//    [light setNightMode:YES];
}

@end
