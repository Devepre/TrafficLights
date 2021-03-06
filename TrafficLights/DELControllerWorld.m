#import "DELControllerWorld.h"

@implementation DELControllerWorld {
    double _timeQuant;
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
        [currentLight recieveOneTick];
    }
}

- (void)createDefaultLights {
    //First Light
    DELLight *lightRoadOne = [[DELLight alloc] init];
    [lightRoadOne setName:@"#1"];
    [lightRoadOne setDelegate:self];
    [lightRoadOne addStateWithInterval:9 andLightStateColor:LightColorRed];
    [lightRoadOne addStateWithInterval:1 andLightStateColor:LightColorRed         | LightColorYellow];
    [lightRoadOne addStateWithInterval:8 andLightStateColor:LightColorLGreen];
    [lightRoadOne addStateWithInterval:1 andLightStateColor:LightColorLGreen      | LightColorBlinking];
    [lightRoadOne addStateWithInterval:1 andLightStateColor:LightColorYellow];
    [lightRoadOne addStateWithInterval:5 andLightStateColor:LightColorRed];
    
    //Second Light
    DELLight *lightRoadTwo = [[DELLight alloc] init];
    [lightRoadTwo setName:@"#2"];
    [lightRoadTwo setDelegate:self];
    [lightRoadTwo addStateWithInterval:8 andLightStateColor:LightColorLGreen];
    [lightRoadTwo addStateWithInterval:1 andLightStateColor:LightColorLGreen        | LightColorBlinking];
    [lightRoadTwo addStateWithInterval:1 andLightStateColor:LightColorYellow];
    [lightRoadTwo addStateWithInterval:14 andLightStateColor:LightColorRed];
    [lightRoadTwo addStateWithInterval:1 andLightStateColor:LightColorRed           | LightColorYellow];
    
    //First Pedestrian Light
    DELLight *lightPedestrianOne = [[DELLight alloc] init];
    [lightPedestrianOne setName:@"#3 Pedestrian"];
    [lightPedestrianOne setDelegate:self];
    [lightPedestrianOne addStateWithInterval:20 andLightStateColor:LightColorRed];
    [lightPedestrianOne addStateWithInterval:3 andLightStateColor:LightColorLGreen];
    [lightPedestrianOne addStateWithInterval:1 andLightStateColor:LightColorLGreen  | LightColorBlinking];
    [lightPedestrianOne addStateWithInterval:1 andLightStateColor:LightColorRed];
    
    //adding created Lights to World array
    [[self lightsArray] addObject:lightRoadOne];
    [[self lightsArray] addObject:lightRoadTwo];
    [[self lightsArray] addObject:lightPedestrianOne];
    
    //Night mode
    [lightRoadOne setNightStateWithInterval:3 andLightStateColor:LightColorYellow | LightColorBlinking];
    [lightRoadTwo setNightStateWithInterval:3 andLightStateColor:LightColorYellow | LightColorBlinking];
    [lightPedestrianOne setNightStateWithInterval:3 andLightStateColor:LightColorOff];
    [lightRoadOne setNightMode:YES];
    [lightRoadTwo setNightMode:YES];
    [lightPedestrianOne setNightMode:YES];
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
