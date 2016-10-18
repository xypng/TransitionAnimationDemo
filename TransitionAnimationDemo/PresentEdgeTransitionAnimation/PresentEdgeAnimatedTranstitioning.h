//
//  CustomAnimatedTranstitioning.h
//  TransitionAnimationDemo
//
//  Created by XiaoYiPeng on 16/10/13.
//  Copyright © 2016年 XiaoYiPeng. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *   边缘滑出的方向
 */
typedef enum : NSUInteger {
    Right,
    Left,
    Above,
    Bottom,
} EdgeDirection;

@interface PresentEdgeAnimatedTranstitioning : NSObject <UIViewControllerAnimatedTransitioning>

- (instancetype)initWithOffset:(CGFloat)offset andDirection:(EdgeDirection)direction;

@end
