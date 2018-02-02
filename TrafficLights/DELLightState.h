#import <Foundation/Foundation.h>

@interface DELLightState : NSObject

@property (strong, nonatomic) NSString *colorName;
@property (strong, nonatomic) NSNumber *interval;

- (instancetype)initWithColorName:(NSString *)colorName andInterval:(NSNumber *)interval;

@end
