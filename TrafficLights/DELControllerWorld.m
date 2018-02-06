#import "DELControllerWorld.h"

@implementation DELControllerWorld {
    double _timeQuant;
    DELLightService *_lightService;
}

//Designated initializer
- (instancetype)initWithTimeQuant:(double)timeQuant {
    self = [super init];
    if (self) {
        self.lightsArray = [[NSMutableArray alloc] init];
        _timeQuant = timeQuant;
    }
    return self;
}

- (instancetype)init {
    return [self initWithTimeQuant:1];
}

- (void)start {
    _lightService = [[DELLightService alloc] init];
    [self createDefaultLights];
    [self doUpdateView];
    
    //Running the timer
    [self performSelector:@selector(tickTimeWithInterval:) withObject:[NSNumber numberWithDouble:_timeQuant] afterDelay:_timeQuant];
    [[NSRunLoop currentRunLoop] run];
}

- (void)tickTimeWithInterval:(NSNumber *)interval {
    DebugLog(@"tick");
    [self performSelector:@selector(tickTimeWithInterval:) withObject:interval afterDelay:[interval doubleValue]];
    
    //Sending message Tick to all the objects
    for (DELLight *currentLight in self.lightsArray) {
        [_lightService recieveOneTickForLight:currentLight];
    }
}

- (void)createDefaultLights {
    //First Light
    DELLight *lightRoadOne = [_lightService createLightWithName:@"#1" andDelegate:self];
    [_lightService addStateToLight:lightRoadOne withInterval:9 andLightStateColor:LightColorRed];
    [_lightService addStateToLight:lightRoadOne withInterval:1 andLightStateColor:LightColorRed         | LightColorYellow];
    [_lightService addStateToLight:lightRoadOne withInterval:8 andLightStateColor:LightColorLGreen];
    [_lightService addStateToLight:lightRoadOne withInterval:1 andLightStateColor:LightColorLGreen      | LightColorBlinking];
    [_lightService addStateToLight:lightRoadOne withInterval:1 andLightStateColor:LightColorYellow];
    [_lightService addStateToLight:lightRoadOne withInterval:5 andLightStateColor:LightColorRed];
    
    //Second Light
    DELLight *lightRoadTwo = [_lightService createLightWithName:@"#2" andDelegate:self];
    [_lightService addStateToLight:lightRoadTwo withInterval:8 andLightStateColor:LightColorLGreen];
    [_lightService addStateToLight:lightRoadTwo withInterval:1 andLightStateColor:LightColorLGreen        | LightColorBlinking];
    [_lightService addStateToLight:lightRoadTwo withInterval:1 andLightStateColor:LightColorYellow];
    [_lightService addStateToLight:lightRoadTwo withInterval:9 andLightStateColor:LightColorRed];
    [_lightService addStateToLight:lightRoadTwo withInterval:1 andLightStateColor:LightColorRed           | LightColorYellow];
    [_lightService addStateToLight:lightRoadTwo withInterval:4 andLightStateColor:LightColorRed];
    [_lightService addStateToLight:lightRoadTwo withInterval:1 andLightStateColor:LightColorRed           | LightColorYellow];
    
    //First Pedestrian Light
    DELLight *lightPedestrianOne = [_lightService createLightWithName:@"#3 Pedestrian" andDelegate:self];
    [_lightService addStateToLight:lightPedestrianOne withInterval:20 andLightStateColor:LightColorRed];
    [_lightService addStateToLight:lightPedestrianOne withInterval:4 andLightStateColor:LightColorLGreen];
    [_lightService addStateToLight:lightPedestrianOne withInterval:1 andLightStateColor:LightColorLGreen  | LightColorBlinking];
    
    //adding created Lights to World array
    [[self lightsArray] addObject:lightRoadOne];
    [[self lightsArray] addObject:lightRoadTwo];
    [[self lightsArray] addObject:lightPedestrianOne];
    
    //Night mode
    [_lightService setNightStateToLight:lightRoadOne withInterval:3 andLightStateColor:LightColorYellow | LightColorBlinking];
    [_lightService setNightStateToLight:lightRoadTwo withInterval:3 andLightStateColor:LightColorYellow | LightColorBlinking];
    [_lightService setNightStateToLight:lightPedestrianOne withInterval:3 andLightStateColor:LightColorOff];
    
    [_lightService setNightMode:YES forLight:lightRoadOne];
    [_lightService setNightMode:YES forLight:lightRoadTwo];
    [_lightService setNightMode:YES forLight:lightPedestrianOne];
}

- (void)recieveLightChange:(DELLight *)lightChanged {
    DebugLog(@"changed object is: %@", lightChanged);
    [self doUpdateView];
}

- (void)doUpdateView {
    NSDate *currentDate = [[NSDate alloc] init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"mm'm' ss's' SSSS'ms'"];
    NSString *formattedDateString = [dateFormatter stringFromDate:currentDate];
    printf("%s\n%s\n", [formattedDateString UTF8String], [[self description] UTF8String]);
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
