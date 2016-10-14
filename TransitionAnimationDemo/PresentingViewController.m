//
//  PresentingViewController.m
//  TransitionAnimationDemo
//
//  Created by XiaoYiPeng on 16/10/13.
//  Copyright © 2016年 XiaoYiPeng. All rights reserved.
//

#import "PresentingViewController.h"
#import "PresentedViewController.h"

@implementation PresentingViewController

- (IBAction)present:(UIButton *)sender {
    PresentedViewController *presentedVC = [[PresentedViewController alloc] init];
    [self presentViewController:presentedVC animated:YES completion:nil];
}

@end
