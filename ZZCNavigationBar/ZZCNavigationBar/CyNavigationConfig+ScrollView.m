//
//  CyNavigationConfig+ScrollView.m
//  ZZCNavigationBar
//
//  Created by zzc-20170215 on 2019/4/12.
//  Copyright © 2019 zzc-20170215. All rights reserved.
//

#import "CyNavigationConfig+ScrollView.h"
#import <objc/runtime.h>

@implementation CyNavigationConfig (ScrollView)

- (void)setStartStateModel:(CyNavigationBarStateModel *)startStateModel
{
    objc_setAssociatedObject(self, @selector(startStateModel), startStateModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CyNavigationBarStateModel *)startStateModel
{
    return objc_getAssociatedObject(self, @selector(startStateModel));
}

- (void)setEndStateModel:(CyNavigationBarStateModel *)endStateModel
{
    if (endStateModel && !self.startStateModel) {
        self.startStateModel = ({
            CyNavigationBarStateModel *model = [CyNavigationBarStateModel new];
            model.scrollOffset = 0;
            model;
        });
    }
    objc_setAssociatedObject(self, @selector(endStateModel), endStateModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CyNavigationBarStateModel *)endStateModel
{
    return objc_getAssociatedObject(self, @selector(endStateModel));
}

@end

@implementation CyNavigationBarStateModel



@end
