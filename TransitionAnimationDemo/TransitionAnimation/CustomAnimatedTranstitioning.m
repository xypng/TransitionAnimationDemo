//
//  CustomAnimatedTranstitioning.m
//  TransitionAnimationDemo
//
//  Created by XiaoYiPeng on 16/10/13.
//  Copyright © 2016年 XiaoYiPeng. All rights reserved.
//

#import "CustomAnimatedTranstitioning.h"

@interface CustomAnimatedTranstitioning ()

@property (nonatomic, assign) CGFloat offset;

@property (nonatomic, assign) Direction transigionDirection;

@property (nonatomic, assign) CGFloat minification;

@property (nonatomic, strong) UIView *presentingSuperview;

@end

@implementation CustomAnimatedTranstitioning

- (instancetype)initWithOffset:(CGFloat)offset andDirection:(Direction)direction  {
    self = [super init];
    if (self) {
        _offset = offset;
        _transigionDirection = direction;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = [transitionContext containerView];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *fromView;
    UIView *toView;

//    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
    //custom时返回nil了
//        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
//        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
//    } else {
        //ios7
        fromView = fromVC.view;
        toView = toVC.view;
//    }

    NSTimeInterval duration = [self transitionDuration:transitionContext];
    CGFloat translation;
    CGAffineTransform presentedViewTransform = CGAffineTransformIdentity;

    switch (self.transigionDirection) {
        case Right:
        {
            translation = containerView.frame.size.width - self.offset;

            if (toVC.isBeingPresented) {
                toView.frame = CGRectMake(containerView.bounds.size.width, 0, translation, containerView.bounds.size.height);
                presentedViewTransform = CGAffineTransformMakeTranslation(-translation, 0);
            }
            if (fromVC.isBeingDismissed) {
                presentedViewTransform = CGAffineTransformIdentity;
            }
        }
            break;
        case Left:
        {
            translation = containerView.frame.size.width - self.offset;

            if (toVC.isBeingPresented) {
                toView.frame = CGRectMake(-translation, 0, translation, containerView.bounds.size.height);
                presentedViewTransform = CGAffineTransformMakeTranslation(translation, 0);
            }
            if (fromVC.isBeingDismissed) {
                presentedViewTransform = CGAffineTransformIdentity;
            }
        }
            break;
        case Above:
        {
            translation = containerView.frame.size.height - self.offset;

            if (toVC.isBeingPresented) {
                toView.frame = CGRectMake(0, -translation, containerView.bounds.size.width, translation);
                presentedViewTransform = CGAffineTransformMakeTranslation(0, translation);
            }
            if (fromVC.isBeingDismissed) {
                presentedViewTransform = CGAffineTransformIdentity;
            }
        }
            break;
        case Bottom:
        {
            translation = containerView.frame.size.height - self.offset;

            if (toVC.isBeingPresented) {
                toView.frame = CGRectMake(0,containerView.bounds.size.height, containerView.bounds.size.width, translation);
                presentedViewTransform = CGAffineTransformMakeTranslation(0, -translation);
            }
            if (fromVC.isBeingDismissed) {
                presentedViewTransform = CGAffineTransformIdentity;
            }
        }
            break;
        default:
            break;
    }

    if (toVC.isBeingPresented) {

        UIVisualEffectView *dimmingView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];;
        [containerView addSubview:dimmingView];
        dimmingView.bounds = containerView.bounds;
        dimmingView.center = containerView.center;
        dimmingView.alpha = 0.0;
        dimmingView.tag = 101;

        //只有present时,toView才要加到containerView上, dismiss时不用
        [containerView addSubview:toView];

        [UIView animateWithDuration:duration animations:^{

            dimmingView.alpha = 0.5;
            toView.transform = presentedViewTransform;

        } completion:^(BOOL finished) {

            BOOL isCancle = [transitionContext transitionWasCancelled];
            [transitionContext completeTransition:!isCancle];

        }];
    }
    if (fromVC.isBeingDismissed) {

        UIVisualEffectView *dimmingView = [containerView viewWithTag:101];

        [UIView animateWithDuration:duration animations:^{

            dimmingView.alpha = 0.0;
            fromView.transform = presentedViewTransform;

        } completion:^(BOOL finished) {

            BOOL isCancle = [transitionContext transitionWasCancelled];
            [transitionContext completeTransition:!isCancle];

        }];
    }
}

@end
