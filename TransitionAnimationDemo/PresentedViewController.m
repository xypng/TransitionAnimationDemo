//
//  PresentedViewController.m
//  TransitionAnimationDemo
//
//  Created by XiaoYiPeng on 16/10/14.
//  Copyright © 2016年 XiaoYiPeng. All rights reserved.
//

#import "PresentedViewController.h"
#import "CustomTransitioningDelegate.h"

@interface PresentedViewController ()

/**
 *  手势起始的x位置
 */
@property (nonatomic, assign) CGFloat gestureBeginX;

@end

@implementation PresentedViewController

- (instancetype)init {
    self = [super init];
    if (self) {

        self.modalPresentationStyle = UIModalPresentationCustom;

        self.delegate = [[CustomTransitioningDelegate alloc] initWithOffset:100 andDirection:Right];
        self.transitioningDelegate = self.delegate;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panRecognizer:)];
    [self.view addGestureRecognizer:pan];
}

- (IBAction)dismiss:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)panRecognizer:(UIPanGestureRecognizer *)gesture {
    CGFloat xOffset = [gesture translationInView:self.presentedViewController.view].x;
    CGFloat percent = xOffset/((self.view.bounds.size.width)-self.gestureBeginX);
    percent = MIN(1, MAX(0, percent));
    NSLog(@"Dismiss Percent: %.2f", percent);

    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.gestureBeginX = [gesture locationInView:self.view].x;

            self.delegate.interactiveTransition = [[UIPercentDrivenInteractiveTransition alloc]init];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            [self.delegate.interactiveTransition updateInteractiveTransition:percent];
        }
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        {
            if (percent>0.5) {
                [self.delegate.interactiveTransition finishInteractiveTransition];
            } else {
                [self.delegate.interactiveTransition cancelInteractiveTransition];
            }
            self.delegate.interactiveTransition = nil;
        }
            break;
        default:
            break;
    }
}

@end
