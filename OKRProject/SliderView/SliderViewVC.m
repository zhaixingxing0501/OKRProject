//
//  SliderViewVC.m
//  OKRProject
//
//  Created by zhaixingxing on 2020/7/27.
//  Copyright © 2020 zhaixingxing. All rights reserved.
//

#import "SliderViewVC.h"
#import "DLScrollTabbarView.h"
#import "DLLRUCache.h"
#import "DLCustomSlideView.h"

@interface SliderViewVC ()<DLCustomSlideViewDelegate>

@property (nonatomic, strong) DLCustomSlideView *slideView;
@property (nonatomic, strong) DLScrollTabbarView *tabbar;
@property (nonatomic, strong) NSMutableArray *itemArray;

@end

@implementation SliderViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self setupSliderView];
}

- (void)setupSliderView {
    //设置滑块
    if (!_slideView) {
        _slideView = [[DLCustomSlideView alloc] initWithFrame:CGRectMake(0, kNavigationBarHeight, kScreenWidth, kScreenHeight - kNavigationBarHeight)];
    }
    [self.view addSubview:_slideView];

    DLLRUCache *cache = [[DLLRUCache alloc] initWithCount:3];
    if (!_tabbar) {
        self.tabbar = [[DLScrollTabbarView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    }

    self.tabbar.tabItemNormalColor = rgba(95, 104, 121, 1);
    self.tabbar.tabItemSelectedColor = UIColor.redColor;
    self.tabbar.tabItemNormalFontSize = 15;
    self.tabbar.trackColor = UIColor.redColor;

    for (int i = 1; i <= 10; i++) {
        DLScrollTabbarItem *item1 = [DLScrollTabbarItem itemWithTitle:[NSString stringWithFormat:@"第%d个", i] width:90];
        [self.itemArray addObject:item1];
    }

    self.tabbar.tabbarItems = self.itemArray;
    self.slideView.tabbar = self.tabbar;
    self.slideView.cache = cache;
    self.slideView.tabbarBottomSpacing = 0;
    self.slideView.delegate = self;
    self.slideView.baseViewController = self;
    [self.slideView setup];
    self.slideView.selectedIndex = 0;
}

- (NSInteger)numberOfTabsInDLCustomSlideView:(DLCustomSlideView *)sender {
    return self.itemArray.count;
}

- (UIViewController *)DLCustomSlideView:(DLCustomSlideView *)sender controllerAt:(NSInteger)index {
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = colorRandom;
    return vc;
}

- (NSMutableArray *)itemArray {
    if (!_itemArray) {
        _itemArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _itemArray;
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
