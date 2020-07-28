//
//  NoDataViewVC.m
//  OKRProject
//
//  Created by zhaixingxing on 2020/7/27.
//  Copyright © 2020 zhaixingxing. All rights reserved.
//

#import "NoDataViewVC.h"
#import <MJRefresh.h>
#import "NoDataManager.h"

@interface NoDataViewVC ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UISwitch *switchView;

@property (nonatomic, assign) NSInteger total;

@property (nonatomic, assign) BOOL isRefresh;

@end

@implementation NoDataViewVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.total = 20;
    self.isRefresh = YES;

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.mj_header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    self.tableView.mj_footer = [MJRefreshAutoStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
}

- (BOOL)noMoreDataWithIsRefresh:(BOOL)isRefresh {
    if (self.dataSource.count != 0 && self.dataSource.count >= self.total && isRefresh == NO) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        return YES;
    }
    return NO;
}

- (void)requestDataWithIsRefresh:(BOOL)isRefresh {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self endRefreshing];
    });
}

- (void)endRefreshing {
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

- (void)headerRereshing {
    self.total = 20;
    [[NoDataManager shareView] removeNodataView];

    [self requestDataWithIsRefresh:YES];
}

- (void)footerRereshing {
    
    if (self.total >= 40) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    self.total += 10;
    [self requestDataWithIsRefresh:NO];
}

- (IBAction)switchAction1:(UISwitch *)sender {
    self.isRefresh = sender.on;
    
    if (!sender.on) {
        [[NoDataManager shareView] addNoDataViewWithSuperView:self.tableView directiontype:NoDatasView refreshBlock:^{
              [[NoDataManager shareView] removeNodataView];
          }];
    }
  
}

- (IBAction)switchAction:(UISwitch *)sender {
    if (sender.on) {
        self.tableView.mj_header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
        self.tableView.mj_footer = [MJRefreshAutoStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    } else {
        self.tableView.mj_header = nil;
        self.tableView.mj_footer = nil;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.total;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行", indexPath.row];
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
