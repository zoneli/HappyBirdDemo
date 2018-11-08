//
//  SecondViewController.m
//  Demo
//
//  Created by lyz1 on 2018/11/8.
//  Copyright © 2018 lyz. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setNavLabelText:@"测试页"];
}


@end
