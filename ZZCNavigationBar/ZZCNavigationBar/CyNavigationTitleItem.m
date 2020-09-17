//
//  ZZCNavigationTitleItem.m
//  ZZCNavigationBar
//
//  Created by zzc-20170215 on 2018/1/25.
//  Copyright © 2018年 zzc-20170215. All rights reserved.
//

#import "CyNavigationTitleItem.h"
#import <Masonry/Masonry.h>

@implementation CyNavigationTitleItem

- (id)initWithCustomView:(UIView *)customView
{
    self = [super init];
    if (self)
    {
        _customView = customView;
        if (customView)
        {
            CyNavigationTitleView *aView = [[CyNavigationTitleView alloc] init];
            [aView addSubview:customView];
            _titleView = aView;
        }
    }
    return self;
}

- (id)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)setCustomView:(UIView *)customView{
    if (_customView) {
        return;
    }
    //为了兼容旧版本，新版本请使用initWithCustomView
    _customView = customView;
    if (customView)
    {
        CyNavigationTitleView *aView = [[CyNavigationTitleView alloc] init];
        [aView addSubview:customView];
        
        _titleView = aView;
    }
}

@end


@interface CyNavigationTitleView()



@end

@implementation CyNavigationTitleView

- (void)setFrame:(CGRect)frame{
    if (self.markFrame.size.width > 0 && [[[UIDevice currentDevice] systemVersion] floatValue] < 11) {
        [super setFrame:self.markFrame];
        return;
    }
    [super setFrame:frame];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
//    self.backgroundColor = [UIColor greenColor];
    if (self.markFrame.size.width == 0) return;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 11) {
        
    }else{
        [self setupLayoutForLargeIos11];
    }
}

- (void)setupLayoutForLargeIos11{
    UIView *view = self;
    if ([self.superview.superview.superview isKindOfClass:[UINavigationBar class]]) {
        view = self.superview;
    }
    if (self.applied && CGRectEqualToRect(view.frame, self.markFrame)) {
        return;
    }
//    NSLog(@"%@", view);
//    view.backgroundColor = [UIColor blueColor];
    for (NSLayoutConstraint *constraint in view.superview.constraints){
        if (constraint.firstItem == view) {
//            NSLog(@"%@", constraint);
            [view.superview removeConstraint:constraint];
        }
    }

    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeLeft multiplier:1 constant:self.markFrame.origin.x];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeTop multiplier:1 constant:self.markFrame.origin.y];
    [view.superview addConstraints:@[left, top]];

    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:self.markFrame.size.width];
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:self.markFrame.size.height];
    [view addConstraints:@[width, height]];
    
    if (self != view) {
        for (NSLayoutConstraint *constraint in self.superview.constraints){
            if (constraint.firstItem == self) {
//                NSLog(@"%@", constraint);
                [self.superview removeConstraint:constraint];
            }
        }
        
        left = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
        top = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeTop multiplier:1 constant:0];
        width = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:self.markFrame.size.width];
        height = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:self.markFrame.size.height];
        [self.superview addConstraints:@[left, top]];
        [self addConstraints:@[width, height]];
    }
    self.applied = YES;
}

@end
