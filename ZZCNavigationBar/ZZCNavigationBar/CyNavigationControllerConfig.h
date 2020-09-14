//
//  ZZCNavigationControllerConfig.h
//  ZZCNavigationBar
//
//  Created by zzc-20170215 on 2018/1/30.
//  Copyright © 2018年 zzc-20170215. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CyNavigationControllerConfig : NSObject<UINavigationControllerDelegate>

+ (instancetype)defaultConfig;

/**
 设置当前系统导航栏的背景样式
 */
@property (nonatomic, strong) UIView *barBackgroundView;
/**
 设置当前系统导航栏背景图片
 */
@property (nonatomic, strong) UIImage *barBackgroundImage;
/**
 设置当前系统导航栏背景颜色
 */
@property (nonatomic, strong) UIColor *barBackgroundColor;

/**
 自定义当前系统导航栏底部线条
 */
@property (nonatomic, strong) UIView *barBottomView;


- (void)updateNavigationController:(UINavigationController *)navigationController showViewController:(UIViewController *)viewController;

@end
