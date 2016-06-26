//
//  DetailLiveCollectionViewCell.h
//  TRProject
//
//  Created by lixi on 16/6/26.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailLiveCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iv;
@property (weak, nonatomic) IBOutlet UILabel *viewNum;
@property (weak, nonatomic) IBOutlet UIImageView *nick;
@property (weak, nonatomic) IBOutlet UILabel *duan;
@property (weak, nonatomic) IBOutlet UILabel *title;

@end
