#import "DELControllerWorld.h"

@implementation DELControllerWorld

@synthesize lightsArray;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.lightsArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)start {
    [self createDefaultLights];
    [self doUpdateView];
    
    [self performSelector:@selector(tickTimeWithInterval:) withObject:[NSNumber numberWithInteger:1] afterDelay:1];
    [[NSRunLoop currentRunLoop] run];
}

- (void)addToLight:(DELLight *)light interval:(NSUInteger)interval andLightStateColor:(LightColor)color  {
    DELLightState *state = [[DELLightState alloc] initWithInterval:[NSNumber numberWithUnsignedInteger:interval] andColor:color];
    [[light lightStates] addObject:state];
}

- (void)createDefaultLights {
    //First Light
    DELLight *lightRoadOne = [[DELLight alloc] init];
    [lightRoadOne setName:@"#1"];
    [lightRoadOne setWorldDelegate:self];
    [self addToLight:lightRoadOne interval:9 andLightStateColor:LightColorRed];
    [self addToLight:lightRoadOne interval:1 andLightStateColor:LightColorRed         | LightColorYellow];
    [self addToLight:lightRoadOne interval:8 andLightStateColor:LightColorLGreen];
    [self addToLight:lightRoadOne interval:1 andLightStateColor:LightColorLGreen      | LightColorBlinking];
    [self addToLight:lightRoadOne interval:1 andLightStateColor:LightColorYellow];
    [self addToLight:lightRoadOne interval:5 andLightStateColor:LightColorRed];
    
    //Second Light
    DELLight *lightRoadTwo = [[DELLight alloc] init];
    [lightRoadTwo setName:@"#1"];
    [lightRoadTwo setWorldDelegate:self];
    [self addToLight:lightRoadTwo interval:8 andLightStateColor:LightColorLGreen];
    [self addToLight:lightRoadTwo interval:1 andLightStateColor:LightColorLGreen        | LightColorBlinking];
    [self addToLight:lightRoadTwo interval:1 andLightStateColor:LightColorYellow];
    [self addToLight:lightRoadTwo interval:9 andLightStateColor:LightColorRed];
    [self addToLight:lightRoadTwo interval:1 andLightStateColor:LightColorRed           | LightColorYellow];
    [self addToLight:lightRoadTwo interval:4 andLightStateColor:LightColorRed];
    [self addToLight:lightRoadTwo interval:1 andLightStateColor:LightColorRed           | LightColorYellow];
    
    //First Pedestrean Light
    DELLight *lightPedestrianOne = [[DELLight alloc] init];
    [lightPedestrianOne setName:@"#3 Pedestrian"];
    [lightPedestrianOne setWorldDelegate:self];
    [self addToLight:lightPedestrianOne interval:20 andLightStateColor:LightColorRed];
    [self addToLight:lightPedestrianOne interval:4 andLightStateColor:LightColorLGreen];
    [self addToLight:lightPedestrianOne interval:1 andLightStateColor:LightColorLGreen  | LightColorBlinking];
    
    //adding created Lights to World array
    [[self lightsArray] addObject:lightRoadOne];
    [[self lightsArray] addObject:lightRoadTwo];
    [[self lightsArray] addObject:lightPedestrianOne];
    
    //Night mode
    [lightRoadOne setNightLightState:[[DELLightState alloc] initWithInterval:@3 andColor:LightColorYellow | LightColorBlinking]];
    [lightRoadTwo setNightLightState:[[DELLightState alloc] initWithInterval:@3 andColor:LightColorYellow | LightColorBlinking]];
    [lightPedestrianOne setNightLightState:[[DELLightState alloc] initWithInterval:@3 andColor:LightColorYellow | LightColorBlinking]];
    [lightRoadOne setNightMode:YES];
    [lightRoadTwo setNightMode:YES];
    [lightPedestrianOne setNightMode:YES];
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
