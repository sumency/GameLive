
#import <Foundation/Foundation.h>
#import "LiveModel.h"
#import "TRBaseViewModel.h"
#import "NetManager.h"
@interface HomePageViewModel : TRBaseViewModel
@property (nonatomic) NSInteger numForSection;
@property (nonatomic) NSMutableArray<NSArray<ReData *> *> *dataList;
- (NSInteger)numForRowInSection:(NSInteger)section;

- (NSURL *)iconURLForRow:(NSInteger)row section:(NSInteger)section;
- (NSURL *)coverURLForRow:(NSInteger)row section:(NSInteger)section;
- (NSString *)viewForRow:(NSInteger)row section:(NSInteger)section;
- (NSString *)titleForRow:(NSInteger)row section:(NSInteger)section;
- (NSString *)nickForRow:(NSInteger)row section:(NSInteger)section;
- (NSString *)uidForRow:(NSInteger)row section:(NSInteger)section;
- (InData *)modelForRor:(NSInteger)row section:(NSInteger)section;
- (NSString *)CNNameForSecion:(NSInteger)section;
- (NSString *)ENNameForSecion:(NSInteger)section;

- (NSURL *)smallURLForRow:(NSInteger)row;
- (NSString *)smallTitleForRow:(NSInteger)row;

- (NSString *)gameNameForRow:(NSInteger)row;
@end
