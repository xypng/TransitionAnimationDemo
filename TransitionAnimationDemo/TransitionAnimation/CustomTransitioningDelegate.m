//
//  CustomTransitioningDelegate.m
//  TransitionAnimationDemo
//
//  Created by XiaoYiPeng on 16/10/13.
//  Copyright © 2016年 XiaoYiPeng. All rights reserved.
//

#import "CustomTransitioningDelegate.h"
#import "CustomPresentationController.h"

@interface CustomTransitioningDelegate ()

@property (nonatomic, assign) CGFloat offset;

@property (nonatomic, assign) Direction transigionDirection;

/**
 *  缩小率
 */
@property (nonatomic, assign) CGFloat minification;

@property (nonatomic, strong) CustomPresentationController *presentation;

@end

@implementation CustomTransitioningDelegate

- (instancetype)initWithOffset:(CGFloat)offset andDirection:(Direction)direction andMinification:(CGFloat)minification {
    self = [super init];
    if (self) {
        _offset = offset;
        _transigionDirection = direction;
        _minification = minification;
    }
    return self;
}


- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {

    return [[CustomAnimatedTranstitioning alloc] initWithOffset:self.offset andDirection:self.transigionDirection];

}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [[CustomAnimatedTranstitioning alloc] initWithOffset:self.offset andDirection:self.transigionDirection];
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator {
    return self.interactiveTransition;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
    return self.interactiveTransition;
}

//- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source NS_AVAILABLE_IOS(8_0) {
//    self.presentation = [[CustomPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
//    self.presentation.minification = self.minification;
//    self.presentation.offset = self.offset;
//    return self.presentation;
//}

@end
