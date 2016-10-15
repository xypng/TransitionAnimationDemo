//
//  PresentingViewController.m
//  TransitionAnimationDemo
//
//  Created by XiaoYiPeng on 16/10/13.
//  Copyright © 2016年 XiaoYiPeng. All rights reserved.
//

#import "PresentingViewController.h"
#import "PresentedViewController.h"
#import "CustomTransitioningDelegate.h"

@interface PresentingViewController()

@property (nonatomic, strong) PresentedViewController *presentedVC;

/**
 *  手势起始的x位置
 */
@property (nonatomic, assign) CGFloat gestureBeginX;

@end

@implementation PresentingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIScreenEdgePanGestureRecognizer *edgePanGesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(edgePan:)];
    edgePanGesture.edges = UIRectEdgeRight;
    [self.view addGestureRecognizer:edgePanGesture];

    self.presentedVC = [[PresentedViewController alloc] init];

}

- (IBAction)present:(UIButton *)sender {
    [self presentViewController:self.presentedVC animated:YES completion:nil];
}

- (void)edgePan:(UIScreenEdgePanGestureRecognizer *)gesture {
    CGFloat xOffset = -[gesture translationInView:self.view].x;
    CGFloat percent = xOffset/self.gestureBeginX;
    percent = MIN(1, MAX(0, percent));
    NSLog(@"Present Percent: %.2f", percent);

    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.gestureBeginX = [gesture locationInView:self.view].x;
            NSLog(@"beginX: %.2f", self.gestureBeginX);
            self.presentedVC.delegate.interactiveTransition = [[UIPercentDrivenInteractiveTransition alloc]init];
            [self presentViewController:self.presentedVC animated:YES completion:nil];
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            [self.presentedVC.delegate.interactiveTransition updateInteractiveTransition:percent];
        }
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        {
            if (percent>0.5) {
                [self.presentedVC.delegate.interactiveTransition finishInteractiveTransition];
            } else {
                [self.presentedVC.delegate.interactiveTransition cancelInteractiveTransition];
            }
            self.presentedVC.delegate.interactiveTransition = nil;
        }
            break;
        default:
            break;
    }
}

@end
