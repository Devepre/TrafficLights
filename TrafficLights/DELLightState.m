#import "DELLightState.h"

@implementation DELLightState

- (instancetype)initWithColorFromEnum:(LightColor)color andInterval:(NSNumber *)interval {
    self = [super init];
    if (self) {
        _color = color;
        _interval = interval;
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ %@", [self colorName], [self interval]];
}

@end
