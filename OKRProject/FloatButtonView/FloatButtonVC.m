//
//  FloatButtonVC.m
//  OKRProject
//
//  Created by zhaixingxing on 2020/7/28.
//  Copyright © 2020 zhaixingxing. All rights reserved.
//

#import "FloatButtonVC.h"
#import "FloatButton.h"

@interface FloatButtonVC ()

@property (nonatomic, strong) FloatButton *floatBtn;

@end

@implementation FloatButtonVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.floatBtn];
}

- (void)floatButtonClickAction:(UIButton *)sender {
    [[TKAlertCenter  defaultCenter] postAlertWithMessage:@"点击了浮动按钮"];
}

- (FloatButton *)floatBtn {
    if (!_floatBtn) {
        _floatBtn = [FloatButton buttonWithType:UIButtonTypeCustom];
        CGFloat buttonW = 50;
        CGFloat buttonH = buttonW;
        CGFloat buttonX = [UIScreen mainScreen].bounds.size.width - buttonW;
        CGFloat buttonY = [UIScreen mainScreen].bounds.size.height - buttonH - 50;
        _floatBtn.backgroundColor = UIColor.redColor;
        _floatBtn.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        [_floatBtn setTitle:@"浮动" forState:UIControlStateNormal];
        _floatBtn.layer.cornerRadius = buttonW / 2;
        _floatBtn.layer.masksToBounds = YES;
        [_floatBtn addTarget:self action:@selector(floatButtonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _floatBtn;
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
