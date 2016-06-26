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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"栏目";
    self.collectionView.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
    [self.collectionView registerClass:[LanMuCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.lanMuVM getDataWithRequestMode:0 completionHandler:^(NSError *error) {
        [self.collectionView reloadData];
    }];
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
    DetailLiveCollectionViewController *dvc = [[DetailLiveCollectionViewController alloc]initWithGameName:[self.lanMuVM gameNameForIndex:indexPath.row]];
    [self.navigationController pushViewController:dvc animated:YES];
}

#pragma mark - 懒加载 Lazy Load
- (CategoriesViewModel *)lanMuVM {
	if(_lanMuVM == nil) {
		_lanMuVM = [[CategoriesViewModel alloc] init];
	}
	return _lanMuVM;
}

@end
