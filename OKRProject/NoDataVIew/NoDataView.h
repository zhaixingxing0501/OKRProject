//
//  NoDataView.h
//  NucarfProject
//
//  Created by zhaixingxing on 2019/8/13.
//  Copyright © 2019 zhaixingxing. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum{
    /***  没有网络  ****/
    NoNetworkView = 1,
    /***  暂无数据  ****/
    NoDatasView = 2,
    /***  没有获取到位置  ****/
    NoHaveLocation = 3,
    /***  没有开启定位服务  ****/
    NoLocationServiceOpen = 4,
    /***  没有运单  ****/
    NoWaybill = 5,
    /***  没有消息  ****/
    NoMessage = 6,
    /***  数据加载失败  ****/
    NoResponse = 7,
    /*** 开发中  ****/
    Development = 8,
    /// 没有会员卡
    NoMembershipcard = 9
    
}NoFoundDirection;

typedef void(^refClickBlock)(void);


NS_ASSUME_NONNULL_BEGIN

@interface NoDataView : UIView

@property(nonatomic, copy) refClickBlock block;

/** 描述 */
@property (nonatomic, strong) UILabel *noDataDesLabel;

/** 图片 */
@property (nonatomic, strong) UIImageView *noDataIMGV;

/** 刷新按钮 */
@property (nonatomic, strong) UIButton *refBtn;


/**
 无数据页面（无刷新按钮）
 
 @param superView 所要放的父试图
 @param viewDirection 需要创建的类型
 @param number 距离上面的尺寸
 @return NoDataView对象
 */
+(id)initAddSubView:(UIView *)superView WithNoDirection:(NoFoundDirection )viewDirection andNearBottow:(CGFloat)number;

/**
 无数据页面（有刷新按钮）
 
 @param superView 所要放的父试图
 @param viewDirection 需要创建的类型
 @param block block
 @return NoDataView对象
 */
+(id)initAddSubView:(UIView *)superView WithNoDirection:(NoFoundDirection )viewDirection andBlock:(refClickBlock)block;


@end

NS_ASSUME_NONNULL_END
