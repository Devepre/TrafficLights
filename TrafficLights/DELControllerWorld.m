#import "DELControllerWorld.h"

@implementation DELControllerWorld

- (void)start {
    [self createDefaultLights];
    [self doUpdateView];
    
    [self performSelector:@selector(tickTimeWithInterval:) withObject:[NSNumber numberWithInteger:1] afterDelay:0.0];
    [[NSRunLoop currentRunLoop] run];
}

- (void)createDefaultLights {
    //creting first Light
    DELLight *lightOne = [[DELLight alloc] init];
    [lightOne setName:@"#1"];
    [lightOne setWorldDelegate:self];
//    DELLight *lightTwo = [[DELLight alloc] init];
//    [lightTwo setName:@"#2"];
//    [lightTwo setCurrentStateNumber:2];
//    [lightTwo setWorldDelegate:self];
    
    //creating second Light
    DELLightState *state1 = [[DELLightState alloc] initWithColorName:@"Green" andInterval:@8];
    DELLightState *state2 = [[DELLightState alloc] initWithColorName:@"BlinkingGreen" andInterval:@1];
    DELLightState *state3 = [[DELLightState alloc] initWithColorName:@"Yellow" andInterval:@1];
    DELLightState *state4 = [[DELLightState alloc] initWithColorName:@"Red" andInterval:@9];
    DELLightState *state5 = [[DELLightState alloc] initWithColorName:@"RedYellow" andInterval:@1];
    DELLightState *state6 = [[DELLightState alloc] initWithColorName:@"Red" andInterval:@4];
    DELLightState *state7 = [[DELLightState alloc] initWithColorName:@"RedYellow" andInterval:@1];
    NSArray *lightTwoLightsArray = [[NSArray alloc] initWithObjects:state1, state2, state3, state4, state5, state6, state7, nil];
    DELLight *lightTwo = [[DELLight alloc] initWithLightsArray:lightTwoLightsArray];
    [lightTwo setName:@"#2"];
    [lightTwo setWorldDelegate:self];
    
    //creating first Pedestrian Light
    DELLightState *stateOne = [[DELLightState alloc] initWithColorName:@"Red" andInterval:@20];
    DELLightState *stateTwo = [[DELLightState alloc] initWithColorName:@"Green" andInterval:@4];
    DELLightState *stateThree = [[DELLightState alloc] initWithColorName:@"BlinkingGreen" andInterval:@1];
    NSArray *pedestrianLightsArray = [[NSArray alloc] initWithObjects:stateOne, stateTwo, stateThree, nil];
    DELLight *lightPedestrian = [[DELLight alloc] initWithLightsArray:pedestrianLightsArray];
    [lightPedestrian setName:@"#3 Pedestrian"];
    [lightPedestrian setWorldDelegate:self];
    
    //adding created Lights to World array
    self.lightsArray = [[NSMutableArray alloc] init];
    [[self lightsArray] addObject:lightOne];
    [[self lightsArray] addObject:lightTwo];
    [[self lightsArray] addObject:lightPedestrian];
    
}

- (void)tickTimeWithInterval:(NSNumber *)interval {
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
