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
#import "TopCollectionReusableView.h"
#import "SmallCollectionViewCell.h"
@interface HomePageCollectionViewController ()<UICollectionViewDelegateFlowLayout>
@property (nonatomic) HomePageViewModel *homePageVM;

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
    
    [self.collectionView registerClass:[TopCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader  withReuseIdentifier:@"lixi2"];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"DetailLiveCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"SmallCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"lixi3"];
    
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.homePageVM getDataWithRequestMode:VMRequestModeRefresh completionHandler:^(NSError *error) {
            [self.collectionView.mj_header endRefreshing];
            if (error) {
                DDLogError(@"%@",error);
            }else{
                NSLog(@"%@",self.homePageVM);

                [self.collectionView reloadData];
            }
        }];
    }];
    [self.collectionView.mj_header beginRefreshing];
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        TopCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"lixi2" forIndexPath:indexPath];
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
        return CGSizeMake(1, 150);
    }else{
        return CGSizeMake(300, 40);}
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.homePageVM.numForSection;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 7;
    }else if (section == 1){
        return 2;
    }else{
        return 4;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        SmallCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"lixi3" forIndexPath:indexPath];
        [cell.iv sd_setImageWithURL:[self.homePageVM smallURLForRow:indexPath.row]];
        cell.text.text = @"lixi";
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
//    return [UICollectionViewCell new];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat w2 = lround(([UIScreen mainScreen].bounds.size.width - 30) / 2);
    //156*100
    CGFloat h2 = w2 * 100 / 156 + 40;
    return CGSizeMake(w2, h2);
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


@end
