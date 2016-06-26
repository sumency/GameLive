
#import "CategoriesViewModel.h"
#import "NetManager.h"
@implementation CategoriesViewModel

-(NSString *)gameNameForIndex:(NSInteger)index{
    return [self modelForIndex:index].slug;
}

-(NSInteger)numForIndex{
    return self.dataList.count;
}

- (NSString *)titleForIndex:(NSInteger)index{
    return [self modelForIndex:index].name;
}
- (NSURL *)iconURLForIndex:(NSInteger)index{
    return [self modelForIndex:index].image.yx_URL;
}

- (Esarray *)modelForIndex:(NSInteger)index{
    return self.dataList[index];
}
-(void)getDataWithRequestMode:(VMRequestMode)requestMode completionHandler:(void (^)(NSError *))completionHandler{
    _dataTask = [NetManager getCategoriesListComletionHandler:^(NSArray<Esarray *> *arrModel, NSError *error) {
        if (error) {
            DDLogError(@"%@",error);
        }else{
            if (requestMode == VMRequestModeRefresh) {
                self.dataList = nil;
            }
            self.dataList = arrModel;
        }
        !completionHandler?:completionHandler(error);
    }];
}
- (NSArray<Esarray *> *)dataList {
    if(_dataList == nil) {
        _dataList = [[NSArray<Esarray *> alloc] init];
    }
    return _dataList;
}

@end
