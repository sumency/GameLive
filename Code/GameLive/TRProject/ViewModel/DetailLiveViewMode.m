//
//  DetailLiveViewMode.m
//  TRProject
//
//  Created by lixi on 16/6/26.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "DetailLiveViewMode.h"
#import "NetManager.h"
@implementation DetailLiveViewMode
-initWithGameName:(NSString *)gameName{
    if (self = [super init]) {
        _gameName = gameName;
    }
    return self;
}

- (NSURL *)iconURLForRow:(NSInteger)row{
    return [self modelForRow:row].avatar.yx_URL;
}
- (NSURL *)coverURLForRow:(NSInteger)row{
    return [self modelForRow:row].thumb.yx_URL;
}
- (NSString *)viewForRow:(NSInteger)row{
    NSInteger num = ([self modelForRow:row].view).integerValue;
    if (num >= 10000) {
        NSString *tmp = [NSString stringWithFormat:@"%.1f万",num/10000.0];
        return tmp;
    }else{
        return [NSString stringWithFormat:@"%ld",num];
    }
}
- (NSString *)titleForRow:(NSInteger)row{
    return [self modelForRow:row].title;
}
- (NSString *)nickForRow:(NSInteger)row{
    return [self modelForRow:row].nick;
}
- (NSString *)uidForRow:(NSInteger)row{
    return [self modelForRow:row].uid;
}

-(NSInteger)numForRow{
    return self.dataList.count;
}

-(InData *)modelForRow:(NSInteger)row{
    return self.dataList[row];
}

-(void)getDataWithRequestMode:(VMRequestMode)requestMode completionHandler:(void (^)(NSError *))completionHandler{
    switch (requestMode) {
        case VMRequestModeRefresh: {
            _page = 0;
            break;
        }
        case VMRequestModeMore: {
            _page += 1;
            break;
        }
    }
    if (self.gameName == nil) {
        _dataTask = [NetManager getLivePage:_page completionHandler:^(LiveModel *model, NSError *error) {
            if (error) {
                DDLogError(@"%@",error);
            }else{
                _hasMore = model.data.count == 90;
                if (requestMode == VMRequestModeRefresh) {
                    [self.dataList removeAllObjects];
                }
                [self.dataList addObjectsFromArray:model.data];
            }
            !completionHandler ?: completionHandler(error);
        }];
    }else{
        _dataTask = [NetManager getCategoriesGameListGameName:self.gameName page:_page comletionHandler:^(LiveModel *model, NSError *error) {
            if (error) {
                DDLogError(@"%@",error);
            }else{
                _hasMore = model.data.count == 90;
                if (requestMode == VMRequestModeRefresh) {
                    [self.dataList removeAllObjects];
                }
                [self.dataList addObjectsFromArray:model.data];
            }
            !completionHandler ?: completionHandler(error);
        }];
    }
}

- (NSMutableArray<InData *> *)dataList {
    if(_dataList == nil) {
        _dataList = [[NSMutableArray<InData *> alloc] init];
    }
    return _dataList;
}

@end
