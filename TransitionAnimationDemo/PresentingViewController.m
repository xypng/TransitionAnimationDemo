//
//  PresentingViewController.m
//  TransitionAnimationDemo
//
//  Created by XiaoYiPeng on 16/10/13.
//  Copyright © 2016年 XiaoYiPeng. All rights reserved.
//

#import "PresentingViewController.h"
#import "PresentedViewController.h"
#import "PresentEdgeTransitioningDelegate.h"

@interface PresentingViewController()

@property (nonatomic, strong) PresentedViewController *presentedVC;

@property (nonatomic, strong) PresentEdgeTransitioningDelegate *transitionDelegate;

/**
 *  手势起始的x位置
 */
@property (nonatomic, assign) CGFloat gestureBeginX;

@end

@implementation PresentingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.presentedVC = [[PresentedViewController alloc] init];
    self.transitionDelegate = [[PresentEdgeTransitioningDelegate alloc] initWithOffset:100 andDirection:Right];
    self.transitionDelegate.presentedVC = self.presentedVC;
    self.transitionDelegate.presentingVC = self;
    self.presentedVC.modalPresentationStyle = UIModalPresentationCustom;
    self.presentedVC.transitioningDelegate = self.transitionDelegate;

}

- (IBAction)present:(UIButton *)sender {
    [self presentViewController:self.presentedVC animated:YES completion:nil];
}

@end
