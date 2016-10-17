//
//  CustomAnimatedTranstitioning.h
//  TransitionAnimationDemo
//
//  Created by XiaoYiPeng on 16/10/13.
//  Copyright © 2016年 XiaoYiPeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    Right,
    Left,
    Above,
    Bottom,
} Direction;

@interface CustomAnimatedTranstitioning : NSObject <UIViewControllerAnimatedTransitioning>

- (instancetype)initWithOffset:(CGFloat)offset andDirection:(Direction)direction andMinification:(CGFloat)minification;

@end
