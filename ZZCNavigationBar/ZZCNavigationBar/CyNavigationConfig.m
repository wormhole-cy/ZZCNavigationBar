//
//  ZZCNavigationConfig.m
//  ZZCNavigationBar
//
//  Created by zzc-20170215 on 2018/1/24.
//  Copyright © 2018年 zzc-20170215. All rights reserved.
//

#import "CyNavigationConfig.h"
#import "CyNavigationButton.h"
#import "UIImage+CyNavBundle.h"
CGSize ZZCNavigationButtonImageSize;
CGFloat ZZCNavigationButtonContentSpace = 16;
CGFloat ZZCNavigationButtonContentEdge = 16;
NSString *ZZCNavigationLeftBackImageName;
NSString *ZZCNavigationLeftPressBackImageName;
NSDictionary *ZZCNavigationTitleAttributes;
CGFloat ZZCNavigationBarHeight;
BOOL ZZCNavigationHideNavigationBar = NO;
BOOL ZZCNavigationHidesBackButton = NO;
NSArray<NSString *> *ZZCNavigationBarHookViewControllerWhiteList;
NSArray<NSString *> *ZZCNavigationBarHookViewControllerBlackList;

@implementation CyNavigationConfig
@synthesize backBarButtonItem = _backBarButtonItem;
@synthesize backTopButtonItem = _backTopButtonItem;

- (void)dealloc
{
    NSLog(@"ZZCNavigationConfig dealloc");
}

- (id)init
{
    self = [super init];
    if (self)
    {
        if (CGSizeEqualToSize(ZZCNavigationButtonImageSize, CGSizeZero))
        {
            ZZCNavigationButtonImageSize = CGSizeMake(24, 24);
        }

        if (!ZZCNavigationTitleAttributes)
        {
            ZZCNavigationTitleAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:16], NSForegroundColorAttributeName : [UIColor blackColor]};
        }
        self.hideNavigationBar = ZZCNavigationHideNavigationBar;
        self.hidesBackButton = ZZCNavigationHidesBackButton;
    }
    return self;
}

- (UIImage *)autoGetBackImageN{
    if (_backImage) {
        return _backImage;
    }
    if (ZZCNavigationLeftBackImageName) {
        UIImage *img = [UIImage imageNamed:ZZCNavigationLeftBackImageName];
        if (img) {
            return img;
        }
    }
    return nil;
}

- (UIImage *)autoGetBackImageH{
    if (_backImage) {
        return _backImage;
    }
    if (ZZCNavigationLeftBackImageName) {
        UIImage *img = [UIImage imageNamed:ZZCNavigationLeftPressBackImageName];
        if (img) {
            return img;
        }
    }
    return [self autoGetBackImageN];
}

- (void)setBackImage:(UIImage *)backImage
{
    _backImage = backImage;
    if (backImage)
    {
        if (_backBarButtonItem)
        {
            CyNavigationButton *leftBackButton = _backBarButtonItem.customView;
            [leftBackButton setImage:_backImage forState:UIControlStateNormal];
            [leftBackButton setImage:nil forState:UIControlStateHighlighted];
        }
        
        if (_backTopButtonItem)
        {
            CyNavigationButton *leftBackButton = _backTopButtonItem.customView;
            [leftBackButton setImage:_backImage forState:UIControlStateNormal];
            [leftBackButton setImage:nil forState:UIControlStateHighlighted];
        }
    }
}

- (UIBarButtonItem *)backBarButtonItem
{
    if (!_backBarButtonItem)
    {
        
        CyNavigationButton *leftBackButton = ({
            CyNavigationButton *btn = [CyNavigationButton buttonWithType:UIButtonTypeCustom];
            UIImage *img_n = [self autoGetBackImageN];
            if (!img_n) {
                img_n = [UIImage cyNav_imageNamedFromMyBundle:@"icon_topbar_back"];
                btn.imageSize = CGSizeMake(32, 32);
            }else{
                UIImage *img_h = [self autoGetBackImageH];
                [btn setImage:img_h forState:UIControlStateHighlighted];
            }

            [btn setImage:img_n forState:UIControlStateNormal];
            
            btn;
        });
        
        _backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBackButton];
    }
    
    return _backBarButtonItem;
}

- (UIBarButtonItem *)backTopButtonItem
{
    if (!_backTopButtonItem)
    {
        CyNavigationButton *leftBackButton = ({
            CyNavigationButton *btn = [CyNavigationButton buttonWithType:UIButtonTypeCustom];
            UIImage *img_n = [self autoGetBackImageN];
            if (!img_n) {
                img_n = [UIImage cyNav_imageNamedFromMyBundle:@"icon_topbar_back"];
                btn.imageSize = CGSizeMake(32, 32);
            }else{
                UIImage *img_h = [self autoGetBackImageH];
                [btn setImage:img_h forState:UIControlStateHighlighted];
            }

            [btn setImage:img_n forState:UIControlStateNormal];
            btn;
        });
        
        _backTopButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBackButton];
        
    }
    return _backTopButtonItem;
}

- (void)setLeftBarButtonItems:(NSArray<UIBarButtonItem *> *)leftBarButtonItems
{
    if (_leftBarButtonItems == leftBarButtonItems)
    {
        return;
    }
    
    if ([self isHideUINavigationBar])
    {
        [_leftBarButtonItems.firstObject.customView.superview removeFromSuperview];
    }
    
    
    _leftBarButtonItems = leftBarButtonItems;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CyNavigationConfig" object:self userInfo:@{@"keyPath" : @"leftBarButtonItems"}];
}

- (void)setRightBarButtonItems:(NSArray<UIBarButtonItem *> *)rightBarButtonItems
{
    if (_rightBarButtonItems == rightBarButtonItems) {
        return;
    }
    
    if ([self isHideUINavigationBar])
    {
        [_rightBarButtonItems.lastObject.customView.superview removeFromSuperview];
    }
    
    
    _rightBarButtonItems = rightBarButtonItems;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CyNavigationConfig" object:self userInfo:@{@"keyPath" : @"rightBarButtonItems"}];
}

- (void)setLeftTopButtonItems:(NSArray<UIBarButtonItem *> *)leftTopButtonItems
{
    if (_leftTopButtonItems == leftTopButtonItems) {
        return;
    }
    
    
    if ([self isHideUINavigationBar])
    {
        [_leftTopButtonItems.firstObject.customView.superview removeFromSuperview];
    }
    
    _leftTopButtonItems = leftTopButtonItems;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CyNavigationConfig" object:self userInfo:@{@"keyPath" : @"leftTopButtonItems"}];
}

- (void)setRightTopButtonItems:(NSArray<UIBarButtonItem *> *)rightTopButtonItems
{
    if (_rightTopButtonItems == rightTopButtonItems) {
        return;
    }
    
    if ([self isHideUINavigationBar])
    {
        [_rightTopButtonItems.lastObject.customView.superview removeFromSuperview];
    }
    
    _rightTopButtonItems = rightTopButtonItems;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CyNavigationConfig" object:self userInfo:@{@"keyPath" : @"rightTopButtonItems"}];
}

- (void)setTitleItem:(CyNavigationTitleItem *)titleItem
{
    if (_titleItem == titleItem) {
        return;
    }
    
    [_titleItem.titleView removeFromSuperview];
    
    _titleItem = titleItem;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CyNavigationConfig" object:self userInfo:@{@"keyPath" : @"titleItem"}];
}


- (void)setTitle:(NSString *)title
{
    if ((title && ![title isKindOfClass:[NSString class]]) || (!title && !_title) || [_title isEqualToString:title]) {
        return;
    }
    _title = title;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CyNavigationConfig" object:self userInfo:@{@"keyPath" : @"title"}];
}

- (void)setHidesBackButton:(BOOL)hidesBackButton
{
    if (_hidesBackButton == hidesBackButton) {
        return;
    }
    
    _hidesBackButton = hidesBackButton;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CyNavigationConfig" object:self userInfo:@{@"keyPath" : @"hidesBackButton"}];
}

- (void)setHideNavigationBar:(BOOL)hideNavigationBar
{
    if (_hideNavigationBar == hideNavigationBar) {
        return;
    }
    if (hideNavigationBar)
    {
        self.customNavigationBar = YES;
    }
    _hideNavigationBar = hideNavigationBar;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CyNavigationConfig" object:self userInfo:@{@"keyPath" : @"hideNavigationBar"}];
}


- (void)setTitleAttributes:(NSDictionary *)titleAttributes
{
    if (_titleAttributes == titleAttributes) {
        return;
    }
    _titleAttributes = titleAttributes;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CyNavigationConfig" object:self userInfo:@{@"keyPath" : @"titleAttributes"}];
}

- (void)setCustomNavigationBar:(BOOL)customNavigationBar {
    if (_customNavigationBar == customNavigationBar)
    {
        return;
    }
    _customNavigationBar = customNavigationBar;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CyNavigationConfig" object:self userInfo:@{@"keyPath" : @"customNavigationBar"}];
}

- (void)setBackgroundView:(UIView *)backgroundView
{
    if (_backgroundView == backgroundView) {
        return;
    }
    _backgroundColor = nil;
    _backgroundImage = nil;
    
    _backgroundView = backgroundView;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CyNavigationConfig" object:self userInfo:@{@"keyPath" : @"backgroundView"}];
}

- (void)setBackgroundImage:(UIImage *)backgroundImage
{
    if (_backgroundImage == backgroundImage) {
        return;
    }
    _backgroundView = nil;
    _backgroundColor = nil;
    
    _backgroundImage = backgroundImage;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CyNavigationConfig" object:self userInfo:@{@"keyPath" : @"backgroundImage"}];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    if (_backgroundColor == backgroundColor) {
        return;
    }
    _backgroundImage = nil;
    _backgroundView = nil;
    
    _backgroundColor = backgroundColor;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CyNavigationConfig" object:self userInfo:@{@"keyPath" : @"backgroundColor"}];
}

- (void)setHideBarBottomLine:(BOOL)hideBarBottomLine
{
    if (_hideBarBottomLine == hideBarBottomLine) {
        return;
    }
    _hideBarBottomLine = hideBarBottomLine;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CyNavigationConfig" object:self userInfo:@{@"keyPath" : @"hideBarBottomLine"}];
}

- (BOOL)isHideUINavigationBar{
    return self.hideUINavigationBar || self.customNavigationBar || ZZCNavigationBarHeight > 0;
}

@end
