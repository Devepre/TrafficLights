#import "DELLight.h"
#import "DELLightProtocol.h"

@implementation DELLight

@synthesize name;
@synthesize nightMode;
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
    self.currentTicks = 0;
    
    //TODO implement Night mode
    if ([self nightMode]) {
        
    } else {
        
    }
    
    NSUInteger maxStateNumber = [[self lightStates] count];
    maxStateNumber--;
    if ([self currentStateNumber] <= maxStateNumber) {
        if ([self currentStateNumber] == maxStateNumber) {
            [self setCurrentStateNumber:0];
        } else {
            [self setCurrentStateNumber:[self currentStateNumber] + 1];
        }
        
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
        
    } else {
        [self setCurrentStateNumber:0];
    }
    DebugLog(@"!_change status_!%@\n", self);
}

- (void)recieveOneTick {
    DebugLog(@"calling: %s", __func__);
    self.currentTicks++;

    NSNumber *intervalNumber = [[[self lightStates] objectAtIndex:self.currentStateNumber] interval];
    if ([intervalNumber integerValue] == self.currentTicks) {
        [self changeStatusToNext];
    }
}

- (void)switchNightMode {
    //TODO
}

- (NSString *)description {
    NSString *result = nil;
    NSString *currentState = [[[self lightStates] objectAtIndex:[self currentStateNumber]] description];
    result = [NSString stringWithFormat:@"%@ -> %@", [self name], currentState];
    
    return result;
}

@end
