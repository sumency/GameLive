//
//  MyTableViewController.m
//  TRProject
//
//  Created by lixi on 16/6/27.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "MyTableViewController.h"
#import "MeTableViewCell.h"
@interface MyTableViewController ()
@property (nonatomic) NSArray *titleName;

@end

@implementation MyTableViewController
-(instancetype)initWithStyle:(UITableViewStyle)style{
    if (self = [super initWithStyle:style]) {
        self.tabBarItem.title = @"我的";
        self.tabBarItem.image = [UIImage imageNamed:@"我的-默认@2x.png.base.universal.regular.off.horizontal.normal.active.onepartscale.onepart.45662.000.00."];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"我的-焦点@2x.png.base.universal.regular.off.horizontal.normal.active.onepartscale.onepart.1391.000.00."];
    }
    
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"MeTableViewCell" bundle:nil] forCellReuseIdentifier:@"lixi"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lixi" forIndexPath:indexPath];
    NSString *tmp = [NSString stringWithFormat:@"%ld",indexPath.row];
    cell.iv.image = [UIImage imageNamed:tmp];
    cell.lab.text = self.titleName[indexPath.row];
    return cell;
}
- (NSArray *)titleName {
	if(_titleName == nil) {
		_titleName = [[NSArray alloc] init];
        _titleName = @[@"房间管理",@"我的关注",@"观看历史",@"开播提醒",@"新手任务",@"游戏中心"];
	}
	return _titleName;
}

@end
