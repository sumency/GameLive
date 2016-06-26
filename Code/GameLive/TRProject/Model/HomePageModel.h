
#import <Foundation/Foundation.h>
#import "LiveModel.h"
@class List;
@interface HomePageModel : NSObject

@property (nonatomic, strong) NSArray<ReData *> *moblieWebgame;

@property (nonatomic, strong) NSArray<ReData *> *moblieMinecraft;

@property (nonatomic, strong) NSArray<ReData *> *mobileTvgame;

@property (nonatomic, strong) NSArray<ReData *> *moblieSport;

@property (nonatomic, strong) NSArray<ReData *> *mobileStar;

@property (nonatomic, strong) NSArray<ReData *> *mobileRecommendation;

@property (nonatomic, strong) NSArray<ReData *> *mobileIndex;

@property (nonatomic, strong) NSArray<ReData *> *mobileLol;

@property (nonatomic, strong) NSArray<ReData *> *mobileBeauty;

@property (nonatomic, strong) NSArray<ReData *> *mobileHeartstone;

@property (nonatomic, strong) NSArray<ReData *> *moblieBlizzard;

@property (nonatomic, strong) NSArray<List *> *list;

@property (nonatomic, strong) NSArray<ReData *> *mobileDota2;

@property (nonatomic, strong) NSArray<ReData *> *moblieDnf;

@end

@interface List : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *slug;

@end

