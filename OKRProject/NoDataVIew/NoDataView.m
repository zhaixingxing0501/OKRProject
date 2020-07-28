//
//  NoDataView.m
//  NucarfProject
//
//  Created by zhaixingxing on 2019/8/13.
//  Copyright © 2019 zhaixingxing. All rights reserved.
//

#import "NoDataView.h"
#import <Masonry.h>

#define rgba(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

@interface NoDataView ()

/** 父试图 */
@property (nonatomic,weak) UIView *superView;
/** 试图显示状态 */
@property (nonatomic, unsafe_unretained) NoFoundDirection viewDirection;
/** 刷新按钮是否显示 */
@property (nonatomic,assign) BOOL isRefesh;

@end

@implementation NoDataView


/**
 无数据页面（无刷新按钮）
 
 @param superView 所要放的父试图
 @param viewDirection 需要创建的类型
 @return NoDataView对象
 */
+(id)initAddSubView:(UIView *)superView WithNoDirection:(NoFoundDirection )viewDirection andNearBottow:(CGFloat)number
{
    return [NoDataView setView:superView WithNoDirection:viewDirection isRefesh:NO andNearBottow:number];
}

/**
 无数据页面（有刷新按钮）
 
 @param superView 所要放的父试图
 @param viewDirection 需要创建的类型
 @param block block
 @return NoDataView对象
 */
+(id)initAddSubView:(UIView *)superView WithNoDirection:(NoFoundDirection )viewDirection andBlock:(refClickBlock)block;
{
    NoDataView *noDataView=[NoDataView setView:superView WithNoDirection:viewDirection isRefesh:YES andNearBottow:0];
    noDataView.block = block;
    return noDataView;
}

+(NoDataView *)setView:(UIView *)superView WithNoDirection:(NoFoundDirection )viewDirection isRefesh:(BOOL)ref andNearBottow:(CGFloat)number
{
    NoDataView *noDataView;
    if(!noDataView)
    {
        noDataView = [[NoDataView alloc] initWithFrame:CGRectMake(0, number, CGRectGetWidth(superView.frame), CGRectGetHeight(superView.frame))];
    }
    noDataView.backgroundColor = [UIColor whiteColor];
    noDataView.superView = superView;
    noDataView.viewDirection = viewDirection;
    noDataView.isRefesh=ref;
    [superView addSubview:noDataView];
    [superView bringSubviewToFront:noDataView];
    [noDataView setupChildViews];
    return noDataView;
}

- (void)setupChildViews {
    
    [self  addSubview:self.noDataIMGV];
    [self.noDataIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.superView.mas_top).mas_offset(110);
        make.centerX.equalTo(self.superView.mas_centerX);

    }];
    [self addSubview:self.noDataDesLabel];
    [_noDataDesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.superView.mas_centerX);
        make.top.mas_equalTo(self.noDataIMGV.mas_bottom).offset(5);
    }];
    
    if(_isRefesh){
        [self addSubview:self.refBtn];
        [_refBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.superView.mas_centerX);
            make.top.equalTo(self.noDataDesLabel.mas_bottom).offset(100);
            make.size.mas_equalTo(CGSizeMake(130, 44));
        }];
    }
}

#pragma mark -- lazy loading --
- (UILabel *)noDataDesLabel {
    if(!_noDataDesLabel) {
        _noDataDesLabel = [[UILabel alloc] init];
        _noDataDesLabel.textColor = rgba(144, 155, 173, 1);
        _noDataDesLabel.textAlignment = NSTextAlignmentCenter;
        _noDataDesLabel.font = [UIFont systemFontOfSize:14.0f];
    }
    return _noDataDesLabel;
}

- (UIImageView *)noDataIMGV {
    if (!_noDataIMGV) {
        self.noDataIMGV = [[UIImageView alloc] init];
    }
    return _noDataIMGV;
}

- (UIButton *)refBtn{
    if(!_refBtn) {
        _refBtn = [[UIButton alloc]init];
        [_refBtn setTitle:@"重新加载" forState:UIControlStateNormal];
        [_refBtn setTitleColor:rgba(95, 104, 121, 1) forState:UIControlStateNormal];
        _refBtn.backgroundColor = UIColor.whiteColor;
        _refBtn.layer.borderWidth = 1;
        _refBtn.layer.borderColor = rgba(227, 230, 235, 1).CGColor;
        _refBtn.layer.cornerRadius = 4;
        _refBtn.layer.masksToBounds = YES;
        [_refBtn addTarget:self action:@selector(refBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _refBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _refBtn;
}

- (void)layoutSubviews{
    switch (self.viewDirection) {
        case NoNetworkView://无网络
        {
            self.noDataDesLabel.text = @"网络不给力，请检查网络设置";
            [self.noDataIMGV setImage:[UIImage imageNamed:@"数据加载失败"]];
        }
            break;
        case NoDatasView://暂无数据
        {
            self.noDataDesLabel.text = @"暂无数据";
            [self.noDataIMGV setImage:[UIImage imageNamed:@"暂无数据"]];

        }
            break;
        case NoHaveLocation://没有获取到位置信息
        {
            self.noDataDesLabel.text = @"需要您的位置信息,没有获取到您的位置信息";
            [self.noDataIMGV setImage:[UIImage imageNamed:@"暂无数据"]];

        }
            break;
        case NoLocationServiceOpen://没有开启定位服务
        {
            [_refBtn setTitle:@"点击去设置" forState:UIControlStateNormal];
            self.noDataDesLabel.text = @"需要您的位置信息,您没有开启定位服务";
            [self.noDataIMGV setImage:[UIImage imageNamed:@"暂无数据"]];
        }
             break;
        case NoWaybill://没有运单
        {
            self.noDataDesLabel.text = @"暂无运单";
            [self.noDataIMGV setImage:[UIImage imageNamed:@"暂无运单"]];
        }
             break;
        case NoMessage://没有消息
        {
            self.noDataDesLabel.text = @"暂无消息";
            [self.noDataIMGV setImage:[UIImage imageNamed:@"暂无消息"]];
        }
             break;
        case NoResponse://数据加载失败
        {
            self.noDataDesLabel.text = @"数据加载失败";
            [self.noDataIMGV setImage:[UIImage imageNamed:@"数据加载失败"]];
        }
             break;
        case Development://开发中
        {
            self.noDataDesLabel.text = @"功能开发中,敬请期待...";
            [self.noDataIMGV setImage:[UIImage imageNamed:@"开发中"]];
            
        }
            break;
            case NoMembershipcard://没有会员卡
            {
                self.noDataDesLabel.text = @"暂无适用会员卡, 如需开卡请到门店扫码开";
                [self.noDataIMGV setImage:[UIImage imageNamed:@"noCard"]];
                
            }
                break;
        default:
            break;
    }
}

- (void)refBtnClick{
    if(_block){
        _block();
    }
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
