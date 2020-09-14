//
//  ZZCNavigationButton.m
//  ZZCNavigationBar
//
//  Created by zzc-20170215 on 2018/1/23.
//  Copyright © 2018年 zzc-20170215. All rights reserved.
//

#import "CyNavigationButton.h"
#import "CyNavigationConfig.h"
@implementation CyNavigationButton

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGRect aRec = CGRectMake(0, 0, ZZCNavigationButtonImageSize.width, ZZCNavigationButtonImageSize.height);
    if (self.imageSize.width > 0 || self.imageSize.height > 0)
    {
        aRec.size.width = self.imageSize.width > 0 ? self.imageSize.width : self.bounds.size.width;
        aRec.size.height = self.imageSize.height > 0 ? self.imageSize.height : self.bounds.size.height;
    }
    aRec.origin.x = (self.bounds.size.width - aRec.size.width) / 2;
    aRec.origin.y = (self.bounds.size.height - aRec.size.height) / 2;
    
    return aRec;
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    if (![self imageForState:UIControlStateHighlighted])
    {
        if (highlighted) {
            self.alpha = 0.5;
        }else
        {
            self.alpha = 1;
        }
    }
   
}

@end
