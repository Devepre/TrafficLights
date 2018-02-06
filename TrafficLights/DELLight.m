#import "DELLight.h"

@implementation DELLight

//Designated initializer
- (instancetype)initWithName:(NSString *)name andDelegate:(id<DELLightDelegate>)delegate {
    self = [super init];
    if (self) {
        _delegate = delegate;
        _name = name;
        _lightStates = [[NSMutableArray alloc] init];
    }
    return self;
}

- (instancetype)init {
    return [self initWithName:@"Default Name" andDelegate:nil];
}

- (NSString *)description {
    DELLightState *currentLightState = self.nightMode ? [self nightLightState] : [[self lightStates] objectAtIndex:[self currentStateNumber]];
    NSString *currentState = [currentLightState description];
    NSString *result = [NSString stringWithFormat:@"%@ -> %@", [self name], currentState];
    
    return result;
}

@end
