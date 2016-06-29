//
//  HomePageCollectionViewController.m
//  TRProject
//
//  Created by lixi on 16/6/27.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "HomePageCollectionViewController.h"
#import "FirstCollectionReusableView.h"
#import "DetailLiveCollectionViewCell.h"
#import "HomePageViewModel.h"
#import "DetailLiveCollectionViewController.h"
#import <iCarousel.h>
@import AVFoundation;
@import AVKit;
@interface HomePageCollectionViewController ()<iCarouselDelegate, iCarouselDataSource>{
    NSTimer *_timer;
}
@property (nonatomic) HomePageViewModel *homePageVM;
@property (nonatomic) iCarousel *ic;
@property (nonatomic) iCarousel *icTop;

@property (nonatomic) UIPageControl *pc;
@end

@implementation HomePageCollectionViewController

-(instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout{
    if (self = [super initWithCollectionViewLayout:layout]) {
        self.title = @"首页";
        self.tabBarItem.image = [UIImage imageNamed:@"推荐-默认@2x.png.base.universal.regular.off.horizontal.normal.active.onepartscale.onepart.54283.000.00."];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"推荐-焦点@2x.png.base.universal.regular.off.horizontal.normal.active.onepartscale.onepart.19656.000.00."];
    }
    return self;
}
static NSString * const reuseIdentifier = @"Cell";


- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"FirstCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader  withReuseIdentifier:@"lixi"];
    
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader  withReuseIdentifier:@"lixi2"];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"DetailLiveCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"first"];
    
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.homePageVM getDataWithRequestMode:VMRequestModeRefresh completionHandler:^(NSError *error) {
            [self.collectionView.mj_header endRefreshing];
            if (error) {
                DDLogError(@"%@",error);
            }else{
                NSLog(@"%@",self.homePageVM);
                
                [self.collectionView reloadData];
                [self carouselCurrentItemIndexDidChange:self.icTop];
                [_timer invalidate];
                _timer = nil;
                _timer = [NSTimer bk_scheduledTimerWithTimeInterval:2 block:^(NSTimer *timer) {
                    [_icTop scrollToItemAtIndex:_icTop.currentItemIndex+1 animated:YES];
                } repeats:YES];
            }
        }];
    }];
    [self.collectionView.mj_header beginRefreshing];
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"lixi2" forIndexPath:indexPath];
        
        [headerView addSubview:self.icTop];
        [self.icTop mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
        return headerView;
    }else{
        FirstCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"lixi" forIndexPath:indexPath];
        
        if(indexPath.section == 1){
            headerView.title.text = @"精彩推荐";
        }else{
            headerView.title.text = [self.homePageVM CNNameForSecion:indexPath.section];
        }
        [headerView.haveSee removeAllTargets];
        [headerView.haveSee bk_addEventHandler:^(id sender) {
            
            UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
            layout.minimumLineSpacing = 10;
            layout.minimumInteritemSpacing = 10;
            layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
            layout.scrollDirection = UICollectionViewScrollDirectionVertical;
            CGFloat w = lround(([UIScreen mainScreen].bounds.size.width - 30) / 2);
            //    156*100
            CGFloat h = w * 100 / 156 + 40;
            layout.itemSize = CGSizeMake(w, h);
            DetailLiveCollectionViewController *dvc = [[DetailLiveCollectionViewController alloc]initWithCollectionViewLayout:layout];
            dvc.hidesBottomBarWhenPushed = YES;
            dvc.gameName = [self.homePageVM ENNameForSecion:indexPath.section];
            dvc.CNName = [self.homePageVM CNNameForSecion:indexPath.section];
            [self.navigationController pushViewController:dvc animated:YES];
            
        } forControlEvents:UIControlEventTouchUpInside];
        headerView.image.image = [UIImage imageNamed:@"弹幕-默认@2x.png.base.universal.regular.off.horizontal.normal.active.onepartscale.onepart.49182.000.00."];
        return headerView;
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeMake(1, 180);
    }else{
        return CGSizeMake(300, 40);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.homePageVM.numForSection-1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 2;
    }else{
        return 4;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"first" forIndexPath:indexPath];
        //        cell.backgroundColor = [UIColor redColor];
        [cell.contentView addSubview:self.ic];
        [self.ic mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
        return cell;
    }else{
        DetailLiveCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        [cell.iv sd_setImageWithURL:[self.homePageVM coverURLForRow:indexPath.row section:indexPath.section]];
        [cell.nick sd_setImageWithURL:[self.homePageVM iconURLForRow:indexPath.row section:indexPath.section]];
        cell.title.text = [self.homePageVM titleForRow:indexPath.row section:indexPath.section];
        cell.duan.text = [self.homePageVM nickForRow:indexPath.row section:indexPath.section];
        cell.viewNum.text = [self.homePageVM viewForRow:indexPath.row section:indexPath.section];
        return cell;
    }
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        CGFloat w2 = (lround([UIScreen mainScreen].bounds.size.width));
        CGFloat h2 = 60 ;
        return CGSizeMake(w2, h2);
    }else{
        CGFloat w2 = lround(([UIScreen mainScreen].bounds.size.width - 30) / 2);
        //156*100
        CGFloat h2 = w2 * 100 / 156 + 40;
        return CGSizeMake(w2, h2);
    }
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

- (HomePageViewModel *)homePageVM {
    if(_homePageVM == nil) {
        _homePageVM = [[HomePageViewModel alloc] init];
    }
    return _homePageVM;
}


//此方法无法判断carousel的tag值
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    if (carousel.tag == 7) {
        return 7;
    }
    else{
        return 4;
    }
}
- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    NSLog(@"cell:%ld",(long)carousel.tag);
    if (carousel.tag == 7) {
        if (!view) {
            view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 60)];
            UIImageView *iv = [UIImageView new];
            iv.tag = 100;
            [view addSubview:iv];
            [iv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.width.equalTo(40);
                make.top.equalTo(0);
                make.centerX.equalTo(0);
            }];
            iv.contentMode = UIViewContentModeScaleAspectFill;
            iv.layer.cornerRadius = 20;
            iv.clipsToBounds = YES;
            UILabel *lab = [UILabel new];
            lab.tag = 101;
            [view addSubview:lab];
            [lab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(iv.mas_bottom);
                make.centerX.equalTo(0);
            }];
            lab.font = [UIFont systemFontOfSize:10];
            lab.textColor = [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1.0];
        }
        UILabel *lab = (UILabel *)[view viewWithTag:101];
        lab.text = [self.homePageVM smallTitleForRow:index];
        UIImageView *iv = (UIImageView *)[view viewWithTag:100];
        [iv sd_setImageWithURL:[self.homePageVM smallURLForRow:index]];
        iv.clipsToBounds = YES;
        return view;
    }
    if (carousel.tag == 4) {
        if (!view) {
            view = [[UIView alloc] initWithFrame:carousel.bounds];
            view.backgroundColor = [UIColor cyanColor];
            UIImageView *iv = [UIImageView new];
            iv.tag = 100;
            [view addSubview:iv];
            [iv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(0);
            }];
            iv.contentMode = UIViewContentModeScaleAspectFill;
            UILabel *lab = [UILabel new];
            lab.tag = 101;
            [iv addSubview:lab];
            [lab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(10);
                make.bottom.equalTo(-10);
            }];
            lab.font = [UIFont systemFontOfSize:12];
            lab.textColor = [UIColor whiteColor];
            
        }
        UILabel *lab = (UILabel *)[view viewWithTag:101];
        lab.text = [self.homePageVM titleForRow:index section:0];
        UIImageView *iv = (UIImageView *)[view viewWithTag:100];
        [iv sd_setImageWithURL:[self.homePageVM coverURLForRow:index section:0]];
        iv.clipsToBounds = YES;
        return view;
        
    }
    return [UIView new];
}
- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value{
    if (option == iCarouselOptionWrap) {
        value = YES;
    }
    return value;
}
- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel{
    if (carousel.tag == 4) {
        _pc.currentPage = carousel.currentItemIndex;
        
    }
}
- (iCarousel *)ic {
    if(_ic == nil) {
        _ic = [[iCarousel alloc] initWithFrame:CGRectMake(0, 0, 0, 60)];
        _ic.delegate = self;
        _ic.dataSource = self;
        _ic.autoscroll = 0;
        _ic.scrollSpeed = .1;
        _ic.tag = 7;
    }
    return _ic;
}
- (iCarousel *)icTop {
    if(_icTop == nil) {
        _icTop = [[iCarousel alloc] initWithFrame:CGRectMake(0, 0, 0, 150)];
        _icTop.backgroundColor = [UIColor cyanColor];
        _icTop.delegate = self;
        _icTop.dataSource = self;
        _icTop.autoscroll = 0;
        _icTop.scrollSpeed = .1;
        _icTop.tag = 4;
        _pc = [UIPageControl new];
        [_icTop addSubview:_pc];
        [_pc mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-10);
            make.bottom.equalTo(2);
        }];
        _pc.numberOfPages = 4;
        _pc.userInteractionEnabled = NO;
        _pc.pageIndicatorTintColor = [UIColor grayColor];
        _pc.currentPageIndicatorTintColor = [UIColor whiteColor];
    }
    return _icTop;
}

- (UIPageControl *)pc {
    if(_pc == nil) {
        _pc = [[UIPageControl alloc] init];
    }
    return _pc;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    AVPlayerViewController *vc = [AVPlayerViewController new];
    vc.player = [AVPlayer playerWithURL:[NSString stringWithFormat:kVedio,[self.homePageVM uidForRow:indexPath.row section:indexPath.section]].yx_URL];
    [vc.player play];
    
    [self presentViewController:vc animated:YES completion:nil];
}

-(void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index{
    if (carousel.tag == 7) {
        
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        CGFloat w = lround(([UIScreen mainScreen].bounds.size.width - 30) / 2);
        //    156*100
        CGFloat h = w * 100 / 156 + 40;
        layout.itemSize = CGSizeMake(w, h);
        DetailLiveCollectionViewController *dvc = [[DetailLiveCollectionViewController alloc]initWithCollectionViewLayout:layout];
        dvc.hidesBottomBarWhenPushed = YES;
        dvc.gameName = [self.homePageVM gameNameForRow:index];
        dvc.CNName = [self.homePageVM CNNameForSecion:index];
        UIBarButtonItem *btn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"a"] style:UIBarButtonItemStyleDone target:self action:@selector(showList:)];
        dvc.navigationItem.leftBarButtonItem = btn;
        
        [self.navigationController pushViewController:dvc animated:YES];
    }
    if (carousel.tag == 4) {
        AVPlayerViewController *vc = [AVPlayerViewController new];
        vc.player = [AVPlayer playerWithURL:[NSString stringWithFormat:kVedio,[self.homePageVM uidForRow:index section:0]].yx_URL];
        [vc.player play];
        
        [self presentViewController:vc animated:YES completion:nil];
    }
    
}
- (void)showList:sender{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
