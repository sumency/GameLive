//
//  DetailLiveViewMode.h
//  TRProject
//
//  Created by lixi on 16/6/26.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "TRBaseViewModel.h"
#import "LiveModel.h"
@interface DetailLiveViewMode : TRBaseViewModel

-initWithGameName:(NSString *)gameName;
@property (nonatomic) NSInteger page;
@property (nonatomic,getter=isHasMore) BOOL hasMore;
@property (nonatomic) NSMutableArray<InData *> *dataList;
@property (nonatomic) NSInteger numForRow;
@property (nonatomic) NSString *gameName;

- (InData *)modelForRow:(NSInteger)row;
- (NSURL *)iconURLForRow:(NSInteger)row;
- (NSURL *)coverURLForRow:(NSInteger)row;
- (NSString *)viewForRow:(NSInteger)row;
- (NSString *)titleForRow:(NSInteger)row;
- (NSString *)nickForRow:(NSInteger)row;
- (NSString *)uidForRow:(NSInteger)row;
@end
