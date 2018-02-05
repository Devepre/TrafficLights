#import <Foundation/Foundation.h>

@protocol DELControllerProtocol <NSObject>

- (void)start;
- (void)doUpdateView;

@property (strong, nonatomic) NSMutableArray<id<DELLightProtocol>> *lightsArray;

@end
