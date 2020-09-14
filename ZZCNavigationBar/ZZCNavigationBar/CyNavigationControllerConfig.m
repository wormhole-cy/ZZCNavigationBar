//
//  ZZCNavigationControllerConfig.m
//  ZZCNavigationBar
//
//  Created by zzc-20170215 on 2018/1/30.
//  Copyright © 2018年 zzc-20170215. All rights reserved.
//

#import "CyNavigationControllerConfig.h"
#import "UIViewController+CyNavigationBar.h"
#import <Masonry/Masonry.h>

@interface CyNavigationControllerConfig ()

@property (nonatomic, strong) UIView *cyBarCurrentBgView;

@property (nonatomic, strong) UIImage *cyCurrentImage;


@end

@implementation CyNavigationControllerConfig

+ (instancetype)defaultConfig{
    static CyNavigationControllerConfig *obj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [CyNavigationControllerConfig new];
    });
    return obj;
}

- (void)setBarBackgroundView:(UIView *)barBackgroundView
{
    _barBackgroundColor = nil;
    _barBackgroundImage = nil;
    _barBackgroundView = barBackgroundView;
}

- (void)setBarBackgroundColor:(UIColor *)barBackgroundColor
{
    _barBackgroundImage = nil;
    _barBackgroundView = nil;
    _barBackgroundColor = barBackgroundColor;
}

- (void)setBarBackgroundImage:(UIImage *)barBackgroundImage
{
    _barBackgroundColor = nil;
    _barBackgroundView = nil;
    _barBackgroundImage = barBackgroundImage;
}

- (void)setBarBottomView:(UIView *)barBottomView
{
    if (_barBottomView == barBottomView) {
        return;
    }
    
    [_barBottomView removeFromSuperview];
    _barBottomView = barBottomView;
}

- (void)setCyBarCurrentBgView:(UIView *)cyBarCurrentBgView
{
    if (_cyBarCurrentBgView == cyBarCurrentBgView)
    {
        return;
    }
    [_cyBarCurrentBgView removeFromSuperview];
    _cyBarCurrentBgView = cyBarCurrentBgView;
}

- (void)updateNavigationController:(UINavigationController *)navigationController showViewController:(UIViewController *)viewController
{
    if (![navigationController cy_isRegister] || !viewController.navigationConfig) {
        if (navigationController.navigationBar.shadowImage) {
            [navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
            navigationController.navigationBar.shadowImage = nil;
        }
        return;
    }
    if ([viewController.navigationBar isKindOfClass:[UINavigationBar class]]) {
        CGRect aRec = navigationController.navigationBar.bounds;
        aRec.size.height += [UIApplication sharedApplication].statusBarFrame.size.height;
        
        UIView *cutomView = nil;
        UIColor *cutomColor = nil;
        if (viewController.navigationConfig.backgroundView) {
            //优先自定义视图
            cutomView = viewController.navigationConfig.backgroundView;
            
        } else if (viewController.navigationConfig.backgroundImage) {
            //自定义图片
            UIImageView *bgImageView = [[UIImageView alloc] initWithImage:viewController.navigationConfig.backgroundImage];
            cutomView = bgImageView;
        } else if (viewController.navigationConfig.backgroundColor) {
            cutomColor = viewController.navigationConfig.backgroundColor;
        } else if (self.barBackgroundView && self.cyBarCurrentBgView != self.barBackgroundView) {
            cutomView = self.barBackgroundView;
        } else if (self.barBackgroundImage && self.cyCurrentImage != self.barBackgroundImage) {
            self.cyCurrentImage = self.barBackgroundImage;
            UIImageView *bgImageView = [[UIImageView alloc] initWithImage:self.barBackgroundImage];
            cutomView = bgImageView;
        } else if (self.barBackgroundColor) {
            cutomColor = self.barBackgroundColor;
        }
        cutomView.frame = aRec;
        self.cyBarCurrentBgView = cutomView;
        if (cutomView)
        {
            [navigationController.navigationBar.subviews.firstObject addSubview:cutomView];
        }
        navigationController.navigationBar.barTintColor = cutomColor;
        
        if (self.barBottomView)
        {
            self.barBottomView.hidden = viewController.navigationConfig.hideBarBottomLine;
            if (!navigationController.navigationBar.shadowImage) {
                [navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
                navigationController.navigationBar.shadowImage = [UIImage new];
            }
            
            CGRect aRec = self.barBottomView.frame;
            aRec.origin.y = CGRectGetHeight(navigationController.navigationBar.bounds) - aRec.size.height;
            aRec.size.width = CGRectGetWidth(navigationController.navigationBar.bounds);
            self.barBottomView.frame = aRec;
            self.barBottomView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
            [navigationController.navigationBar addSubview:self.barBottomView];
        }else
        {
            if (navigationController.navigationBar.shadowImage) {
                [navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
                navigationController.navigationBar.shadowImage = nil;
            }
        }
    }
    
}


- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([navigationController cy_isRegister] && viewController.navigationConfig) {
        [navigationController setNavigationBarHidden:[viewController.navigationConfig isHideUINavigationBar] animated:animated];
        [self updateNavigationController:navigationController showViewController:viewController];
    }
    
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([navigationController cy_isRegister] && viewController.navigationConfig) {
        [navigationController setNavigationBarHidden:[viewController.navigationConfig isHideUINavigationBar] animated:animated];
        [self updateNavigationController:navigationController showViewController:viewController];
    }

}

@end
