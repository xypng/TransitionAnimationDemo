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

- (instancetype)initWithOffset:(CGFloat)offset andDirection:(Direction)direction;

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactiveTransition;

@end
