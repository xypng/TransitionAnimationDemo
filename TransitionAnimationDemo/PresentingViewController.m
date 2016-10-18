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

/**
 *  presentedView的transitioningDelegate
 */
@property (nonatomic, strong) PresentEdgeTransitioningDelegate *transitionDelegate;

@end

@implementation PresentingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.presentedVC = [[PresentedViewController alloc] init];
    self.transitionDelegate = [[PresentEdgeTransitioningDelegate alloc] initWithOffset:300 andDirection:Bottom];
    self.transitionDelegate.presentedVC = self.presentedVC;
    self.transitionDelegate.presentingVC = self;
    self.presentedVC.modalPresentationStyle = UIModalPresentationCustom;
    self.presentedVC.transitioningDelegate = self.transitionDelegate;

}

- (IBAction)present:(UIButton *)sender {
    [self presentViewController:self.presentedVC animated:YES completion:nil];
}

@end
