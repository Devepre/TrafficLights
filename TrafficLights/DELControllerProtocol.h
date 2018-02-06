#import <Foundation/Foundation.h>
#import "DELLightDelegate.h"

@protocol DELControllerProtocol <NSObject>

@property (strong, nonatomic) NSMutableArray<id<DELLightProtocol>> *lightsArray;

- (void)start;
- (void)doUpdateView;

@end
