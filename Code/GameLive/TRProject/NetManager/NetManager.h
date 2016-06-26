
#import <Foundation/Foundation.h>
#import "CategoriesModel.h"
#import "AdModel.h"
@interface NetManager : NSObject
//直播房间列表,带分页(直播)
+ (id)getLivePage:(NSInteger)page completionHandler:(void(^)(id model,NSError *error))completionHandler;

//所有游戏分类直播列表,不带分页
+ (id)getCategoriesListComletionHandler:(void(^)(NSArray<Esarray *>*arrModel,NSError *error))completionHandler;

//分类直播的子目录,根据游戏名称进入,带分页
+ (id)getCategoriesGameListGameName:(NSString *)name page:(NSInteger)page comletionHandler:(void(^)(id model,NSError *error))completionHandler;

//首页接口
+ (id)getHomePageComletionHandler:(void(^)(id model,NSError *error))completionHandler;

//广告接口
+ (id)getAdComletionHandler:(void(^)(id model,NSError *error))completionHandler;
@end
