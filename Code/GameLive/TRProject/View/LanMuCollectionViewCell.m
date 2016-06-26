//
//  LanMuCollectionViewCell.m
//  TRProject
//
//  Created by lixi on 16/6/26.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "LanMuCollectionViewCell.h"

@implementation LanMuCollectionViewCell

- (UIImageView *)iv {
    if(_iv == nil) {
        _iv = [[UIImageView alloc] init];
        [self.contentView addSubview:_iv];
        [_iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(0);
            make.bottom.equalTo(self.title.mas_top);
        }];
    }
    return _iv;
}

- (UILabel *)title {
    if(_title == nil) {
        _title = [[UILabel alloc] init];
        [self.contentView addSubview:_title];
        [_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(0);
            make.height.equalTo(30);
        }];
        _title.textAlignment = NSTextAlignmentCenter;
        _title.backgroundColor = [UIColor whiteColor];
    }
    return _title;
}
@end
