//
//  NoDataManager.h
//  OKRProject
//
//  Created by zhaixingxing on 2020/7/27.
//  Copyright © 2020 zhaixingxing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NoDataView.h"

NS_ASSUME_NONNULL_BEGIN

@interface NoDataManager : NSObject

@property (nonatomic, strong) NoDataView *noDataView;

+ (instancetype)shareView;

- (void)addNoDataViewWithSuperView:(UIView *)superView directiontype:(NoFoundDirection)type refreshBlock:(void (^)(void))refreshBlock;
- (void)addNoDataNearBottowViewWithSuperView:(UIView *)superView directiontype:(NoFoundDirection)type andNearBottow:(CGFloat)number;
- (void)addNoDataViewWithSuperView:(UIView *)superView directiontype:(NoFoundDirection)type;
- (void)removeNodataView;

@end

NS_ASSUME_NONNULL_END
