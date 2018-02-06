#import "DELLight.h"

@implementation DELLight

//Designated initializer
- (instancetype)initWithLightsArray:(NSMutableArray *)array  {
    self = [super init];
    if (self) {
        _lightStates = array;
    }
    return self;
}

- (instancetype)init {
    return [self initWithLightsArray:[[NSMutableArray alloc] init]];
}

- (NSString *)description {
    DELLightState *currentLightState = self.nightMode ? [self nightLightState] : [[self lightStates] objectAtIndex:[self currentStateNumber]];
    NSString *currentState = [currentLightState description];
    NSString *result = [NSString stringWithFormat:@"%@ -> %@", [self name], currentState];
    
    return result;
}

@end
