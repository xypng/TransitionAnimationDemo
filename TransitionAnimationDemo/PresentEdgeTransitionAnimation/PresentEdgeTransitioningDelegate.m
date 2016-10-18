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

/**
 *  交互手势完成比例
 */
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactiveTransition;

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

/**
 *  设置 presentedViewControlerr的边缘手势
 *
 *  @param presentingVC presentingViewController
 */
- (void)setPresentingVC:(UIViewController *)presentingVC {
    _presentingVC = presentingVC;

    if (self.transigionDirection==Above || self.transigionDirection==Bottom) {
        //上下加不了边缘手势，会跟系统的通知/快捷菜单冲突
        return;
    }

    self.edgePanGesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(edgePan:)];
    switch (self.transigionDirection) {
        case Right:
        {
            self.edgePanGesture.edges = UIRectEdgeRight;
        }
            break;
        case Left:
        {
            self.edgePanGesture.edges = UIRectEdgeLeft;
        }
            break;
        default:
            break;
    }
    [_presentingVC.view addGestureRecognizer:self.edgePanGesture];
}

/**
 *  presentingViewController的边缘手势
 *
 *  @param gesture 手势
 */
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

/**
 *  设置presentedViewController时，设置它的拖动手势
 *
 *  @param presentedVC presentedViewcontroller
 */
- (void)setPresentedVC:(UIViewController *)presentedVC {
    _presentedVC = presentedVC;

    self.pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panRecognizer:)];
    [_presentedVC.view addGestureRecognizer:self.pan];
}

/**
 *  presentedViewController的拖动手势
 *
 *  @param gesture 手势
 */
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
//返回动画对象
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {

    return self.animatedTransitioning;

}
//返回动画对象
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return self.animatedTransitioning;
}
//交互控制对象，由手势控制产生，并更新，手势完成时变回nil
- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator {
    return self.interactiveTransition;
}
//交互控制对象，由手势控制产生，并更新，手势完成时变回nil
- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
    return self.interactiveTransition;
}

//返回presentationController，作一些额外的动画，为了兼容iOS7,弃用它，在animatedTransitioning一样完成
//- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source NS_AVAILABLE_IOS(8_0) {
//    self.presentation = [[CustomPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
//    self.presentation.minification = self.minification;
//    self.presentation.offset = self.offset;
//    return self.presentation;
//}

@end
