//
//  DetailLiveCollectionViewController.m
//  TRProject
//
//  Created by lixi on 16/6/26.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "DetailLiveCollectionViewController.h"
#import "DetailLiveCollectionViewCell.h"
#import "DetailLiveViewMode.h"
#import "VedioViewController.h"
@import AVFoundation;
@import AVKit;
@interface DetailLiveCollectionViewController ()<UICollectionViewDelegateFlowLayout>
@property (nonatomic) DetailLiveViewMode *detailVM;

@end

@implementation DetailLiveCollectionViewController

static NSString * const reuseIdentifier = @"Cell";
-(instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout{
    if (self = [super initWithCollectionViewLayout:layout]) {
        if (self.gameName == nil) {
            self.title = @"直播";
            self.tabBarItem.image = [UIImage imageNamed:@"发现-默认@2x.png.base.universal.regular.off.horizontal.normal.active.onepartscale.onepart.53246.000.00."];
            self.tabBarItem.selectedImage = [UIImage imageNamed:@"发现-焦点@2x.png.base.universal.regular.off.horizontal.normal.active.onepartscale.onepart.18619.000.00."];
        }else{
            
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.gameName == nil) {
        self.navigationItem.title = @"直播";
    }else{
        self.navigationItem.title = self.CNName;
        
    }
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerNib:[UINib nibWithNibName:@"DetailLiveCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.detailVM getDataWithRequestMode:VMRequestModeRefresh completionHandler:^(NSError *error) {
            [self.collectionView.mj_header endRefreshing];
            if (error) {
                DDLogError(@"%@",error);
            }else{
                [self.collectionView reloadData];
                if (self.detailVM.hasMore) {
                    [self.collectionView.mj_footer resetNoMoreData];
                }else{
                    [self.collectionView.mj_footer endRefreshingWithNoMoreData];
                }
            }
        }];
    }];
    [self.collectionView.mj_header beginRefreshing];
    
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self.detailVM getDataWithRequestMode:VMRequestModeMore completionHandler:^(NSError *error) {
            [self.collectionView.mj_footer endRefreshing];
            if (error) {
                DDLogError(@"%@",error);
            }else{
                [self.collectionView reloadData];
                if (self.detailVM.hasMore) {
                    [self.collectionView.mj_footer endRefreshing];
                }else{
                    [self.collectionView.mj_footer endRefreshingWithNoMoreData];
                }
            }
        }];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.detailVM.numForRow;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DetailLiveCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cell.iv sd_setImageWithURL:[self.detailVM coverURLForRow:indexPath.row]];
    [cell.nick sd_setImageWithURL:[self.detailVM iconURLForRow:indexPath.row]];
    cell.title.text = [self.detailVM titleForRow:indexPath.row];
    cell.duan.text = [self.detailVM nickForRow:indexPath.row];
    cell.viewNum.text = [self.detailVM viewForRow:indexPath.row];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
//    AVPlayerViewController *vc = [AVPlayerViewController new];
//    vc.player = [AVPlayer playerWithURL:[NSString stringWithFormat:kVedio,[self.detailVM uidForRow:indexPath.row]].yx_URL];
//     NSLog(@"%@",[NSString stringWithFormat:kVedio,[self.detailVM uidForRow:indexPath.row]]);
//    [vc.player play];
//   
//    [self presentViewController:vc animated:YES completion:nil];
    
    VedioViewController *vc = [VedioViewController new];
    vc.url = [NSString stringWithFormat:kVedio,[self.detailVM uidForRow:indexPath.row]].yx_URL;
    vc.hidesBottomBarWhenPushed = YES;
    vc.titleName = [self.detailVM nickForRow:indexPath.row];
    vc.name = [self.detailVM titleForRow:indexPath.row];
    vc.imgURL = [self.detailVM iconURLForRow:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

- (DetailLiveViewMode *)detailVM {
    if(_detailVM == nil) {
        _detailVM = [[DetailLiveViewMode alloc] initWithGameName:self.gameName];
    }
    return _detailVM;
}
@end
