//
//  UIImage+CyNavBundle.m
//  ZZCNavigationBar
//
//  Created by Cyrus on 2020/5/15.
//  Copyright © 2020 zzc-20170215. All rights reserved.
//

#import "UIImage+CyNavBundle.h"
#import "ZZCNavigationBar.h"
@implementation UIImage (CyNavBundle)

+ (UIImage *)cyNav_imageNamedFromMyBundle:(NSString *)name {
    NSBundle *bundle = [NSBundle bundleForClass:[CyNavigationConfig class]];
    NSURL *url = [bundle URLForResource:@"ZZCNavigationBar" withExtension:@"bundle"];
    bundle = [NSBundle bundleWithURL:url];
    name = [name stringByAppendingString:@"@3x"];
    NSString *imagePath = [bundle pathForResource:name ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    if (!image) {
        // 兼容业务方自己设置图片的方式
        name = [name stringByReplacingOccurrencesOfString:@"@3x" withString:@""];
        image = [UIImage imageNamed:name];
    }
    return image;
}


@end
