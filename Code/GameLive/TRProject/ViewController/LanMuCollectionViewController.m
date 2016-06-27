//
//  LanMuCollectionViewController.m
//  TRProject
//
//  Created by lixi on 16/6/26.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "LanMuCollectionViewController.h"
#import "LanMuCollectionViewCell.h"
#import "CategoriesViewModel.h"
#import "DetailLiveCollectionViewController.h"
@interface LanMuCollectionViewController ()
@property (nonatomic) CategoriesViewModel *lanMuVM;

@end

@implementation LanMuCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

-(instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout{
    if (self = [super initWithCollectionViewLayout:layout]) {
        self.title = @"栏目";
        self.tabBarItem.image = [UIImage imageNamed:@"栏目-默认@2x.png.base.universal.regular.off.horizontal.normal.active.onepartscale.onepart.45456.000.00."];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"栏目-焦点@2x.png.base.universal.regular.off.horizontal.normal.active.onepartscale.onepart.10829.000.00."];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
    [self.collectionView registerClass:[LanMuCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.lanMuVM getDataWithRequestMode:VMRequestModeRefresh completionHandler:^(NSError *error) {
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.lanMuVM.numForIndex;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LanMuCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.title.text = [self.lanMuVM titleForIndex:indexPath.row];
    [cell.iv sd_setImageWithURL:[self.lanMuVM iconURLForIndex:indexPath.row]];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
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
    dvc.gameName = [self.lanMuVM gameNameForIndex:indexPath.row];
    dvc.CNName = [self.lanMuVM titleForIndex:indexPath.row];
    UIBarButtonItem *btn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"a"] style:UIBarButtonItemStyleDone target:self action:@selector(showList:)];
    dvc.navigationItem.leftBarButtonItem = btn;
    
    [self.navigationController pushViewController:dvc animated:YES];
}
- (void)showList:sender{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 懒加载 Lazy Load
- (CategoriesViewModel *)lanMuVM {
    if(_lanMuVM == nil) {
        _lanMuVM = [[CategoriesViewModel alloc] init];
    }
    return _lanMuVM;
}

@end
