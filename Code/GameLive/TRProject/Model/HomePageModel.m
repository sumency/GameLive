
#import "HomePageModel.h"

@implementation HomePageModel
+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"list":[List class],@"mobileBeauty":[ReData class],@"mobileDota2":[ReData class],@"mobileHeartstone":[ReData class],@"mobileIndex":[ReData class],@"mobileLol":[ReData class],@"mobileRecommendation":[ReData class],@"mobileStar":[ReData class],@"mobileTvgame":[ReData class],@"moblieBlizzard":[ReData class],@"moblieDnf":[ReData class],@"moblieMinecraft":[ReData class],@"moblieSport":[ReData class],@"moblieWebgame":[ReData class]};
}
+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"mobileBeauty":@"mobile-beauty",@"mobileDota2":@"mobile-dota2",@"mobileHeartstone":@"mobile-heartstone",@"mobileIndex":@"mobile-index",@"mobileLol":@"mobile-recommendation",@"mobile-recommendation":@"mobileRecommendation",@"mobileStar":@"mobile-star",@"mobileTvgame":@"mobile-tvgame",@"moblieBlizzard":@"moblie-blizzard",@"moblieDnf":@"moblie-dnf",@"moblieMinecraft":@"moblie-minecraft",@"moblieSport":@"moblie-sport",@"moblieWebgame":@"moblie-webgame"};
}
@end

@implementation List : NSObject

@end