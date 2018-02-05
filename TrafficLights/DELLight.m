#import "DELLight.h"
#import "DELLightProtocol.h"

@implementation DELLight

@synthesize name;
@synthesize nightMode;
@synthesize nightLightState;
@synthesize lightStates;
@synthesize currentStateNumber;
@synthesize currentTicks;
@synthesize worldDelegate;

//designated initializer
- (instancetype)initWithLightsArray:(NSArray *)array {
    self = [super init];
    if (self) {
        [self setLightStates:array];
    }
    return self;
}

- (void)changeStatusToNext {
    void (^invokeWorldDoUpdateView)(void) = ^{
        //        regular way
        //        SEL worldSelector = @selector(doUpdateView);
        //        [[self worldDelegate] performSelector:worldSelector withObject:nil];
        
        // pragma block used to ingnore compiler warning about possibly unknown selector
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        SEL worldSelector = @selector(doUpdateView);
        if ([[self worldDelegate] respondsToSelector:worldSelector]) {
            ((void (*)(id, SEL))[[self worldDelegate] methodForSelector:worldSelector])([self worldDelegate], worldSelector);
        }
#pragma clang diagnostic pop
    };
    
    self.currentTicks = 0;
    
    if (self.nightMode) {
        [self setNightMode:NO];
        [self setCurrentStateNumber:0];
        invokeWorldDoUpdateView();
    } else {
        NSUInteger maxStateNumber = [[self lightStates] count];
        maxStateNumber--;
        if ([self currentStateNumber] <= maxStateNumber) {
            self.currentStateNumber = [self currentStateNumber] == maxStateNumber ? 0 : ++self.currentStateNumber;
            invokeWorldDoUpdateView();
        } else {
            [self setCurrentStateNumber:0];
        }
    }
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
