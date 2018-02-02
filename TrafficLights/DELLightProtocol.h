#import <Foundation/Foundation.h>
#import "DELLightState.h"

@protocol DELLightProtocol <NSObject>

@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) BOOL nightMode;
@property (strong, nonatomic) NSArray<DELLightState *> *states;
@property (assign, nonatomic) NSUInteger currentStateNumber;
@property (assign, nonatomic) NSUInteger currentTicks;
@property (weak, nonatomic) id worldDelegate;

- (instancetype)initWithLightsArray:(NSArray<DELLightState *> *)lightsArray;
- (void)changeStatusToNext;
- (void)recieveOneTick;
- (void)switchNightMode;

@end
