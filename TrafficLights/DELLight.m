#import "DELLight.h"
#import "DELLightProtocol.h"

@implementation DELLight

@synthesize name;
@synthesize nightMode;
@synthesize states;
@synthesize currentStateNumber;
@synthesize currentTicks;
@synthesize worldDelegate;

//designated initializer
- (instancetype)initWithLightsArray:(NSArray<DELLightState *> *)lightsArray {
    self = [super init];
    if (self) {
        [self setStates:lightsArray];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setStates:[self createDefaultLightStates]];
    }
    return self;
}

- (NSArray<DELLightState *> *)createDefaultLightStates {
    DELLightState *stateOne = [[DELLightState alloc] initWithColorName:@"Red" andInterval:@9];
    DELLightState *stateTwo = [[DELLightState alloc] initWithColorName:@"RedYellow" andInterval:@1];
    DELLightState *stateThree = [[DELLightState alloc] initWithColorName:@"Green" andInterval:@8];
    DELLightState *stateFour = [[DELLightState alloc] initWithColorName:@"BlinkingGreen" andInterval:@1];
    DELLightState *stateFive = [[DELLightState alloc] initWithColorName:@"Yellow" andInterval:@1];
    DELLightState *stateSix = [[DELLightState alloc] initWithColorName:@"Red" andInterval:@5];

    NSArray<DELLightState *> *lightStateArray = [[NSArray alloc] initWithObjects:stateOne, stateTwo, stateThree, stateFour, stateFive, stateSix, nil];
    
    return lightStateArray;
}

- (void)changeStatusToNext {
    //TODO implement Night mode
    
    if ([self nightMode]) {
        
    } else {
        
    }
    
    NSUInteger maxStateNumber = [[self states] count];
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
//    NSLog(@"!_change status_!%@\n", self);
}

- (void)recieveOneTick {
    self.currentTicks++;
//    printf("\n%s\n", [self.name UTF8String]);
//    printf("CurrTick: %lu\n", self.currentTicks);
    
    NSNumber *num = [[[self states] objectAtIndex:self.currentStateNumber] interval];
//    printf("TicksToDo: %s\n", [[num stringValue] UTF8String]);
    if ([num integerValue] == self.currentTicks) {
        self.currentTicks = 0;
        [self changeStatusToNext];
    }
}

- (void)switchNightMode {
    //TODO
}

- (NSString *)description {
    NSString *result;
    NSString *currentState = [[[self states] objectAtIndex:[self currentStateNumber]] colorName];
    result = [NSString stringWithFormat:@"%@ -> %@", [self name], currentState];
    //    result = [NSString stringWithFormat:@"<<%@>> ligth | nigth mode: <%hhd>", [self class], [self nightMode]]
    //    result = [NSString stringWithFormat:@"\n<<%@>> light\tnigth mode: <%hhd>\tStates:%@\tCurrent state: %@", [self class], [self nightMode], [self states], currentState];
    return result;
    
}

@end
