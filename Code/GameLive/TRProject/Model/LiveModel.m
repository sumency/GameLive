
#import "LiveModel.h"

@implementation LiveModel
+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"data":[InData class]};
}
@end

@implementation Recommend
+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"data":[ReData class]};
}
@end


@implementation ReData
+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}
@end


@implementation InData
+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"newst":@"new_start_time"};
}

@end
@implementation Ext

@end

