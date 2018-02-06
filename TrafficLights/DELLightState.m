#import "DELLightState.h"

@implementation DELLightState

- (instancetype)initWithInterval:(NSNumber *)interval andColor:(LightColor)color {
    self = [super init];
    if (self) {
        _color = color;
        _interval = interval;
    }
    return self;
}

- (NSString *)description {
    NSArray *lightTypeStrings = @[@"off", @"blinking", @"red", @"green", @"yellow", @"custom"];
    NSMutableArray *enabledNotificationTypes = [[NSMutableArray alloc] init];
    
    for (NSUInteger i = 0; i < [lightTypeStrings count]; i++) {
        NSUInteger enumBitValueToCheck = 1 << i;
        if (self.color & enumBitValueToCheck)
            [enabledNotificationTypes addObject:[lightTypeStrings objectAtIndex:i]];
    }
    
    NSString *result = enabledNotificationTypes.count > 0 ?
    [enabledNotificationTypes componentsJoinedByString:@":"] :
    @"no options";
    
    return result;
}

@end
