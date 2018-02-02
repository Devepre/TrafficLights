#import "DELLightState.h"

@implementation DELLightState

- (instancetype)initWithColorName:(NSString *)colorName andInterval:(NSNumber *)interval {
    self = [super init];
    if (self) {
        _colorName = colorName;
        _interval = interval;
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ %@", [self colorName], [self interval]];
}

@end
