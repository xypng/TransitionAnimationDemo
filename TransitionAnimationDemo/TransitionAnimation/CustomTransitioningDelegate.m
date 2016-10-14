//
//  CustomTransitioningDelegate.m
//  TransitionAnimationDemo
//
//  Created by XiaoYiPeng on 16/10/13.
//  Copyright © 2016年 XiaoYiPeng. All rights reserved.
//

#import "CustomTransitioningDelegate.h"

@interface CustomTransitioningDelegate ()

@property (nonatomic, assign) CGFloat offset;

@property (nonatomic, assign) Direction transigionDirection;

@end

@implementation CustomTransitioningDelegate

- (instancetype)initWithOffset:(CGFloat)offset andDirection:(Direction)direction {
    self = [super init];
    if (self) {
        _offset = offset;
        _transigionDirection = direction;
    }
    return self;
}


- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {

    return [[CustomAnimatedTranstitioning alloc] initWithOffset:self.offset andDirection:self.transigionDirection];

}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [[CustomAnimatedTranstitioning alloc] initWithOffset:self.offset andDirection:self.transigionDirection];
}

//- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator;
//
//- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator;

@end
