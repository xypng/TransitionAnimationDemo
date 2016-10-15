//
//  PresentedViewController.h
//  TransitionAnimationDemo
//
//  Created by XiaoYiPeng on 16/10/14.
//  Copyright © 2016年 XiaoYiPeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomTransitioningDelegate;

@interface PresentedViewController : UIViewController

@property (nonatomic, strong) CustomTransitioningDelegate *delegate;

@end
