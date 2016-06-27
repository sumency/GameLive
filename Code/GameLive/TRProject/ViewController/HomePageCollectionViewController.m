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
#import "DetailLiveViewMode.h"
@interface HomePageCollectionViewController ()<UICollectionViewDelegateFlowLayout>
@property (nonatomic) DetailLiveViewMode *detailVM;
@end

@implementation HomePageCollectionViewController

-(instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout{
    if (self = [super initWithCollectionViewLayout:layout]) {
        self.tabBarItem.title = @"首页";
        self.tabBarItem.image = [UIImage imageNamed:@"推荐-默认@2x.png.base.universal.regular.off.horizontal.normal.active.onepartscale.onepart.54283.000.00."];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"推荐-焦点@2x.png.base.universal.regular.off.horizontal.normal.active.onepartscale.onepart.19656.000.00."];
    }
    return self;
}
static NSString * const reuseIdentifier = @"Cell";


- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"FirstCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader  withReuseIdentifier:@"lixi"];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"DetailLiveCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.detailVM getDataWithRequestMode:VMRequestModeRefresh completionHandler:^(NSError *error) {
            [self.collectionView.mj_header endRefreshing];
            if (error) {
                DDLogError(@"%@",error);
            }else{
                [self.collectionView reloadData];
            }
        }];
    }];
    [self.collectionView.mj_header beginRefreshing];
    
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    FirstCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"lixi" forIndexPath:indexPath];
    headerView.title.text = @"李西";
    
    return headerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 14;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DetailLiveCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
//    [cell.iv sd_setImageWithURL:[self.detailVM coverURLForRow:indexPath.row]];
//    [cell.nick sd_setImageWithURL:[self.detailVM iconURLForRow:indexPath.row]];
//    cell.title.text = [self.detailVM titleForRow:indexPath.row];
//    cell.duan.text = [self.detailVM nickForRow:indexPath.row];
//    cell.viewNum.text = [self.detailVM viewForRow:indexPath.row];
    return cell;
}

- (DetailLiveViewMode *)detailVM {
	if(_detailVM == nil) {
		_detailVM = [[DetailLiveViewMode alloc] init];
	}
	return _detailVM;
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

@end
