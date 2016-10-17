//
//  CustomTransitioningDelegate.m
//  TransitionAnimationDemo
//
//  Created by XiaoYiPeng on 16/10/13.
//  Copyright © 2016年 XiaoYiPeng. All rights reserved.
//

#import "PresentEdgeTransitioningDelegate.h"
#import "PresentEdgePresentationController.h"

@interface PresentEdgeTransitioningDelegate ()

@property (nonatomic, strong) PresentEdgePresentationController *presentation;

@property (nonatomic, strong) PresentEdgeAnimatedTranstitioning *animatedTransitioning;

/**
 *  手势起始的x/y位置
 */
@property (nonatomic, assign) CGFloat gestureBegin;

@end

@implementation PresentEdgeTransitioningDelegate

- (instancetype)initWithOffset:(CGFloat)offset andDirection:(EdgeDirection)direction {
    self = [super init];
    if (self) {
        _offset = offset;
        _transigionDirection = direction;

        self.animatedTransitioning = [[PresentEdgeAnimatedTranstitioning alloc] initWithOffset:self.offset andDirection:self.transigionDirection];
        
    }
    return self;
}

- (void)setPresentingVC:(UIViewController *)presentingVC {
    _presentingVC = presentingVC;

    if (self.transigionDirection==Above || self.transigionDirection==Bottom) {
        //上下加不了边缘手势，会跟系统的通知/快捷菜单冲突
        return;
    }

    UIScreenEdgePanGestureRecognizer *edgePanGesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(edgePan:)];
    switch (self.transigionDirection) {
        case Right:
        {
            edgePanGesture.edges = UIRectEdgeRight;
        }
            break;
        case Left:
        {
            edgePanGesture.edges = UIRectEdgeLeft;
        }
            break;
        default:
            break;
    }
    [_presentingVC.view addGestureRecognizer:edgePanGesture];
}

- (void)edgePan:(UIScreenEdgePanGestureRecognizer *)gesture {
    CGFloat offset;
    CGFloat percent;
    //不同方向得到percent方法不一样
    switch (self.transigionDirection) {
        case Right:
        {
            offset = -[gesture translationInView:self.presentingVC.view].x;
            percent = offset/( self.gestureBegin - self.offset );
        }
            break;
        case Left:
        {
            offset = [gesture translationInView:self.presentingVC.view].x;
            percent = offset/( self.presentingVC.view.bounds.size.width - self.gestureBegin - self.offset );
        }
            break;
        default:
            break;
    }

    percent = MIN(1, MAX(0, percent));
    NSLog(@"Present Percent: %.2f", percent);

    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.gestureBegin = [gesture locationInView:self.presentingVC.view].x;
            NSLog(@"gestureBeginX: %.2f", self.gestureBegin);
            self.interactiveTransition = [[UIPercentDrivenInteractiveTransition alloc]init];
            [self.presentingVC presentViewController:self.presentedVC animated:YES completion:nil];
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            [self.interactiveTransition updateInteractiveTransition:percent];
        }
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        {
            if (percent>0.5) {
                [self.interactiveTransition finishInteractiveTransition];
            } else {
                [self.interactiveTransition cancelInteractiveTransition];
            }
            self.interactiveTransition = nil;
        }
            break;
        default:
            break;
    }
}

- (void)setPresentedVC:(UIViewController *)presentedVC {
    _presentedVC = presentedVC;

    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panRecognizer:)];
    [_presentedVC.view addGestureRecognizer:pan];
}

- (void)panRecognizer:(UIPanGestureRecognizer *)gesture {
    CGFloat offset;
    CGFloat percent;
    switch (self.transigionDirection) {
        case Right:
        {
            offset = [gesture translationInView:self.presentedVC.view].x;
            percent = offset/(self.presentedVC.view.bounds.size.width-self.gestureBegin);
        }
            break;
        case Left:
        {
            offset = -[gesture translationInView:self.presentedVC.view].x;
            percent = offset/self.gestureBegin;
        }
            break;
        case Above:
        {
            offset = -[gesture translationInView:self.presentedVC.view].y;
            percent = offset/self.gestureBegin;
        }
            break;
        case Bottom:
        {
            offset = [gesture translationInView:self.presentedVC.view].y;
            percent = offset/(self.presentedVC.view.bounds.size.height-self.gestureBegin);
        }
            break;
        default:
            break;
    }

    percent = MIN(1, MAX(0, percent));
    NSLog(@"Dismiss Percent: %.2f", percent);

    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            switch (self.transigionDirection) {
                case Right:
                case Left:
                {
                    self.gestureBegin = [gesture locationInView:self.presentedVC.view].x;
                }
                    break;
                case Above:
                case Bottom:
                {
                    self.gestureBegin = [gesture locationInView:self.presentedVC.view].y;
                }
                    break;
                default:
                    break;
            }

            self.interactiveTransition = [[UIPercentDrivenInteractiveTransition alloc]init];
            [self.presentedVC dismissViewControllerAnimated:YES completion:nil];
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            [self.interactiveTransition updateInteractiveTransition:percent];
        }
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        {
            if (percent>0.5) {
                [self.interactiveTransition finishInteractiveTransition];
            } else {
                [self.interactiveTransition cancelInteractiveTransition];
            }
            self.interactiveTransition = nil;
        }
            break;
        default:
            break;
    }
}

#pragma mark - <UIViewControllerTransitioningDelegate>
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {

    return self.animatedTransitioning;

}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return self.animatedTransitioning;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator {
    return self.interactiveTransition;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
    return self.interactiveTransition;
}

//- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source NS_AVAILABLE_IOS(8_0) {
//    self.presentation = [[CustomPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
//    self.presentation.minification = self.minification;
//    self.presentation.offset = self.offset;
//    return self.presentation;
//}

@end
