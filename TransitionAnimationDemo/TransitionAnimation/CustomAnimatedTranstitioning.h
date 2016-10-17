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
} EdgeDirection;

@interface CustomAnimatedTranstitioning : NSObject <UIViewControllerAnimatedTransitioning>

- (instancetype)initWithOffset:(CGFloat)offset andDirection:(EdgeDirection)direction;

@property (nonatomic, strong) UIVisualEffectView *dimmingView;

@end
