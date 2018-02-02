#import "DELLight.h"
#import "DELLightProtocol.h"

@implementation DELLight

@synthesize name;
@synthesize nightMode;
@synthesize statesEnum;
@synthesize currentStateNumber;
@synthesize currentTicks;
@synthesize worldDelegate;

//designated initializer
- (instancetype)initWithEnumArray:(NSArray *)array {
    self = [super init];
    if (self) {
        [self setStatesEnum:array];
    }
    return self;
}

- (void)changeStatusToNext {
    //TODO implement Night mode
    
    if ([self nightMode]) {
        
    } else {
        
    }
    
    NSUInteger maxStateNumber = [[self statesEnum] count];
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
    DebugLog(@"calling: %s", __func__);
    self.currentTicks++;
//    printf("\n%s\n", [self.name UTF8String]);
//    printf("CurrTick: %lu\n", self.currentTicks);
//    printf("TicksToDo: %s\n", [[num stringValue] UTF8String]);

    NSNumber *num = [[[self statesEnum] objectAtIndex:self.currentStateNumber] interval];
    if ([num integerValue] == self.currentTicks) {
        self.currentTicks = 0;
        [self changeStatusToNext];
    }
}

- (void)switchNightMode {
    //TODO
}

- (NSString*) lightsColorsToString:(LightColor)notificationTypes {
    NSArray *remoteNotificationTypeStrs = @[@"off", @"blinking", @"red", @"green", @"yellow", @"custom"];
    NSMutableArray *enabledNotificationTypes = [[NSMutableArray alloc] init];
    
    for (NSUInteger i = 0; i < [remoteNotificationTypeStrs count]; i++) {
        NSUInteger enumBitValueToCheck = 1 << i;
        if (notificationTypes & enumBitValueToCheck)
            [enabledNotificationTypes addObject:[remoteNotificationTypeStrs objectAtIndex:i]];
    }
    
    NSString *result = enabledNotificationTypes.count > 0 ?
    [enabledNotificationTypes componentsJoinedByString:@":"] :
    @"no options";
    
    return result;
}

- (NSString *)description {
    NSString *result;
    LightColor color = [[[self statesEnum] objectAtIndex:[self currentStateNumber]] color];
    NSString *currentState = [self lightsColorsToString:color];
    result = [NSString stringWithFormat:@"%@ -> %@", [self name], currentState];
    
    return result;
    
}

@end
