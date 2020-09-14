//
//  SearchViewController.m
//  ZZCNavigationBar
//
//  Created by zzc-20170215 on 2018/1/30.
//  Copyright © 2018年 zzc-20170215. All rights reserved.
//

#import "SearchViewController.h"
#import "CyNavigationButton.h"
#import "CyNavigationConfig.h"
#import "UIViewController+CyNavigationBar.h"
#import "LXSearchBar.h"
#import <Masonry/Masonry.h>
@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Do any additional setup after loading the view.
    

    self.navigationConfig.title = @"1234";
//    self.navigationConfig.customNavigationBar = YES;
//    self.navigationConfig.hideNavigationBar = YES;
    
    UIButton *test = [UIButton buttonWithType:UIButtonTypeCustom];
    [test setTitle:@"改变title" forState:UIControlStateNormal];
    test.titleLabel.font = [UIFont systemFontOfSize:10];
    [test setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [test addTarget:self action:@selector(leftChangeAct) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:test];
    
    [test mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(150));
        make.left.equalTo(@(10));
        make.width.height.equalTo(@(70));
    }];
    
//    self.navigationConfig.popGestureRecognizerClose = YES;
}

- (void)leftChangeAct
{
//    UIButton *test = [UIButton buttonWithType:UIButtonTypeCustom];
//    [test setTitle:@"改变title" forState:UIControlStateNormal];
//    test.titleLabel.font = [UIFont systemFontOfSize:10];
//    [test setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    ZZCNavigationTitleItem *title = [[ZZCNavigationTitleItem alloc] init];
//    title.isHorizontalCenter = YES;
//    title.customView = test;
//    self.navigationConfig.titleItem = title;
//
//
//    [test mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(@(0));
//        make.left.equalTo(@(0));
//        make.width.height.equalTo(@(44));
//    }];
    
//    self.navigationConfig.title = @"retgtrhg";
    
    self.navigationConfig.customNavigationBar = !self.navigationConfig.customNavigationBar;
//    if (self.navigationConfig.hidesBackButton) {
//        self.navigationConfig.hidesBackButton = NO;
//
//    }else
//    {
//        self.navigationConfig.hidesBackButton = YES;
//    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (UIUserInterfaceStyle)overrideUserInterfaceStyle
{
    // 使用深色模式
    return UIUserInterfaceStyleLight;
}

@end
