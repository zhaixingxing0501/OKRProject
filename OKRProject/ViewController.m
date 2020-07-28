//
//  ViewController.m
//  OKRProject
//
//  Created by zhaixingxing on 2020/7/27.
//  Copyright © 2020 zhaixingxing. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.tableFooterView = [UIView new];


    self.dataSource = [@[
                           [self makeItemWithTitle:@"NoDataView" subTitle:@"" image:@"" className:@"NoDataViewVC" selector:@""],
                           [self makeItemWithTitle:@"SliderView" subTitle:@"" image:@"" className:@"SliderViewVC" selector:@""],

//                           [self makeItemWithTitle:@"NoDataView" subTitle:@"" image:@"" className:@"NoDataViewVC" selector:@""],


                       ] mutableCopy];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSDictionary *item = self.dataSource[indexPath.row];
    cell.textLabel.text = item[@"title"];
    cell.detailTextLabel.text = item[@"subTitle"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *item = self.dataSource[indexPath.row];

    if ([item[@"selector"] length] > 0 && [self respondsToSelector:NSSelectorFromString(item[@"selector"])]) {
        SEL selector = NSSelectorFromString(item[@"selector"]);
        ((void (*)(id, SEL))[self methodForSelector:selector])(self, selector);
    } else if (!kStringIsEmpty(item[@"class"])) {
        BaseViewController *vc = [[NSClassFromString(item[@"class"]) alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        NSLog(@"没有跳转方法:%@", item);
    }
}

@end
