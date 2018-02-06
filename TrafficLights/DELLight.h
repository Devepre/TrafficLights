#import <Foundation/Foundation.h>
#import "DELLightDelegate.h"
#import "DELLightState.h"

@interface DELLight : NSObject

@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic, readonly) BOOL nightMode;
@property (strong, nonatomic) DELLightState *nightLightState;
@property (strong, nonatomic) NSMutableArray<DELLightState *> *lightStates;
@property (assign, nonatomic) NSUInteger currentStateNumber;
@property (assign, nonatomic) NSUInteger currentTicks;
@property (weak, nonatomic) id<DELLightDelegate> delegate;

- (instancetype)initWithLightsArray:(NSMutableArray<DELLightState *> *)array NS_DESIGNATED_INITIALIZER;
- (instancetype)init;


@end
