
#import "HomePageModel.h"

@implementation HomePageModel
+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"list":[List class],@"mobileBeauty":[ReData class],@"mobileDota2":[ReData class],@"mobileHeartstone":[ReData class],@"mobileIndex":[ReData class],@"mobileLol":[ReData class],@"mobileRecommendation":[ReData class],@"mobileHuWai":[ReData class],@"mobileTvgame":[ReData class],@"moblieBlizzard":[ReData class],@"moblieDnf":[ReData class],@"moblieMinecraft":[ReData class],@"moblieSport":[ReData class],@"moblieWebgame":[ReData class],@"appOwerWatch":[ReData class],@"appClassification":[ReData class]};
}
+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"mobileBeauty":@"app-beauty",@"mobileDota2":@"app-dota2",@"mobileHeartstone":@"app-heartstone",@"mobileIndex":@"app-index",@"mobileLol":@"app-lol",@"mobileRecommendation":@"app-recommendation",@"mobileHuWai":@"app-huwai",@"mobileTvgame":@"app-tvgame",@"moblieBlizzard":@"app-blizzard",@"moblieDnf":@"app-dnf",@"moblieMinecraft":@"app-minecraft",@"moblieSport":@"app-sport",@"moblieWebgame":@"app-webgame",
          @"appOwerWatch":@"app-overwatch",@"appClassification":@"app-classification"
             };
}
@end

@implementation List : NSObject

@end