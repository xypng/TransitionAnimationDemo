//
//  CustomPresentationController.m
//  TransitionAnimationDemo
//
//  Created by XiaoYiPeng on 16/10/14.
//  Copyright © 2016年 XiaoYiPeng. All rights reserved.
//

#import "CustomPresentationController.h"

@interface CustomPresentationController ()

@property (nonatomic, strong) UIView *dimmingView;

@property (nonatomic, assign) CGFloat gestureBeginX;

@end

@implementation CustomPresentationController

- (void)presentationTransitionWillBegin {
    self.dimmingView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];;
    [self.containerView addSubview:self.dimmingView];
    self.dimmingView.bounds = self.containerView.bounds;
    self.dimmingView.center = self.containerView.center;
    self.dimmingView.alpha = 0.0;

//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRecognizer:)];
//    [self.dimmingView addGestureRecognizer:tap];
//
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panRecognizer:)];
//    [self.presentedViewController.view addGestureRecognizer:pan];

    [self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.dimmingView.alpha = 0.5;
        if (self.minification>0.0) {
            self.presentingViewController.view.transform = CGAffineTransformScale(self.presentingViewController.view.transform, self.minification, self.minification);
        }
    } completion:nil];
}

- (void)dismissalTransitionWillBegin {
    [self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.dimmingView.alpha = 0.0;
        if (self.minification>0.0) {
            self.presentingViewController.view.transform = CGAffineTransformIdentity;
        }
    } completion:nil];
}

//- (void)tapRecognizer:(UITapGestureRecognizer *)gesture {
//    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
//}

//- (void)panRecognizer:(UIPanGestureRecognizer *)gesture {
//    CGFloat xOffset = [gesture translationInView:self.presentedViewController.view].x;
//    NSLog(@"%.2f", xOffset);
//    CGFloat percent = xOffset/((self.containerView.bounds.size.width-100)-self.gestureBeginX);
//    NSLog(@"percent: %.2f", percent);
//
//    switch (gesture.state) {
//        case UIGestureRecognizerStateBegan:
//        {
//            NSLog(@"BeginX: %.2f", [gesture locationInView:self.presentedViewController.view].x);
//            self.gestureBeginX = [gesture locationInView:self.presentedViewController.view].x;
//            [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
//        }
//            break;
//        case UIGestureRecognizerStateChanged:
//        {
//            [self.interactiveTransition updateInteractiveTransition:percent];
//        }
//            break;
//        case UIGestureRecognizerStateEnded:
//        case UIGestureRecognizerStateCancelled:
//        {
//            if (percent>0.5) {
//                [self.interactiveTransition finishInteractiveTransition];
//            } else {
//                [self.interactiveTransition cancelInteractiveTransition];
//            }
//        }
//            break;
//        default:
//            break;
//    }
//}

@end
