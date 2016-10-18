//
//  CustomTransitioningDelegate.h
//  TransitionAnimationDemo
//
//  Created by XiaoYiPeng on 16/10/13.
//  Copyright © 2016年 XiaoYiPeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PresentEdgeAnimatedTranstitioning.h"

@interface PresentEdgeTransitioningDelegate : NSObject <UIViewControllerTransitioningDelegate>

- (instancetype)initWithOffset:(CGFloat)offset andDirection:(EdgeDirection)direction;

/**
 *  距离另一边的空位
 */
@property (nonatomic, assign) CGFloat offset;

/**
 *  边缘滑出位置，有上下左右
 */
@property (nonatomic, assign) EdgeDirection transigionDirection;

/**
 *  需要presentingViewcontrollere 有边缘滑出手势时就设置这个属性，当transigionDirection是上下时设置了也没用，因为跟系统通知和快捷菜单有冲空
 */
@property (nonatomic, strong) UIViewController *presentingVC;

/**
 *  需要presentecViewcontrollere 有拖动返回手势时就设置这个属性
 */
@property (nonatomic, strong) UIViewController *presentedVC;

/**
 *  presentingView的边缘手势，暴露出来是为了在特殊情况下解决手势冲突时用
 */
@property (nonatomic, strong) UIScreenEdgePanGestureRecognizer *edgePanGesture;

/**
 *  presentedView的拖动手势，暴露出来是为了在特殊情况下解决手势冲突时用
 */
@property (nonatomic, strong) UIPanGestureRecognizer *pan;

@end
