//
//  TopCollectionReusableView.m
//  TRProject
//
//  Created by lixi on 16/6/28.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "TopCollectionReusableView.h"

@interface TopCollectionReusableView()<iCarouselDelegate, iCarouselDataSource>{
    NSTimer *_timer;
}
@property (nonatomic, strong) iCarousel *ic;
@property (nonatomic, strong) UIPageControl *pc;
@end

@implementation TopCollectionReusableView
- (iCarousel *)ic {
    _ic = [[iCarousel alloc] initWithFrame:CGRectMake(0, 0, 0, kScreenW * 2 / 3)];
    _ic.delegate = self;
    _ic.dataSource = self;
    [self addSubview:_ic];
    
    _pc = [UIPageControl new];
    _pc.numberOfPages = 4;
    [_ic addSubview:_pc];
    [_pc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(3);
        make.right.equalTo(-3);
    }];
    _ic.scrollSpeed = .2;
    return _ic;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    if (!view) {
        view = [[UIView alloc] initWithFrame:carousel.bounds];
        UIImageView *iv = [UIImageView new];
        iv.tag = 100;
        [view addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 30, 0));
        }];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        UILabel *lab = [UILabel new];
        lab.tag = 101;
        [view addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(iv.mas_bottom);
            make.left.right.bottom.equalTo(0);
        }];
        lab.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:0.8];
    }
    UILabel *lab = (UILabel *)[view viewWithTag:101];
    lab.text = @"lixi";
    UIImageView *iv = (UIImageView *)[view viewWithTag:100];
    iv.image = [UIImage imageNamed:@"03.png.base.universal.regular.off.horizontal.normal.active.onepartscale.onepart.26972.000.00.@1x"];
    iv.clipsToBounds = YES;
    return view;
}


- (UIPageControl *)pc {
	if(_pc == nil) {
		_pc = [[UIPageControl alloc] init];
	}
	return _pc;
}

@end
