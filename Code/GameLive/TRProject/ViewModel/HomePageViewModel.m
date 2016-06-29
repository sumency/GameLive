
#import "HomePageViewModel.h"

@implementation HomePageViewModel

-(NSInteger)numForSection{
    return self.dataList.count;
}

-(NSString *)CNNameForSecion:(NSInteger)section{
    return [self modelForRor:0 section:section].category_name;
}

-(NSString *)ENNameForSecion:(NSInteger)section{
    return [self modelForRor:0 section:section].category_slug;
}

-(NSString *)uidForRow:(NSInteger)row section:(NSInteger)section{
    return [self modelForRor:row section:section].uid;
}

- (NSInteger)numForRowInSection:(NSInteger)section{
    return self.dataList[section].count;
}

- (NSURL *)iconURLForRow:(NSInteger)row section:(NSInteger)section{
    return [self modelForRor:row section:section].avatar.yx_URL;
}

- (NSURL *)coverURLForRow:(NSInteger)row section:(NSInteger)section{
    return [self modelForRor:row section:section].thumb.yx_URL;
}

- (NSString *)viewForRow:(NSInteger)row section:(NSInteger)section{
    return [self modelForRor:row section:section].view;
}

- (NSString *)titleForRow:(NSInteger)row section:(NSInteger)section{
    return [self modelForRor:row section:section].title;
}
- (NSString *)nickForRow:(NSInteger)row section:(NSInteger)section{
    return [self modelForRor:row section:section].nick;
}

- (InData *)modelForRor:(NSInteger)row section:(NSInteger)section{
    return self.dataList[section][row].link_object;
}

-(NSURL *)smallURLForRow:(NSInteger)row{
    return self.dataList[14][row].thumb.yx_URL;
}
-(NSString *)smallTitleForRow:(NSInteger)row{
    return self.dataList[14][row].title;
}
-(NSString *)gameNameForRow:(NSInteger)row{
    return self.dataList[14][row].ext.classification;
}

-(NSString *)CNGameNameForRow:(NSInteger)row{
    return self.dataList[14][row].title;
}

-(void)getDataWithRequestMode:(VMRequestMode)requestMode completionHandler:(void (^)(NSError *))completionHandler{
    _dataTask = [NetManager getHomePageComletionHandler:^(id model, NSError *error) {
        if (error) {
            DDLogError(@"%@",error);
        }else{
            if (requestMode == VMRequestModeRefresh) {
                self.dataList = nil;
            }
            NSArray *name = @[@"mobileIndex",@"mobileRecommendation",@"mobileLol",@"mobileBeauty",@"mobileHeartstone",@"mobileHuWai",@"appOwerWatch",@"mobileDota2",@"mobileTvgame",@"moblieBlizzard",@"moblieSport",@"moblieWebgame",@"moblieDnf",@"moblieMinecraft",@"appClassification"];
            
            for (int i = 0; i < name.count; i ++) {
                NSArray *tmpArr = [model valueForKey:name[i]];
                [self.dataList addObject:tmpArr];
            }
        }
        !completionHandler ?: completionHandler(error);
    }];
}

- (NSMutableArray<NSArray<ReData *> *> *)dataList {
    if(_dataList == nil) {
        _dataList = [[NSMutableArray<NSArray<ReData *> *> alloc] init];
    }
    return _dataList;
}
@end
