//
//  DetailLiveCollectionViewController.h
//  TRProject
//
//  Created by lixi on 16/6/26.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailLiveCollectionViewController : UICollectionViewController
@property (nonatomic) NSString *gameName;
- (instancetype)initWithGameName:(NSString *)gameName;
@end
