//
//  LXSearchBar.h
//  ZZC_Travel_iOS
//
//  Created by zzc-20170215 on 2017/10/25.
//  Copyright © 2017年 zzc-20170215. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LXSearchBarType)
{
    LXSearchBarTypeLeft = 0,
    LXSearchBarTypeMiddle,
};

@interface LXSearchBar : UIControl

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UILabel *titleLabel;

- (id)initWithType:(LXSearchBarType)type;



@end
