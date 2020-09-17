//
//  UIViewController+CyNavigationBar.m
//  ZZCNavigationBar
//
//  Created by zzc-20170215 on 2018/1/23.
//  Copyright © 2018年 zzc-20170215. All rights reserved.
//

#import "UIViewController+CyNavigationBar.h"
#import "CyNavigationButton.h"
#import <Masonry/Masonry.h>
#import <Aspects/Aspects.h>
#import <objc/runtime.h>
#import "NSObject+SXRuntime.h"
#import "CyNavigationControllerConfig.h"
#import "UINavigationItem+SXFixSpace.h"
static NSInteger vs_customBarContentViewTag = 201802010;

UIKIT_STATIC_INLINE CGFloat navigationButtonWidth()
{
    return ZZCNavigationButtonImageSize.width + 2 * MIN(ZZCNavigationButtonContentSpace/2, ZZCNavigationButtonContentEdge);
}

UIKIT_STATIC_INLINE CGFloat navigationButtonEdge()
{
    return MAX(0, ZZCNavigationButtonContentEdge - ZZCNavigationButtonContentSpace/2);
}

UIKIT_STATIC_INLINE CGFloat navigationButtonSpace()
{
    return MAX(0, ZZCNavigationButtonContentSpace - (navigationButtonWidth() - ZZCNavigationButtonImageSize.width));
}

@interface UIViewController()

@property (nonatomic, assign) BOOL vs_isAddOberver;

@property (nonatomic, strong) UILabel *vs_titleLabel;

@property (nonatomic, assign) NSInteger vs_leftBarWidth;

@property (nonatomic, assign) NSInteger vs_rightBarWidth;

@property (nonatomic, copy) NSNumber *vs_markScrollOffset;

@property (nonatomic, strong) NSMutableDictionary * vc_markNvcConfig;

@property (nonatomic, assign) BOOL vs_viewDidAppeared;

@property (nonatomic, strong) UIView *vs_customNavigationBar;

@end

@implementation UIViewController (CyNavigationBar)

- (BOOL)cy_isCustomNavigationBar
{
//    return self.navigationConfig.customNavigationBar || ZZCNavigationBarHeight > 0;
    return [self.navigationConfig isHideUINavigationBar];
}

- (UILabel *)vs_titleLabel
{
    return objc_getAssociatedObject(self, @selector(vs_titleLabel));
}

- (void)setVs_titleLabel:(UILabel *)vs_titleLabel
{
    objc_setAssociatedObject(self, @selector(vs_titleLabel), vs_titleLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setVc_statusBarStyle:(UIStatusBarStyle)statusBarStyle
{
    objc_setAssociatedObject(self, @selector(vc_statusBarStyle), @(statusBarStyle), OBJC_ASSOCIATION_COPY_NONATOMIC);
    if (self.vs_viewDidAppeared) {
        [[UIApplication sharedApplication] setStatusBarStyle:statusBarStyle];
    }
}

- (UIStatusBarStyle)vc_statusBarStyle
{
    id obj = objc_getAssociatedObject(self, @selector(vc_statusBarStyle));
    if (obj)
    {
        return [obj integerValue];
    }
    if (self.viewControllerConfig) {
        return self.viewControllerConfig.statusBarStyle;
    }
    return [UIApplication sharedApplication].statusBarStyle;
}

- (BOOL)vc_hasSetStatusBarStyle{
    id obj = objc_getAssociatedObject(self, @selector(vc_statusBarStyle));
    if (obj || self.viewControllerConfig) {
        return true;
    }
    return false;
}

- (CyNavigationConfig *)navigationConfig
{
    CyNavigationConfig *obj = objc_getAssociatedObject(self, @selector(navigationConfig));
    if (!obj) {
        BOOL needHook = YES;
        if (ZZCNavigationBarHookViewControllerBlackList.count > 0){
            if ([ZZCNavigationBarHookViewControllerBlackList containsObject:NSStringFromClass(self.class)]) {
                //黑名单存在，黑名单里面的不需要自动hook
                needHook = NO;
            }
        }else{
            if ([self isKindOfClass:[UINavigationController class]] || [self isKindOfClass:[UITabBarController class]]) {
                needHook = NO;
            }
        }
        if (needHook) {
            obj = [CyNavigationConfig new];
            objc_setAssociatedObject(self, @selector(navigationConfig), obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    return obj;
}

- (void)setNavigationConfig:(CyNavigationConfig *)navigationConfig{
    
}

- (CyViewControllerConfig *)viewControllerConfig
{
    CyViewControllerConfig *obj = objc_getAssociatedObject(self, @selector(viewControllerConfig));
    return obj;
}

- (void)setViewControllerConfig:(CyViewControllerConfig *)viewControllerConfig
{
    if (viewControllerConfig)
    {
        viewControllerConfig.statusBarStyle = [UIApplication sharedApplication].statusBarStyle;
    }
    
    objc_setAssociatedObject(self, @selector(viewControllerConfig), viewControllerConfig, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CyNavigationConfig *)_getNavigationConfig
{
    return objc_getAssociatedObject(self, @selector(navigationConfig));
}

- (UIView *)navigationBar
{
    if ([self cy_isCustomNavigationBar])
    {
        return objc_getAssociatedObject(self, @selector(navigationBar));
    }
    return self.navigationController.navigationBar;
}

- (UIView *)cy_navigationBarContentView
{
    return [self.navigationBar viewWithTag:vs_customBarContentViewTag];
}

- (BOOL)vs_isAddOberver
{
    return [objc_getAssociatedObject(self, @selector(vs_isAddOberver)) boolValue];
}

- (void)setVs_isAddOberver:(BOOL)vs_isAddOberver
{
    objc_setAssociatedObject(self, @selector(vs_isAddOberver), @(vs_isAddOberver), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (BOOL)vs_viewDidAppeared
{
    return [objc_getAssociatedObject(self, @selector(vs_viewDidAppeared)) boolValue];
}

- (void)setVs_viewDidAppeared:(BOOL)vs_viewDidAppeared
{
    objc_setAssociatedObject(self, @selector(vs_viewDidAppeared), @(vs_viewDidAppeared), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSInteger)vs_leftBarWidth
{
    return [objc_getAssociatedObject(self, @selector(vs_leftBarWidth)) integerValue];
}

- (void)setVs_leftBarWidth:(NSInteger)vs_leftBarWidth
{
    objc_setAssociatedObject(self, @selector(vs_leftBarWidth), @(vs_leftBarWidth), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSInteger)vs_rightBarWidth
{
    return [objc_getAssociatedObject(self, @selector(vs_rightBarWidth)) integerValue];
}

- (void)setVs_rightBarWidth:(NSInteger)vs_rightBarWidth
{
    objc_setAssociatedObject(self, @selector(vs_rightBarWidth), @(vs_rightBarWidth), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSNumber *)vs_markScrollOffset
{
    return objc_getAssociatedObject(self, @selector(vs_markScrollOffset));
}

- (void)setVs_markScrollOffset:(NSNumber *)vs_markScrollOffset {
    objc_setAssociatedObject(self, @selector(vs_markScrollOffset), vs_markScrollOffset, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (BOOL)vc_isInTopStack
{
    return [objc_getAssociatedObject(self, @selector(vc_isInTopStack)) boolValue];
}

- (void)setVc_isInTopStack:(BOOL)vc_isTopStack
{
    objc_setAssociatedObject(self, @selector(vc_isInTopStack), @(vc_isTopStack), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSMutableDictionary *)vc_markNvcConfig{
    return objc_getAssociatedObject(self, @selector(vc_markNvcConfig));
}

- (void)setVc_markNvcConfig:(NSMutableDictionary *)vc_markNvcConfig{
    objc_setAssociatedObject(self, @selector(vc_markNvcConfig), vc_markNvcConfig, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setVs_customNavigationBar:(UIView *)vs_customNavigationBar{
    objc_setAssociatedObject(self, @selector(vs_customNavigationBar), vs_customNavigationBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)vs_customNavigationBar{
    return objc_getAssociatedObject(self, @selector(vs_customNavigationBar));
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self sx_swizzleInstanceMethodWithOriginSel:@selector(init) swizzledSel:@selector(vn_init)];
        [self sx_swizzleInstanceMethodWithOriginSel:@selector(initWithCoder:) swizzledSel:@selector(vn_initWithCoder:)];
    });
    
}

- (id)vn_initWithCoder:(NSCoder *)coder {
    UIViewController *viewController = [self vn_initWithCoder:coder];
    [viewController vn_hook];
    return viewController;
}

- (id)vn_init
{
    UIViewController *viewController = [self vn_init];
    [viewController vn_hook];
    return viewController;
}


- (void)vn_hook {
    if ([self isKindOfClass:[UINavigationController class]] || [self isKindOfClass:[UITabBarController class]]) {
        return;
    }
    UIViewController *viewController = self;
    viewController.vs_leftBarWidth = 8;
    viewController.vs_rightBarWidth = 8;
    viewController.vc_isInTopStack = YES;
    [viewController aspect_hookSelector:@selector(loadView) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo) {
        UIViewController *vc = aspectInfo.instance;
        [vc cy_loadView];
    } error:nil];
    
    [viewController aspect_hookSelector:@selector(viewDidLoad) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo) {
        
        UIViewController *vc = aspectInfo.instance;
        [vc cy_afterViewDidLoad];
    } error:nil];
    
    [viewController aspect_hookSelector:@selector(viewWillAppear:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo) {
        
        UIViewController *vc = aspectInfo.instance;
        if (vc.navigationController && [vc.navigationController cy_isRegister]) {
            [vc vs_viewWillAppear];
        }
    } error:nil];
    
    [viewController aspect_hookSelector:@selector(viewWillDisappear:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo) {
        
        UIViewController *vc = aspectInfo.instance;
        if (vc.navigationController && [vc.navigationController cy_isRegister]) {
            [vc vs_viewWillDisappear];
        }
        
    } error:nil];
    
    [viewController aspect_hookSelector:@selector(viewDidAppear:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo) {
        
        UIViewController *vc = aspectInfo.instance;
        if (vc.navigationController && vc.navigationController.cyConfig && [vc _getNavigationConfig])
        {
//            if (vc.navigationController.navigationBar.hidden != [vc.navigationConfig isHideUINavigationBar]) {
//                [vc.navigationController setNavigationBarHidden:[vc.navigationConfig isHideUINavigationBar] animated:false];
//            }
            [vc.navigationController.cyConfig updateNavigationController:vc.navigationController showViewController:vc];
        }
        
    } error:nil];
    
    
    [viewController aspect_hookSelector:@selector(willMoveToParentViewController:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo){
        
        UIViewController *vc = aspectInfo.instance;
        [vc cy_willMoveToParentViewController:aspectInfo.arguments.firstObject];
        
    } error:nil];
    
    [viewController aspect_hookSelector:@selector(setTitle:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo){
        UIViewController *vc = aspectInfo.instance;
        if ([vc _getNavigationConfig] && [vc.navigationConfig.title isKindOfClass:[NSString class]] && [aspectInfo.arguments.firstObject isKindOfClass:[NSString class]] && ![vc.navigationConfig.title isEqualToString:aspectInfo.arguments.firstObject]) {
            vc.navigationConfig.title = aspectInfo.arguments.firstObject;
        }
    } error:nil];
    
}

- (void)cy_loadView{
    [self cy_afterViewLoad];
}

- (void)cy_afterViewLoad{
    if (self.navigationController) {
        [self cy_setupNavigationBarWithNavigationViewCobtroller:self.navigationController];
    }
}

- (void)cy_afterViewDidLoad
{
    if ([self vc_hasSetStatusBarStyle] && [UIApplication sharedApplication].statusBarStyle != self.vc_statusBarStyle) {
        [[UIApplication sharedApplication] setStatusBarStyle:self.vc_statusBarStyle];
    }
    if ([self.title isKindOfClass:[NSString class]] && self.title.length > 0 && [self _getNavigationConfig] && self.navigationConfig.title.length== 0) {
        self.navigationConfig.title = self.title;
    }
}

- (void)vs_viewWillAppear
{
    self.vs_viewDidAppeared = true;
    if (self.navigationController) {
        [self cy_setupNavigationBarWithNavigationViewCobtroller:self.navigationController];
    }
    if ([self _getNavigationConfig] && self.navigationController) {
         self.navigationItem.sx_IsHook = true;
        [self cy_updateNavigationBarItems];
    }
    
    if ([self vc_hasSetStatusBarStyle] && [UIApplication sharedApplication].statusBarStyle != self.vc_statusBarStyle) {
        [[UIApplication sharedApplication] setStatusBarStyle:self.vc_statusBarStyle];
    }
    
    if ([self.title isKindOfClass:[NSString class]] && self.title.length > 0 && [self _getNavigationConfig] && self.navigationConfig.title.length== 0) {
        self.navigationConfig.title = self.title;
    }
}

- (void)cy_willMoveToParentViewController:(UIViewController *)parent
{
    if (parent && ![parent isEqual:[NSNull null]])
    {
        if ([parent isKindOfClass:[UINavigationController class]])
        {
            UINavigationController *nvc = (UINavigationController *)parent;
            [self cy_setupNavigationBarWithNavigationViewCobtroller:nvc];
            
            NSInteger index = [nvc.viewControllers indexOfObject:self];
            if (index != NSNotFound)
            {
                if (index == 0)
                {
                    self.vc_isInTopStack = YES;
                }else if (index > 0) {
                    self.vc_isInTopStack = NO;
                }
            }else
            {
                self.vc_isInTopStack = nvc.viewControllers.lastObject.vc_isInTopStack;
            }
        }else if ([parent _getNavigationConfig] || parent.navigationController)
        {
            self.vc_isInTopStack = parent.vc_isInTopStack;
        }
        
        if (self.childViewControllers)
        {
            [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                obj.vc_isInTopStack = self.vc_isInTopStack;
                if (obj.childViewControllers) {
                    [obj.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        obj.vc_isInTopStack = self.vc_isInTopStack;
                    }];
                }
            }];
        }
    }
}


- (void)vs_viewWillDisappear
{
    self.vs_viewDidAppeared = false;
    if (self.vs_isAddOberver)
    {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"CyNavigationConfig" object:self.navigationConfig];
        self.vs_isAddOberver = NO;
    }
    if (self.vc_markNvcConfig.count > 0 && self.navigationController.delegate == [CyNavigationControllerConfig defaultConfig]) {
        self.navigationController.delegate = [self.vc_markNvcConfig objectForKey:@"vc_delegate"];
        
        self.navigationController.interactivePopGestureRecognizer.delegate = [self.vc_markNvcConfig objectForKey:@"gesture_delegate"];
        self.navigationController.navigationBar.translucent = [[self.vc_markNvcConfig objectForKey:@"translucent"] boolValue];
        [self.navigationController setNavigationBarHidden:[[self.vc_markNvcConfig objectForKey:@"barHidden"] boolValue] animated:NO];
//        objc_setAssociatedObject(self.navigationController, @selector(cy_isRegister), @(NO), OBJC_ASSOCIATION_COPY_NONATOMIC);
//        self.vc_markNvcConfig = nil;
    }
}


- (void)cy_createCustomBar
{
    UIView *bar = [[UIView alloc] init];
    bar.backgroundColor = [UIColor whiteColor];
    
    UIView *contentView = [[UIView alloc] init];
    contentView.tag = vs_customBarContentViewTag;
    [bar addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    self.vs_customNavigationBar = bar;
    objc_setAssociatedObject(self, @selector(navigationBar), bar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}



- (void)cy_updateCustomBarStyle
{
    UIView *aView = [self.navigationBar viewWithTag:688844];
    [aView removeFromSuperview];
    
    UIView *bView = [self.navigationBar viewWithTag:8777334];
    [bView removeFromSuperview];
    
    if (self.navigationConfig.backgroundView)
    {
        [self.navigationBar insertSubview:self.navigationConfig.backgroundView atIndex:0];
        self.navigationConfig.backgroundView.tag = 688844;
        [self.navigationConfig.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(@0);
        }];
    }else if (self.navigationConfig.backgroundImage)
    {
        UIImageView *bgImageView = [[UIImageView alloc] initWithImage:self.navigationConfig.backgroundImage];
        [self.navigationBar insertSubview:bgImageView atIndex:0];
        bgImageView.tag = 688844;
        [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(@0);
        }];
    }else if (self.navigationConfig.backgroundColor)
    {
        self.navigationBar.backgroundColor = self.navigationConfig.backgroundColor;
    }else
    {
        self.navigationBar.backgroundColor = self.navigationController.navigationBar.barTintColor;
        if (!self.navigationBar.backgroundColor) {
            self.navigationBar.backgroundColor = [UIColor whiteColor];
        }
    }
    
    if (!self.navigationConfig.hideBarBottomLine && self.navigationController.cyConfig.barBottomView) {
        UIView *bottomLine = [[UIView alloc] init];
        bottomLine.backgroundColor = self.navigationController.cyConfig.barBottomView.backgroundColor;
        [self.navigationBar addSubview:bottomLine];
        bottomLine.tag = 8777334;
        [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(@0);
            make.height.equalTo(@(self.navigationController.cyConfig.barBottomView.bounds.size.height));
        }];
    }
//    self.navigationBar.backgroundColor = [UIColor greenColor];
}


- (void)cy_setupNavigationBarWithNavigationViewCobtroller:(UINavigationController *)nvc{
    if (![nvc cy_isRegister] && ![self _getNavigationConfig]) {
        return;
    }
    if (![self _getNavigationConfig]) {
         [self navigationConfig];
     }
     

    if (![nvc cy_isRegister] || !self.navigationConfig) {
        if (!self.vc_markNvcConfig) {
            self.vc_markNvcConfig = [NSMutableDictionary dictionary];
            [self.vc_markNvcConfig setValue:nvc.delegate forKey:@"vc_delegate"];
            [self.vc_markNvcConfig setValue:nvc.interactivePopGestureRecognizer.delegate forKey:@"gesture_delegate"];
            [self.vc_markNvcConfig setValue:@(nvc.navigationBar.translucent) forKey:@"translucent"];
            [self.vc_markNvcConfig setValue:@(nvc.navigationBarHidden) forKey:@"barHidden"];
            cy_registerNavigationController(nvc, [CyNavigationControllerConfig defaultConfig]);
        }else{
            self.navigationController.delegate = [CyNavigationControllerConfig defaultConfig];
            self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self.navigationController;
            self.navigationController.navigationBar.translucent = NO;
            [self.navigationController setNavigationBarHidden:NO animated:NO];
            [[CyNavigationControllerConfig defaultConfig] updateNavigationController:self.navigationController showViewController:self];
        }
    }
    
     if ([self cy_isCustomNavigationBar] && self.isViewLoaded)
     {
         UIView *bar = objc_getAssociatedObject(self, @selector(navigationBar));
         if (!bar) {
             [self cy_createCustomBar];
             bar = self.navigationBar;
         }
         bar.hidden = self.navigationConfig.hideNavigationBar;
         [self cy_updateCustomBarStyle];
         [self.view addSubview:bar];
         [bar mas_makeConstraints:^(MASConstraintMaker *make) {
             make.left.top.right.equalTo(@0);
             make.height.equalTo(@(navigationBarHeight() + [UIApplication sharedApplication].statusBarFrame.size.height));
         }];
         
         if (self.vs_markScrollOffset) {
             [self cy_scrollToContentOffset:[self.vs_markScrollOffset floatValue]];
         }
     }
     
     if (self.vs_isAddOberver == 0) {
         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(vs_cyNavigationConfigChange:) name:@"CyNavigationConfig" object:self.navigationConfig];
         self.vs_isAddOberver = 1;
     }
}

- (void)cy_updateNavigationBarItems
{
    self.vs_customNavigationBar.hidden = ![self cy_isCustomNavigationBar];
    if ([self cy_isCustomNavigationBar])
    {
        self.navigationBar.hidden = self.navigationConfig.hideNavigationBar;
        [self.view bringSubviewToFront:self.navigationBar];
        
        [self cy_updateLeftTopBarButtonItems];
        [self cy_setRightBarButtonItem:self.navigationConfig.rightTopButtonItems isTopSuspending:true];
    }
    
    [self cy_updateLeftBarButtonItems];
    [self cy_updateRightBarButtonItems];
    [self cy_updateTitleItem];
    if (!self.navigationConfig.customNavigationBar) {
        //移除顶部按钮
        [self.navigationConfig.backTopButtonItem.customView.superview removeFromSuperview];
        [self.navigationConfig.leftTopButtonItems enumerateObjectsUsingBlock:^(UIBarButtonItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj.customView.superview removeFromSuperview];
        }];
        [self.navigationConfig.rightTopButtonItems enumerateObjectsUsingBlock:^(UIBarButtonItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj.customView.superview removeFromSuperview];
        }];
    }
}

- (void)cy_updateLeftBarButtonItems
{
    if (self.navigationConfig.leftBarButtonItems.count == 0)
    {
        if (!self.navigationConfig.hidesBackButton && !self.vc_isInTopStack && self.navigationConfig.backBarButtonItem)
        {
            [self cy_setLeftBarButtonItem:@[self.navigationConfig.backBarButtonItem]];
            
            CyNavigationButton *leftBackButton = self.navigationConfig.backBarButtonItem.customView;
            [leftBackButton addTarget:self action:@selector(leftBarButtonAct) forControlEvents:UIControlEventTouchUpInside];
            return;
        }
        
    }
    [self.navigationConfig.backBarButtonItem.customView.superview removeFromSuperview];
    [self cy_setLeftBarButtonItem:self.navigationConfig.leftBarButtonItems];
}

- (void)cy_updateLeftTopBarButtonItems
{
    if (!self.navigationConfig.customNavigationBar) {
        return;
    }
    if (self.navigationConfig.leftTopButtonItems.count == 0)
    {
        if (!self.navigationConfig.hidesBackButton && !self.vc_isInTopStack && self.navigationConfig.backTopButtonItem)
        {
            [self cy_setLeftBarButtonItem:@[self.navigationConfig.backTopButtonItem] isTopSuspending:true];
            
            CyNavigationButton *leftBackButton = self.navigationConfig.backTopButtonItem.customView;
            [leftBackButton addTarget:self action:@selector(leftBarButtonAct) forControlEvents:UIControlEventTouchUpInside];
            return;
        }
    }
    [self.navigationConfig.backTopButtonItem.customView.superview removeFromSuperview];
    [self cy_setLeftBarButtonItem:self.navigationConfig.leftTopButtonItems isTopSuspending:true];
}

- (void)cy_updateRightBarButtonItems
{
    [self cy_setRightBarButtonItem:self.navigationConfig.rightBarButtonItems];
}

- (void)cy_updateTitleItem
{
    if (self.navigationConfig.titleItem)
    {
        [self cy_setTitileViewWithItem:self.navigationConfig.titleItem];
    }else
    {
        if (!self.vs_titleLabel || !self.vs_titleLabel.superview.superview)
        {
            
            UILabel *titleLabel = ({
                UILabel *aLabel = [[UILabel alloc] init];
                aLabel.textAlignment = NSTextAlignmentCenter;
//                aLabel.backgroundColor = [UIColor purpleColor];
                aLabel;
            });
            CyNavigationTitleItem *item = [[CyNavigationTitleItem alloc] initWithCustomView:titleLabel
                                           ];
            item.isHorizontalCenter = YES;
            
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.greaterThanOrEqualTo(@(5));
                make.right.lessThanOrEqualTo(@(-5));
                make.center.equalTo(@(0));
            }];
            self.navigationConfig.defaultTitleItem = item;
            self.vs_titleLabel = titleLabel;
        }
        
        [self cy_setTitileViewWithItem:self.navigationConfig.defaultTitleItem];
        self.vs_titleLabel.text = self.navigationConfig.title;
        UIFont *font = [self.navigationConfig.titleAttributes objectForKey:NSFontAttributeName];
        if (font) {
            self.vs_titleLabel.font = font;
        }else
        {
            self.vs_titleLabel.font = [ZZCNavigationTitleAttributes objectForKey:NSFontAttributeName];
        }
        
        UIColor *color = [self.navigationConfig.titleAttributes objectForKey:NSForegroundColorAttributeName];
        if (color) {
            self.vs_titleLabel.textColor = color;
        }else
        {
            self.vs_titleLabel.textColor = [ZZCNavigationTitleAttributes objectForKey:NSForegroundColorAttributeName];
        }
    }
}


- (void)leftBarButtonAct
{
    if ([self _getNavigationConfig] && self.navigationConfig.backButtonAction) {
        self.navigationConfig.backButtonAction();
    }else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)cy_setTitileViewWithItem:(CyNavigationTitleItem *)item
{
    if (!item) {
        self.navigationItem.titleView = nil;
    }else
    {
        if ([self cy_isCustomNavigationBar])
        {
            [self.vs_titleLabel.superview removeFromSuperview];
//            [self cy_navigationBarContentView].backgroundColor = [UIColor purpleColor];
            [[self cy_navigationBarContentView] addSubview:item.titleView];
            if (item.isHorizontalCenter)
            {
                CGFloat maxW = MAX(self.vs_leftBarWidth, self.vs_rightBarWidth);
                [item.titleView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(@(maxW));
                    make.right.equalTo(@(-maxW));
                    make.height.equalTo(@(navigationBarHeight()));
                    make.bottom.equalTo(@0);
                }];
            }else
            {
                [item.titleView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(@(self.vs_leftBarWidth));
                    make.right.equalTo(@(-self.vs_rightBarWidth));
                    make.height.equalTo(@(navigationBarHeight()));
                    make.bottom.equalTo(@0);
                }];
            }
            item.titleView.markFrame = CGRectZero;
        }else
        {
            self.navigationItem.titleView = item.titleView;
            CGRect rect;
            if (item.isHorizontalCenter)
            {
                
                CGFloat maxW = MAX(self.vs_leftBarWidth, self.vs_rightBarWidth);
                
                rect = CGRectMake(maxW, 0, CGRectGetWidth(self.navigationController.view.bounds) - 2 * maxW, navigationBarHeight());
                
            }else
            {
                rect = CGRectMake(self.vs_leftBarWidth, 0, CGRectGetWidth(self.navigationController.view.bounds) - self.vs_leftBarWidth - self.vs_rightBarWidth, navigationBarHeight());
            }
            
            item.titleView.markFrame = rect;
            if ([[[UIDevice currentDevice] systemVersion] floatValue] < 11)
            {
                self.navigationItem.titleView.frame = rect;
                self.navigationItem.titleView.translatesAutoresizingMaskIntoConstraints = YES;
            }else{
                self.navigationItem.titleView.translatesAutoresizingMaskIntoConstraints = NO;
            }

        }
        
    }
}

- (void)cy_setLeftBarButtonItem:(NSArray<UIBarButtonItem *> *)leftBarButtonItems
{
    [self cy_setLeftBarButtonItem:leftBarButtonItems isTopSuspending:NO];
}

- (void)cy_setLeftBarButtonItem:(NSArray<UIBarButtonItem *> *)leftBarButtonItems isTopSuspending:(BOOL)suspend
{
    if (suspend && !self.navigationConfig.customNavigationBar)
    {
        return;
    }
    if (leftBarButtonItems.count > 0)
    {
        if (leftBarButtonItems.firstObject.customView.superview.superview) {
            [leftBarButtonItems.firstObject.customView.superview removeFromSuperview];
        }
        UIView *barView = [[UIView alloc] init];
//                barView.backgroundColor = [UIColor purpleColor];
        CGFloat w = navigationButtonEdge();
        UIView *tmpView = nil;
        
        for (NSInteger i = 0; i < leftBarButtonItems.count; i++)
        {
            UIBarButtonItem *obj = [leftBarButtonItems objectAtIndex:i];
            [barView addSubview:obj.customView];
            CGRect rect = CGRectMake(0, 0, obj.width > 0 ? obj.width : navigationButtonWidth(), navigationBarHeight());
            
            rect.origin.x = w;
            if (tmpView)
            {
                rect.origin.x += navigationButtonSpace();
            }
            obj.customView.frame = rect;
//            obj.customView.backgroundColor = [UIColor greenColor];
            tmpView = obj.customView;
            w = CGRectGetMaxX(rect);
        }
        self.vs_leftBarWidth = w;
        if ([self cy_isCustomNavigationBar])
        {
            if (suspend)
            {
                [self.view insertSubview:barView belowSubview:self.navigationBar];
            }else
            {
                [[self cy_navigationBarContentView] addSubview:barView];
            }
            
            [barView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@0);
                make.top.equalTo(@([UIApplication sharedApplication].statusBarFrame.size.height));
                make.height.equalTo(@(navigationBarHeight()));
                make.width.equalTo(@(w));
            }];
        }else
        {
            barView.frame = CGRectMake(0, 0, w, navigationBarHeight());
            self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:barView];
        }
    }else
    {
        if (self.navigationConfig.hidesBackButton)
        {
            self.vs_leftBarWidth = 8;
            
            [self.navigationConfig.backBarButtonItem.customView.superview removeFromSuperview];
            self.navigationItem.leftBarButtonItem = nil;
            self.navigationItem.hidesBackButton = true;
            if (suspend)
            {
                [self.navigationConfig.backTopButtonItem.customView.superview removeFromSuperview];
            }
        }
    }
}

- (void)cy_setRightBarButtonItem:(NSArray<UIBarButtonItem *> *)rightBarButtonItems
{
    [self cy_setRightBarButtonItem:rightBarButtonItems isTopSuspending:NO];
}

- (void)cy_setRightBarButtonItem:(NSArray<UIBarButtonItem *> *)rightBarButtonItems isTopSuspending:(BOOL)suspend
{
    if (suspend && !self.navigationConfig.customNavigationBar)
    {
        return;
    }
    if (rightBarButtonItems.count > 0)
    {
        if (rightBarButtonItems.firstObject.customView.superview.superview) {
            [rightBarButtonItems.firstObject.customView.superview removeFromSuperview];
        }
        UIView *barView = [[UIView alloc] init];
//        barView.backgroundColor = [UIColor purpleColor];
        CGFloat w = 0;
        UIView *tmpView = nil;
        
        for (NSInteger i = rightBarButtonItems.count - 1; i >= 0; i--)
        {
            UIBarButtonItem *obj = [rightBarButtonItems objectAtIndex:i];
            [barView addSubview:obj.customView];
            CGRect rect = CGRectMake(0, 0, obj.width > 0 ? obj.width : navigationButtonWidth(), navigationBarHeight());
            rect.origin.x = w;
            
            if (tmpView) {
                rect.origin.x += navigationButtonSpace();
            }
            obj.customView.frame = rect;
            tmpView = obj.customView;
            w = CGRectGetMaxX(rect);
        }
        w += navigationButtonEdge();
        self.vs_rightBarWidth = w;
        
        if ([self cy_isCustomNavigationBar])
        {
            if (suspend)
            {
                [self.view insertSubview:barView belowSubview:self.navigationBar];
            }else
            {
                [[self cy_navigationBarContentView] addSubview:barView];
            }
            
            [barView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(@0);
                make.top.equalTo(@([UIApplication sharedApplication].statusBarFrame.size.height));
                make.height.equalTo(@(navigationBarHeight()));
                make.width.equalTo(@(w));
            }];
        }else
        {
            barView.frame = CGRectMake(0, 0, w, navigationBarHeight());
            
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:barView];
        }
        
        
    }else
    {
        self.navigationItem.rightBarButtonItem = nil;
        self.vs_rightBarWidth = 8;
    }
}

- (void)vs_cyNavigationConfigChange:(NSNotification *)notification
{
    id object = notification.object;
    if ([self _getNavigationConfig] && object == self.navigationConfig)
    {
        NSString *keyPath = [notification.userInfo objectForKey:@"keyPath"];
        if ([keyPath isEqualToString:@"leftBarButtonItems"] || [keyPath isEqualToString:@"rightBarButtonItems"] || [keyPath isEqualToString:@"titleItem"] || [keyPath isEqualToString:@"title"] || [keyPath isEqualToString:@"hidesBackButton"]) {
            
            if (self.isViewLoaded)
            {
                if ([keyPath isEqualToString:@"leftBarButtonItems"]) {
                    [self cy_updateLeftBarButtonItems];
                }else if ([keyPath isEqualToString:@"rightBarButtonItems"])
                {
                    [self cy_updateRightBarButtonItems];
                } else if ([keyPath isEqualToString:@"hidesBackButton"] && self.navigationConfig.leftBarButtonItems.count == 0)
                {
                    [self cy_updateLeftBarButtonItems];
                    [self cy_updateLeftTopBarButtonItems];
                }
                
                if ([keyPath isEqualToString:@"title"] && self.navigationConfig.title) {
                    if (self.navigationConfig.titleItem == self.navigationConfig.loadStatusItem || self.navigationConfig.titleItem == self.navigationConfig.failStatusItem)
                    {
                        [self showNaigationBarTitleStatus];
                    }
                }
                [self cy_updateTitleItem];
            }
            
        }else if ([keyPath isEqualToString:@"leftTopButtonItems"])
        {
            if (self.isViewLoaded)
            {
                [self cy_updateLeftTopBarButtonItems];

            }
        }else if ([keyPath isEqualToString:@"rightTopButtonItems"])
        {
            if (self.isViewLoaded)
            {
                [self cy_setRightBarButtonItem:self.navigationConfig.rightTopButtonItems isTopSuspending:YES];
            }
        }else if ([keyPath isEqualToString:@"hideNavigationBar"])
        {
            if (self.isViewLoaded && [self cy_isCustomNavigationBar] && ![self.navigationBar isKindOfClass:[UINavigationController class]])
            {
                self.navigationBar.hidden = self.navigationConfig.hideNavigationBar;
            }
        }else if ([keyPath isEqualToString:@"backgroundView"] || [keyPath isEqualToString:@"backgroundImage"] || [keyPath isEqualToString:@"backgroundColor"] || [keyPath isEqualToString:@"hideBarBottomLine"])
        {
            if (self.isViewLoaded)
            {
                if (self.navigationController && self.navigationController.cyConfig)
                {
                    [self.navigationController.cyConfig updateNavigationController:self.navigationController showViewController:self];
                    if (![self.navigationBar isKindOfClass:[UINavigationBar class]]) {
                        [self cy_updateCustomBarStyle];
                    }
                }
            }
        }else if ([keyPath isEqualToString:@"titleAttributes"])
        {
            if (self.isViewLoaded)
            {
                self.vs_titleLabel.text = self.navigationConfig.title;
                UIFont *font = [self.navigationConfig.titleAttributes objectForKey:NSFontAttributeName];
                if (font) {
                    self.vs_titleLabel.font = font;
                }else
                {
                    self.vs_titleLabel.font = [ZZCNavigationTitleAttributes objectForKey:NSFontAttributeName];
                }
                
                UIColor *color = [self.navigationConfig.titleAttributes objectForKey:NSForegroundColorAttributeName];
                if (color) {
                    self.vs_titleLabel.textColor = color;
                }else
                {
                    self.vs_titleLabel.textColor = [ZZCNavigationTitleAttributes objectForKey:NSForegroundColorAttributeName];
                }
            }
        }else if ([keyPath isEqualToString:@"customNavigationBar"])
        {
            if (self.isViewLoaded)
            {
                if ([self.navigationController cy_isRegister]) {
                    [self.navigationController setNavigationBarHidden:[self.navigationConfig isHideUINavigationBar] animated:YES];
                    [self cy_setupNavigationBarWithNavigationViewCobtroller:self.navigationController];
                    [self cy_updateNavigationBarItems];
                }
            }
        }
    }
    
}

- (void)showNavigationBarLoadStatus
{
    if (![self _getNavigationConfig] || !self.navigationConfig.loadStatusItem)
    {
        return;
    }
    
    self.navigationConfig.titleItem = self.navigationConfig.loadStatusItem;
}

- (void)showNavigationBarFailStatus
{
    if (![self _getNavigationConfig] || !self.navigationConfig.failStatusItem)
    {
        return;
    }
    self.navigationConfig.titleItem = self.navigationConfig.failStatusItem;
}

- (void)showNaigationBarTitleStatus
{
    if (![self _getNavigationConfig]) {
        return;
    }
    self.navigationConfig.titleItem = nil;
}

- (void)removeNavigationBarLoadStatus
{
    if (![self _getNavigationConfig]) {
        return;
    }
    if (self.navigationConfig.titleItem == self.navigationConfig.loadStatusItem) {
        [self showNaigationBarTitleStatus];
    }
}

- (void)removeNavigationBarFailStatus
{
    if (![self _getNavigationConfig]) {
        return;
    }
    if (self.navigationConfig.titleItem == self.navigationConfig.failStatusItem) {
        [self showNaigationBarTitleStatus];
    }
}

- (void)cy_scrollToContentOffset:(CGFloat)offset
{
    if (![self _getNavigationConfig]) {
        return;
    }
    CyNavigationBarStateModel *start = self.navigationConfig.startStateModel;
    CyNavigationBarStateModel *end = self.navigationConfig.endStateModel;
    if (start && end && start.scrollOffset <= end.scrollOffset)
    {
        if ([self cy_isCustomNavigationBar])
        {
            if (!self.navigationBar)
            {
                //先记录
                self.vs_markScrollOffset = @(offset);
                return;
            }
            
            self.vs_markScrollOffset = nil;
            if (start.scrollOffset == end.scrollOffset) {
                if (offset <= start.scrollOffset) {
                    self.navigationBar.alpha = start.alpha;
                }else
                {
                    self.navigationBar.alpha = 1;
                }
            } else
            {
                if (offset >= start.scrollOffset && offset <= end.scrollOffset) {
                    
                    CGFloat value = (offset - start.scrollOffset) / (end.scrollOffset - start.scrollOffset);
                    CGFloat total = end.alpha - start.alpha;
                    if (total > 0)
                    {
                        self.navigationBar.alpha = total * value;
                    }
                }else if (offset < start.scrollOffset)
                {
                    self.navigationBar.alpha = 0;
                }else
                {
                    self.navigationBar.alpha = 1;
                }
            }
            if (self.navigationBar.alpha == 0) {
                self.navigationBar.hidden = YES;
            }else{
                self.navigationBar.hidden = NO;
            }
        }
    }
}

CGFloat navigationBarHeight(void)
{
    if (ZZCNavigationBarHeight > 0) {
        return ZZCNavigationBarHeight;
    }
    
    return 44;
}



@end


@interface UINavigationController()<UIGestureRecognizerDelegate>



@end

@implementation UINavigationController (CyNavigationBar)

- (void)setCyConfig:(CyNavigationControllerConfig *)config
{
    self.delegate = config;
}

- (CyNavigationControllerConfig *)cyConfig
{
    if ([self.delegate isKindOfClass:[CyNavigationControllerConfig class]])
    {
        return self.delegate;
    }
    return nil;
}

- (void)cy_hookNavigationController
{
    [self us_viewDidLoad];
}


- (UIView *)cyBottomLineView
{
    return objc_getAssociatedObject(self, @selector(cyBottomLineView));
}

-(void)us_viewDidLoad {
    
    self.interactivePopGestureRecognizer.delegate = self;
    self.navigationBar.translucent = NO;
    objc_setAssociatedObject(self, @selector(cy_isRegister), @(true), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

/**
 全屏滑动返回判断
 
 @param gestureRecognizer 手势
 @return 是否响应
 */
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    if (self.topViewController.navigationConfig.popGestureRecognizerClose)
    {
        return NO;
    }
    return (self.childViewControllers.count != 1);
}

//修复有水平方向滚动的ScrollView时边缘返回手势失效的问题
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return true;
}

- (BOOL)cy_isRegister
{
    id obj = objc_getAssociatedObject(self, @selector(cy_isRegister));
    if (obj && [obj isKindOfClass:[NSNumber class]])
    {
        return [obj boolValue];
    }
    return false;
}


@end

 void cy_registerNavigationController(UINavigationController *nvc, CyNavigationControllerConfig *delgate)
{
    nvc.cyConfig = delgate;
    [nvc cy_hookNavigationController];
    [nvc aspect_hookSelector:@selector(pushViewController:animated:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo) {
        UINavigationController *vc = aspectInfo.instance;
        UIViewController *toVC = aspectInfo.arguments.firstObject;
        if (vc.childViewControllers.count == 1 && toVC && [toVC isKindOfClass:[UIViewController class]]) {
            toVC.hidesBottomBarWhenPushed = YES;
        }
    } error:nil];
    [nvc aspect_hookSelector:@selector(setViewControllers:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo) {
        NSArray<UIViewController *> *toVCs = aspectInfo.arguments.firstObject;
        if (toVCs && [toVCs isKindOfClass:[NSArray class]] && toVCs.count > 1) {
            toVCs.lastObject.hidesBottomBarWhenPushed = YES;
        }
    } error:nil];
    
    [nvc aspect_hookSelector:@selector(setViewControllers:animated:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo) {
        NSArray<UIViewController *> *toVCs = aspectInfo.arguments.firstObject;
        if (toVCs && [toVCs isKindOfClass:[NSArray class]] && toVCs.count > 1) {
            toVCs.lastObject.hidesBottomBarWhenPushed = YES;
        }
    } error:nil];
}
