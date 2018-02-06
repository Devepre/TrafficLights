#import <Foundation/Foundation.h>
#import "DELLightProtocol.h"
#import "DELLightDelegate.h"
#import "DELLightState.h"

@interface DELLight : NSObject<DELLightProtocol>

@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) BOOL nightMode;
@property (strong, nonatomic) DELLightState *nightLightState;
@property (strong, nonatomic) NSMutableArray<DELLightState *> *lightStates;
@property (assign, nonatomic) NSUInteger currentStateNumber;
@property (assign, nonatomic) NSUInteger currentTicks;
@property (weak, nonatomic) id <DELLightDelegate> delegate;

- (instancetype)initWithLightsArray:(NSMutableArray *)array;
- (void)addStateWithInterval:(NSUInteger)interval andLightStateColor:(LightColor)color;
- (void)setNightStateWithInterval:(NSUInteger)interval andLightStateColor:(LightColor)color;

@end
