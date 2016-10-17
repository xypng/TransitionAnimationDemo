//
//  CustomTransitioningDelegate.h
//  TransitionAnimationDemo
//
//  Created by XiaoYiPeng on 16/10/13.
//  Copyright © 2016年 XiaoYiPeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomAnimatedTranstitioning.h"

@interface CustomTransitioningDelegate : NSObject <UIViewControllerTransitioningDelegate>

- (instancetype)initWithOffset:(CGFloat)offset andDirection:(EdgeDirection)direction;

@property (nonatomic, assign) CGFloat offset;

@property (nonatomic, assign) EdgeDirection transigionDirection;

@property (nonatomic, strong) UIViewController *presentingVC;

@property (nonatomic, strong) UIViewController *presentedVC;

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactiveTransition;

@end
