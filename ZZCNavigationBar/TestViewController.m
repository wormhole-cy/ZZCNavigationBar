//
//  TestViewController.m
//  ZZCNavigationBar
//
//  Created by zzc-20170215 on 2018/1/23.
//  Copyright © 2018年 zzc-20170215. All rights reserved.
//

#import "TestViewController.h"
#import "ZZCNavigationBar.h"
#import "SearchViewController.h"
#import <Masonry/Masonry.h>
#import <Aspects/Aspects.h>

@interface TestViewController ()

@end

@implementation TestViewController

- (void)dealloc
{
    NSLog(@"TestViewController dealloc");
}

- (id)init
{
    self = [super init];
    if (self)
    {

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor orangeColor];
//    self.viewControllerConfig.statusBarStyle = UIStatusBarStyleLightContent;

    self.title = @"我的美国之旅我的美国之旅我的美国之旅我的美国之旅我的美国之旅我的美国之旅我的美国之旅";
//    self.navigationConfig.customNavigationBar = YES;
//    self.navigationBar.hidden = YES;

    self.navigationConfig.backgroundColor = [UIColor redColor];
    if (self.navigationController.viewControllers.count % 2) {
        self.navigationConfig.leftBarButtonItems = @[[ZZCNavigationUIFactory barButtonItemBackStyleWithClickedBlock:^(UIButton * _Nonnull sender) {
            
        }], [ZZCNavigationUIFactory barButtonItemBackWhiteStyleWithClickedBlock:^(UIButton * _Nonnull sender) {
            
        }], [ZZCNavigationUIFactory barButtonItemBackWhiteGrayBgStyleWithClickedBlock:^(UIButton * _Nonnull sender) {
            
        }]];
        self.navigationConfig.rightBarButtonItems = @[[ZZCNavigationUIFactory barButtonItemMoreStyleWithClickedBlock:^(UIButton * _Nonnull sender) {
            
        }], [ZZCNavigationUIFactory barButtonItemMoreRedDotStyleWithClickedBlock:^(UIButton * _Nonnull sender) {
            
        }], [ZZCNavigationUIFactory barButtonItemMoreWhiteStyleWithClickedBlock:^(UIButton * _Nonnull sender) {
            
        }]];
    }else
    {
        
        
//        self.navigationConfig.rightBarButtonItems = @[[[UIBarButtonItem alloc] initWithCustomView:moreButton], [[UIBarButtonItem alloc] initWithCustomView:moreButton1]];
////        self.navigationConfig.hideNavigationBar = YES;
//        self.navigationConfig.customNavigationBar = YES;
//        self.navigationBar.alpha = 0;
    }
    
    
//    if (self.navigationController.viewControllers.count % 2) {
//        UIButton *moreButton = [CyNavigationButton buttonWithType:UIButtonTypeCustom];
//        //        moreButton.imageView.backgroundColor = [UIColor redColor];
//        //        moreButton.backgroundColor = [UIColor orangeColor];
//        [moreButton setImage:[UIImage imageNamed:@"nav_more"] forState:UIControlStateNormal];
//        [moreButton addTarget:self action:@selector(okVC) forControlEvents:UIControlEventTouchUpInside];
//        self.navigationConfig.rightTopButtonItems = @[[[UIBarButtonItem alloc] initWithCustomView:moreButton]];
//    }else
//    {
//        UIButton *moreButton = [CyNavigationButton buttonWithType:UIButtonTypeCustom];
//        //        moreButton.imageView.backgroundColor = [UIColor redColor];
//        //        moreButton.backgroundColor = [UIColor orangeColor];
//        [moreButton setImage:[UIImage imageNamed:@"nav_more"] forState:UIControlStateNormal];
//        [moreButton addTargetself action:@selector(nextVC) forControlEvents:UIControlEventTouchUpInside];
//        
//        UIButton *moreButton1 = [CyNavigationButton buttonWithType:UIButtonTypeCustom];
//        //        moreButton1.imageView.backgroundColor = [UIColor redColor];
//        //        moreButton1.backgroundColor = [UIColor orangeColor];
//        [moreButton1 setImage:[UIImage imageNamed:@"nav_share"] forState:UIControlStateNormal];
//        [moreButton1 addTarget:self action:@selector(nextVC) forControlEvents:UIControlEventTouchUpInside];
//        
//        self.navigationConfig.rightTopButtonItems = @[[[UIBarButtonItem alloc] initWithCustomView:moreButton], [[UIBarButtonItem alloc] initWithCustomView:moreButton1]];
//        
//    }
//    UIView *titleView = [[UIView alloc] init];
//    titleView.backgroundColor = [UIColor redColor];
//    titleView.frame = CGRectMake(0, 0, 500, 44);
//    self.navigationItem.titleView = titleView;
    
    
    UIButton *test = [UIButton buttonWithType:UIButtonTypeCustom];
    [test setTitle:@"改变左边按钮" forState:UIControlStateNormal];
    test.titleLabel.font = [UIFont systemFontOfSize:10];
    [test setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [test addTarget:self action:@selector(leftChangeAct) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:test];
    
    [test mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(150));
        make.left.equalTo(@(10));
        make.width.height.equalTo(@(70));
    }];
    
    self.extendedLayoutIncludesOpaqueBars = true;
    NSLog(@"%@", self.navigationBar);
//    self.navigationBar.hidden = YES;
    
//    self.navigationBar.backgroundColor = [UIColor yellowColor];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}


- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
}

- (void)leftChangeAct
{
//    self.navigationConfig.hidesBackButton = YES;
    
//    UIButton *moreButton = [CyNavigationButton buttonWithType:UIButtonTypeCustom];
//    //        moreButton.imageView.backgroundColor = [UIColor redColor];
//    //        moreButton.backgroundColor = [UIColor orangeColor];
//    [moreButton setImage:[UIImage imageNamed:@"nav_edit"] forState:UIControlStateNormal];
//    [moreButton addTarget:self action:@selector(nextVC) forControlEvents:UIControlEventTouchUpInside];
//
//    self.navigationConfig.leftBarButtonItems = @[[[UIBarButtonItem alloc] initWithCustomView:moreButton]];

     SearchViewController *vc = [[SearchViewController alloc] init];
    //    [vc view];
        NSMutableArray *ary = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
        [ary addObject:vc];
        
        [self.navigationController setViewControllers:ary animated:YES];
}

- (void)okVC
{
//    TestViewController *vc = [[TestViewController alloc] init];
//    [vc view];
//    [self.navigationController pushViewController:vc animated:YES];
//    self.navigationConfig.tintColor = [UIColor orangeColor];
    

}

- (void)nextVC
{
    SearchViewController *vc = [[SearchViewController alloc] init];
//    [vc view];
    NSMutableArray *ary = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    [ary addObject:vc];
    
    [self.navigationController setViewControllers:ary animated:YES];
    
    

//    [self.navigationController pushViewController:vc animated:YES];
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
