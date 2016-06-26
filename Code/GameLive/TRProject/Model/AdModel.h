
#import <Foundation/Foundation.h>
#import "HomePageModel.h"
@class Ad;
@interface AdModel : NSObject

@property (nonatomic, strong) NSArray<Ad *> *playerGuanggao;

@property (nonatomic, strong) NSArray *appAd;

@property (nonatomic, strong) NSArray<Ad *> *pcBanner;

@property (nonatomic, strong) NSArray<List *> *list;

@property (nonatomic, strong) NSArray<Ad *> *pcBanner2;

@end

@interface Ad : NSObject

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, copy) NSString *subtitle;

//id -> ID
@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *ext;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *fk;

@property (nonatomic, copy) NSString *thumb;

@property (nonatomic, copy) NSString *link;

@property (nonatomic, copy) NSString *create_at;

@property (nonatomic, assign) NSInteger slot_id;

@property (nonatomic, assign) NSInteger priority;

@end

