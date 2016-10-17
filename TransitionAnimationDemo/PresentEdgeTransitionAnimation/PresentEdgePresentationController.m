//
//  CustomPresentationController.m
//  TransitionAnimationDemo
//
//  Created by XiaoYiPeng on 16/10/14.
//  Copyright © 2016年 XiaoYiPeng. All rights reserved.
//

#import "PresentEdgePresentationController.h"

@interface PresentEdgePresentationController ()

@property (nonatomic, strong) UIView *dimmingView;

@end

@implementation PresentEdgePresentationController

- (void)presentationTransitionWillBegin {
    self.dimmingView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];;
    [self.containerView addSubview:self.dimmingView];
    self.dimmingView.bounds = self.containerView.bounds;
    self.dimmingView.center = self.containerView.center;
    self.dimmingView.alpha = 0.0;

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRecognizer:)];
    [self.dimmingView addGestureRecognizer:tap];

    [self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.dimmingView.alpha = 0.5;
        if (self.minification>0.0 && self.minification<1.0) {
            self.presentingViewController.view.transform = CGAffineTransformScale(self.presentingViewController.view.transform, self.minification, self.minification);
        }
    } completion:nil];
}

- (void)dismissalTransitionWillBegin {
    [self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.dimmingView.alpha = 0.0;
        if (self.minification>0.0 && self.minification<1.0) {
            self.presentingViewController.view.transform = CGAffineTransformIdentity;
        }
    } completion:nil];
}

- (void)tapRecognizer:(UITapGestureRecognizer *)gesture {
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
