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

@end

@implementation CustomAnimatedTranstitioning

- (instancetype)initWithOffset:(CGFloat)offset andDirection:(Direction)direction {
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

    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    } else {
        //ios7
        fromView = fromVC.view;
        toView = toVC.view;
    }

    NSTimeInterval duration = [self transitionDuration:transitionContext];
    CGFloat translation;
    CGRect presentedViewFrame;
    CGAffineTransform presentedViewTransform = CGAffineTransformIdentity;

    switch (self.transigionDirection) {
        case Right:
        {
            translation = containerView.frame.size.width - self.offset;

            if (toVC.isBeingPresented) {
                toView.frame = CGRectMake(containerView.bounds.size.width, 0, translation, containerView.bounds.size.height);
                presentedViewTransform = CGAffineTransformMakeTranslation(-translation, 0);
                presentedViewFrame = CGRectMake(containerView.bounds.size.width-translation, 0, translation, containerView.bounds.size.height);
            }
            if (fromVC.isBeingDismissed) {
                presentedViewTransform = CGAffineTransformIdentity;
                presentedViewFrame = CGRectMake(containerView.bounds.size.width, 0, translation, containerView.bounds.size.height);
            }
        }
            break;
        case Left:
        {
            translation = containerView.frame.size.width - self.offset;

            if (toVC.isBeingPresented) {
                toView.frame = CGRectMake(-translation, 0, translation, containerView.bounds.size.height);
                presentedViewTransform = CGAffineTransformMakeTranslation(translation, 0);
                presentedViewFrame = CGRectMake(0, 0, translation, containerView.bounds.size.height);
            }
            if (fromVC.isBeingDismissed) {
                presentedViewTransform = CGAffineTransformIdentity;
                presentedViewFrame = CGRectMake(-translation, 0, translation, containerView.bounds.size.height);
            }
        }
            break;
        case Above:
        {
            translation = containerView.frame.size.height - self.offset;

            if (toVC.isBeingPresented) {
                toView.frame = CGRectMake(0, -translation, containerView.bounds.size.width, translation);
                presentedViewTransform = CGAffineTransformMakeTranslation(0, translation);
                presentedViewFrame = CGRectMake(0, 0, containerView.bounds.size.width, translation);
            }
            if (fromVC.isBeingDismissed) {
                presentedViewTransform = CGAffineTransformIdentity;
                presentedViewFrame = CGRectMake(0, -translation, containerView.bounds.size.width, translation);
            }
        }
            break;
        case Bottom:
        {
            translation = containerView.frame.size.height - self.offset;

            if (toVC.isBeingPresented) {
                toView.frame = CGRectMake(0,containerView.bounds.size.height, containerView.bounds.size.width, translation);
                presentedViewTransform = CGAffineTransformMakeTranslation(0, -translation);
                presentedViewFrame = CGRectMake(0, containerView.bounds.size.height-translation, containerView.bounds.size.width, translation);
            }
            if (fromVC.isBeingDismissed) {
                presentedViewTransform = CGAffineTransformIdentity;
                presentedViewFrame = CGRectMake(0, containerView.bounds.size.height, containerView.bounds.size.width, translation);
            }
        }
            break;
        default:
            break;
    }

    if (toVC.isBeingPresented) {

        //只有present时,toView才要加到containerView上, dismiss时不用
        [containerView addSubview:toView];

        [UIView animateWithDuration:duration animations:^{
            toView.transform = presentedViewTransform;
//            toView.frame = presentedViewFrame;
        } completion:^(BOOL finished) {
            BOOL isCancle = [transitionContext transitionWasCancelled];
            [transitionContext completeTransition:!isCancle];
        }];
    }
    if (fromVC.isBeingDismissed) {

        [UIView animateWithDuration:duration animations:^{
            fromView.transform = presentedViewTransform;
//            fromView.frame = presentedViewFrame;
        } completion:^(BOOL finished) {
            BOOL isCancle = [transitionContext transitionWasCancelled];
            [transitionContext completeTransition:!isCancle];
        }];
    }
}

@end
