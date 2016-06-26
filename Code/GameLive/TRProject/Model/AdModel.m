
#import "AdModel.h"

@implementation AdModel
+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"pcBanner":[Ad class],@"pcBanner2":[Ad class],@"playerGuanggao":[Ad class],@"list":[List class]};
}
+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"appAd":@"app-ad",@"pcBanner":@"pc-banner",@"pcBanner2":@"pc-banner2",@"playerGuanggao":@"player-guanggao"};
}
@end

@implementation Ad
+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}
@end
