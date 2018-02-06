#import <Foundation/Foundation.h>
#import "DELLight.h"
#import "DELControllerProtocol.h"

@interface DELControllerWorld : NSObject<DELControllerProtocol, DELLightDelegate>

@property (strong, nonatomic) NSMutableArray<id<DELLightProtocol>> *lightsArray;

@end
