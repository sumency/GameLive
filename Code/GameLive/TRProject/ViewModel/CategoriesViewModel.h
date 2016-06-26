
#import "TRBaseViewModel.h"
#import "CategoriesModel.h"
@interface CategoriesViewModel : TRBaseViewModel
@property (nonatomic) NSInteger numForIndex;
@property (nonatomic) NSArray<Esarray *> *dataList;

- (Esarray *)modelForIndex:(NSInteger)index;
- (NSString *)titleForIndex:(NSInteger)index;
- (NSURL *)iconURLForIndex:(NSInteger)index;
- (NSString *)gameNameForIndex:(NSInteger)index;
@end
