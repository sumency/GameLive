
#import "NetManager.h"

@implementation NetManager
+(id)getLivePage:(NSInteger)page completionHandler:(void (^)(id, NSError *))completionHandler{
    NSString *path = nil;
    if (page == 0) {
        path = kLivePathFirst;
    }else{
        path = [NSString stringWithFormat:kLivePath,page];
    }
    return [self GET:path parameters:nil progress:nil completionHandler:^(id jsonObject, NSError *error) {
        if (error) {
            DDLogError(@"%@",error);
        }else{
            !completionHandler ?: completionHandler([LiveModel parseJSON:jsonObject],error);
        }
    }];
}

+(id)getCategoriesListComletionHandler:(void (^)(NSArray<Esarray *> *arrModel, NSError *))completionHandler{
return [self GET:kCategoriesPath parameters:nil progress:nil completionHandler:^(id jsonObject, NSError *error) {
    !completionHandler ?: completionHandler([Esarray parseJSON:jsonObject],error);
}];
}

+ (id)getCategoriesGameListGameName:(NSString *)name page:(NSInteger)page comletionHandler:(void(^)(id model,NSError *error))completionHandler{
    NSString *path = nil;
    if (page == 0) {
        path = [NSString stringWithFormat:kCategoriesGameListFirst,name];
    }else{
        path = [NSString stringWithFormat:kCategoriesGameList,name,page];
    }
    return [self GET:path parameters:nil progress:nil completionHandler:^(id jsonObject, NSError *error) {
        if (error) {
            DDLogError(@"%@",error);
        }else{
            !completionHandler ?: completionHandler([LiveModel parseJSON:jsonObject],error);
        }
    }];
}

+ (id)getHomePageComletionHandler:(void (^)(id, NSError *))completionHandler{
return [self GET:kHomePagePath parameters:nil progress:nil completionHandler:^(id jsonObject, NSError *error) {
    !completionHandler ?: completionHandler([HomePageModel parseJSON:jsonObject],error);
}];
}


+(id)getAdComletionHandler:(void (^)(id, NSError *))completionHandler{
return [self GET:kAdPath parameters:nil progress:nil completionHandler:^(id jsonObject, NSError *error) {
    !completionHandler ?: completionHandler([AdModel parseJSON:jsonObject],error);
}];
}
@end
