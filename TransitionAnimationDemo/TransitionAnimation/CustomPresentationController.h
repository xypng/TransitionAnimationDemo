//
//  CustomPresentationController.h
//  TransitionAnimationDemo
//
//  Created by XiaoYiPeng on 16/10/14.
//  Copyright © 2016年 XiaoYiPeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomPresentationController : UIPresentationController

@property (nonatomic, assign) CGFloat minification;

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactiveTransition;

@property (nonatomic, assign) CGFloat offset;

@end