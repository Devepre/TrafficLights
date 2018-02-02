#import <Foundation/Foundation.h>
#import "DELLight.h"

@interface DELControllerWorld : NSObject

@property id delegate;
@property (strong, nonatomic) NSMutableArray<DELLight *> *lightsArray;

- (void)start;
- (void)createDefaultLights;
- (void)doUpdateView;

@end
