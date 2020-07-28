//
//  NoDataManager.m
//  OKRProject
//
//  Created by zhaixingxing on 2020/7/27.
//  Copyright © 2020 zhaixingxing. All rights reserved.
//

#import "NoDataManager.h"

@implementation NoDataManager

static NoDataManager *_shareView = nil;

+ (instancetype)shareView {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareView = [[NoDataManager alloc] init];
    });
    return _shareView;
}

#pragma mark --  无数据页面方法 --
//添加无网，无数据页面
- (void)addNoDataViewWithSuperView:(UIView *)superView directiontype:(NoFoundDirection)type refreshBlock:(void (^)(void))refreshBlock {
    [self removeNodataView];

    if (refreshBlock) {
        self.noDataView = [NoDataView initAddSubView:superView WithNoDirection:type andBlock:^{
            refreshBlock();
        }];
    } else {
        self.noDataView = [NoDataView initAddSubView:superView WithNoDirection:type andNearBottow:0];
    }
}

//添加无网，无数据页面
- (void)addNoDataViewWithSuperView:(UIView *)superView directiontype:(NoFoundDirection)type
{
    [self removeNodataView];
    self.noDataView = [NoDataView initAddSubView:superView WithNoDirection:type andNearBottow:0];
}

//添加无网，无数据页面
- (void)addNoDataNearBottowViewWithSuperView:(UIView *)superView directiontype:(NoFoundDirection)type andNearBottow:(CGFloat)number {
    [self removeNodataView];
    self.noDataView = [NoDataView initAddSubView:superView WithNoDirection:type andNearBottow:number];
}

//移除无网，无数据页面
- (void)removeNodataView {
    if (_noDataView) {
        [_noDataView removeFromSuperview];
    }
}

@end
