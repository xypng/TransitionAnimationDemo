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

/**
 *  从代理传过来的负责交互对象，手势的时候更新
 */
//@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactiveTransition;

@end
