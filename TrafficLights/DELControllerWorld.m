#import "DELControllerWorld.h"

@implementation DELControllerWorld

- (void)start {
    [self createDefaultLightsEnum];
    [self doUpdateView];
    
    [self performSelector:@selector(tickTimeWithInterval:) withObject:[NSNumber numberWithInteger:1] afterDelay:0.0];
    [[NSRunLoop currentRunLoop] run];
}

- (void)createDefaultLightsEnum {
    //creating first Light
    DELLightState *state1 = [[DELLightState alloc] initWithColorFromEnum:LightColorRed andInterval:@9];
    DELLightState *state2 = [[DELLightState alloc] initWithColorFromEnum:LightColorRed | LightColorYellow andInterval:@1];
    DELLightState *state3 = [[DELLightState alloc] initWithColorFromEnum:LightColorLGreen andInterval:@8];
    DELLightState *state4 = [[DELLightState alloc] initWithColorFromEnum:LightColorLGreen | LightColorBlinking andInterval:@1];
    DELLightState *state5 = [[DELLightState alloc] initWithColorFromEnum:LightColorYellow andInterval:@1];
    DELLightState *state6 = [[DELLightState alloc] initWithColorFromEnum:LightColorRed andInterval:@5];
    NSArray *arr1 = [[NSArray alloc] initWithObjects:state1, state2, state3, state4, state5, state6, nil];
    DELLight *lightRoad1 = [[DELLight alloc] initWithEnumArray:arr1];
    [lightRoad1 setName:@"#1"];
    [lightRoad1 setWorldDelegate:self];
    
    //creating second Light
    DELLightState *stateOne = [[DELLightState alloc] initWithColorFromEnum:LightColorLGreen andInterval:@8];
    DELLightState *stateTwo = [[DELLightState alloc] initWithColorFromEnum:LightColorLGreen | LightColorBlinking andInterval:@1];
    DELLightState *stateThree = [[DELLightState alloc] initWithColorFromEnum:LightColorYellow andInterval:@1];
    DELLightState *stateFour = [[DELLightState alloc] initWithColorFromEnum:LightColorRed andInterval:@9];
    DELLightState *stateFive = [[DELLightState alloc] initWithColorFromEnum:LightColorRed  | LightColorYellow andInterval:@1];
    DELLightState *stateSix = [[DELLightState alloc] initWithColorFromEnum:LightColorRed andInterval:@4];
    DELLightState *stateSeven = [[DELLightState alloc] initWithColorFromEnum:LightColorRed | LightColorYellow andInterval:@1];
    NSArray *arr = [[NSArray alloc] initWithObjects:stateOne, stateTwo, stateThree, stateFour, stateFive, stateSix, stateSeven, nil];
    DELLight *lightRoadOne = [[DELLight alloc] initWithEnumArray:arr];
    [lightRoadOne setName:@"#2"];
    [lightRoadOne setWorldDelegate:self];
    
    //creating first Pedestrian Light
    DELLightState *stateOneP = [[DELLightState alloc] initWithColorFromEnum:LightColorRed andInterval:@20];
    DELLightState *stateTwoP = [[DELLightState alloc] initWithColorFromEnum:LightColorLGreen andInterval:@4];
    DELLightState *stateThreeP = [[DELLightState alloc] initWithColorFromEnum:LightColorLGreen | LightColorBlinking andInterval:@1];
    NSArray *pedestrianLightsArray = [[NSArray alloc] initWithObjects:stateOneP, stateTwoP, stateThreeP, nil];
    DELLight *lightPedestrian = [[DELLight alloc] initWithEnumArray:pedestrianLightsArray];
    [lightPedestrian setName:@"#3 Pedestrian"];
    [lightPedestrian setWorldDelegate:self];
    
    //adding created Lights to World array
    self.lightsArray = [[NSMutableArray alloc] init];
    [[self lightsArray] addObject:lightRoad1];
    [[self lightsArray] addObject:lightRoadOne];
    [[self lightsArray] addObject:lightPedestrian];
    
}

- (void)tickTimeWithInterval:(NSNumber *)interval {
    DebugLog(@"tick");
    [self performSelector:@selector(tickTimeWithInterval:) withObject:interval afterDelay:[interval doubleValue]];
    
    for (DELLight *currentLight in self.lightsArray) {
        [currentLight recieveOneTick];
    }
    
}

- (void)doUpdateView {
    NSDate *currentDate = [[NSDate alloc] init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"mm'm' ss's' SSSS'ms'"];
    NSString *formattedDateString = [dateFormatter stringFromDate:currentDate];
    
//    printf("<<<\n");
//    NSLog(@"\n%@\n%@", formattedDateString, self);
    printf("%s\n%s\n", [formattedDateString UTF8String], [[self description] UTF8String]);
//    printf(">>>\n\n");
}

- (NSString *)description {
    NSMutableString *arrayDescription = [[NSMutableString alloc] init];
    for (DELLight *currentLight in self.lightsArray) {
        [arrayDescription appendString:[currentLight description]];
        [arrayDescription appendString:@"\n"];
    }
    
    return arrayDescription;
}

@end
