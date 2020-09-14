//
//  LXSearchBar.m
//  ZZC_Travel_iOS
//
//  Created by zzc-20170215 on 2017/10/25.
//  Copyright © 2017年 zzc-20170215. All rights reserved.
//

#import "LXSearchBar.h"
#import <Masonry/Masonry.h>

@interface LXSearchBar()
{
    UIView *_contentView;
}

@end

@implementation LXSearchBar

- (id)initWithType:(LXSearchBarType)type
{
    self = [super init];
    if (self)
    {
        self.bgView = [[UIView alloc] init];
        self.bgView.layer.cornerRadius = 15;
        self.bgView.layer.masksToBounds = YES;
        self.bgView.userInteractionEnabled = NO;
        
        [self addSubview:self.bgView];
        
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@30);
            make.edges.equalTo(@0);
        }];
        
//        _contentView = [[UIView alloc] init];
//        _contentView.userInteractionEnabled = NO;
//        [self addSubview:_contentView];
//        
//        _iconImageView = [[UIImageView alloc] init];
//        [_contentView addSubview:_iconImageView];
//        
//        
//        [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.top.bottom.equalTo(@0);
//            make.width.height.equalTo(@22);
//        }];
//        
//        _titleLabel = ({
//            UILabel *aLabel = [[UILabel alloc] init];
//            aLabel.font = [UIFont systemFontOfSize:14];
//            aLabel;
//        });
//        [_contentView addSubview:_titleLabel];
//        
//        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(_iconImageView.mas_right).offset(9);
//            make.centerY.equalTo(_iconImageView);
//            make.right.equalTo(@0);
//            make.width.equalTo(@150).priorityLow();
//        }];
//        
//        [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(@10);
//            make.centerY.equalTo(@0);
//            make.right.equalTo(@(-10));
//        }];
        if (LXSearchBarTypeMiddle == type)
        {
            self.bgView.backgroundColor = [UIColor whiteColor];
            self.bgView.alpha = 0.25;
            _iconImageView.image = [UIImage imageNamed:@"icon_search_white"];
            _titleLabel.textColor = [UIColor whiteColor];
  
        }else
        {
            _iconImageView.image = [UIImage imageNamed:@"icon_search"];
            self.bgView.backgroundColor = [UIColor orangeColor];
            _titleLabel.textColor = [UIColor blackColor];
        }
    }
    return self;
}

@end
