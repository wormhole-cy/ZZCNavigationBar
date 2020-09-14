//
//  ZZCNavigationUIFactory.m
//  ZZCNavigationBar
//
//  Created by Cyrus on 2019/12/18.
//  Copyright © 2019 zzc-20170215. All rights reserved.
//

#import "ZZCNavigationUIFactory.h"
#import "CyNavigationConfig.h"
#import "UIControl+ZZCBlocksKit.h"
#import "CyNavigationButton.h"
@implementation ZZCNavigationUIFactory

+ (UIBarButtonItem *)barButtonItemMoreStyleWithClickedBlock:(void(^)(UIButton *sender))clicked{
    UIImage *image = ZZC_NAV_BAR_MORE_IMG;
    CyNavigationButton *button = [CyNavigationButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    button.imageSize = CGSizeMake(32, 32);
    [button zzc_addEventHandler:clicked forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (UIBarButtonItem *)barButtonItemMoreRedDotStyleWithClickedBlock:(void(^)(UIButton *sender))clicked{
    UIImage *image = ZZC_NAV_BAR_MORE_REDDOT_IMG;
    CyNavigationButton *button = [CyNavigationButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    button.imageSize = CGSizeMake(32, 32);
    [button zzc_addEventHandler:clicked forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (UIBarButtonItem *)barButtonItemMoreWhiteStyleWithClickedBlock:(void(^)(UIButton *sender))clicked{
    UIImage *image = ZZC_NAV_BAR_MORE_WHITE_IMG;
    CyNavigationButton *button = [CyNavigationButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    button.imageSize = CGSizeMake(32, 32);
    [button zzc_addEventHandler:clicked forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}
+ (UIBarButtonItem *)barButtonItemMoreWhiteRedDotStyleWithClickedBlock:(void(^)(UIButton *sender))clicked{
    UIImage *image = ZZC_NAV_BAR_MORE_WHITE_REDDOT_IMG;
    CyNavigationButton *button = [CyNavigationButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    button.imageSize = CGSizeMake(32, 32);
    [button zzc_addEventHandler:clicked forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (UIBarButtonItem *)barButtonItemMoreWhiteGrayBgStyleWithClickedBlock:(void(^)(UIButton *sender))clicked{
    UIImage *image = ZZC_NAV_BAR_MORE_WHITE_GRAYBG_IMG;
    CyNavigationButton *button = [CyNavigationButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    button.imageSize = CGSizeMake(32, 32);
    [button zzc_addEventHandler:clicked forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}
+ (UIBarButtonItem *)barButtonItemMoreWhiteGrayBgRedDotStyleWithClickedBlock:(void(^)(UIButton *sender))clicked{
    UIImage *image = ZZC_NAV_BAR_MORE_WHITE_GRAYBG_REDDOT_IMG;
    CyNavigationButton *button = [CyNavigationButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    button.imageSize = CGSizeMake(32, 32);
    [button zzc_addEventHandler:clicked forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (UIBarButtonItem *)barButtonItemBackStyleWithClickedBlock:(void(^)(UIButton *sender))clicked{
    UIImage *image = ZZC_NAV_BAR_BACK_IMG;
    CyNavigationButton *button = [CyNavigationButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    button.imageSize = CGSizeMake(32, 32);
    [button zzc_addEventHandler:clicked forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}
+ (UIBarButtonItem *)barButtonItemBackWhiteStyleWithClickedBlock:(void(^)(UIButton *sender))clicked{
    UIImage *image = ZZC_NAV_BAR_BACK_WHITE_IMG;
    CyNavigationButton *button = [CyNavigationButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    button.imageSize = CGSizeMake(32, 32);
    [button zzc_addEventHandler:clicked forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (UIBarButtonItem *)barButtonItemBackWhiteGrayBgStyleWithClickedBlock:(void(^)(UIButton *sender))clicked{
    UIImage *image = ZZC_NAV_BAR_BACK_WHITE_GRATBG_IMG;
    CyNavigationButton *button = [CyNavigationButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    button.imageSize = CGSizeMake(32, 32);
    [button zzc_addEventHandler:clicked forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end
