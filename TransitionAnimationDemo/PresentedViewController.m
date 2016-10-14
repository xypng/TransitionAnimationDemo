//
//  PresentedViewController.m
//  TransitionAnimationDemo
//
//  Created by XiaoYiPeng on 16/10/14.
//  Copyright © 2016年 XiaoYiPeng. All rights reserved.
//

#import "PresentedViewController.h"
#import "CustomTransitioningDelegate.h"

@interface PresentedViewController ()

@property (nonatomic, strong) CustomTransitioningDelegate *delegate;

@end

@implementation PresentedViewController

- (instancetype)init {
    self = [super init];
    if (self) {

        self.modalPresentationStyle = UIModalPresentationCustom;

        self.delegate = [[CustomTransitioningDelegate alloc] initWithOffset:100 andDirection:Right andMinification:0.95];
        self.transitioningDelegate = self.delegate;
    }
    return self;
}

- (IBAction)dismiss:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
