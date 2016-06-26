
#import <Foundation/Foundation.h>

@class Esarray;
@interface CategoriesModel : NSObject

@property (nonatomic, strong) NSArray<Esarray *> *esArray;

@end
@interface Esarray : NSObject

@property (nonatomic, copy) NSString *slug;

@property (nonatomic, copy) NSString *first_letter;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, assign) NSInteger prompt;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *thumb;

@property (nonatomic, assign) NSInteger priority;

@property (nonatomic, copy) NSString *name;

@end

