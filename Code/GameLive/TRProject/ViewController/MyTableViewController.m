//
//  MyTableViewController.m
//  TRProject
//
//  Created by lixi on 16/6/27.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "MyTableViewController.h"

@interface MyTableViewController ()

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
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 6;
}

@end
