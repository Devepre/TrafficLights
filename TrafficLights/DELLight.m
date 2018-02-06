#import "DELLight.h"
#import "DELLightProtocol.h"

@implementation DELLight

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.lightStates = [[NSMutableArray alloc] init];
    }
    return self;
}

- (instancetype)initWithLightsArray:(NSMutableArray *)array {
    self = [super init];
    if (self) {
        self = [self init];
        [self setLightStates:array];
    }
    return self;
}

- (void)changeStatusToNext {
    self.currentTicks = 0;
    
    if (self.nightMode) {
        [self setNightMode:NO];
        [self setCurrentStateNumber:0];
    } else {
        NSUInteger maxStateNumber = [[self lightStates] count];
        maxStateNumber--;
        self.currentStateNumber = [self currentStateNumber] == maxStateNumber ? 0 : ++self.currentStateNumber;
    }
    [self.delegate recieveLightChange:self];

    DebugLog(@"!_change status_!%@\n", self);
}

- (void)recieveOneTick {
    DebugLog(@"calling: %s", __func__);
    self.currentTicks++;
    NSNumber *intervalNumber = self.nightMode ? [self.nightLightState interval] : [[[self lightStates] objectAtIndex:self.currentStateNumber] interval];
    if ([intervalNumber integerValue] == self.currentTicks) {
        [self changeStatusToNext];
    }
    
}

- (NSString *)description {
    DELLightState *currentLightState = self.nightMode ? [self nightLightState] : [[self lightStates] objectAtIndex:[self currentStateNumber]];
    NSString *currentState = [currentLightState description];
    NSString *result = [NSString stringWithFormat:@"%@ -> %@", [self name], currentState];
    
    return result;
}

@end
