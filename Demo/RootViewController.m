//
//  RootViewController.m
//  Demo
//
//  Created by lyz1 on 2018/11/8.
//  Copyright © 2018 lyz. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (void)setNavLabelText:(NSString *)title {
    self.tabBarController.title = title;
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
