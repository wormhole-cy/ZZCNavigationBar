//
//  ViewController.m
//  ZZCNavigationBar
//
//  Created by zzc-20170215 on 2018/1/23.
//  Copyright © 2018年 zzc-20170215. All rights reserved.
//

#import "ViewController.h"
#import "TestViewController.h"
#import "CyNavigationControllerConfig.h"
#import "SearchViewController.h"
#import "UIViewController+CyNavigationBar.h"


@interface ViewController ()
{
    CyNavigationControllerConfig *_nc;
    id _obj;
}


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    ZZCNavigationBarHookViewControllerBlackList = @[@"TestViewController"];
    _nc = [CyNavigationControllerConfig new];
    _nc.barBottomView = [[UIView alloc] init];

    _obj = [NSObject new];
    
}
- (IBAction)action:(id)sender {
    
    TestViewController *vc = [[TestViewController alloc] init];
    
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
//    nvc.delegate = _obj;
    cy_registerNavigationController(nvc, _nc);


    nvc.modalPresentationStyle = UIModalPresentationFullScreen;
    
    [self presentViewController:nvc animated:YES completion:^{
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
