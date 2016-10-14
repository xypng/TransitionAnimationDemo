//
//  PresentedViewController.m
//  TransitionAnimationDemo
//
//  Created by XiaoYiPeng on 16/10/13.
//  Copyright © 2016年 XiaoYiPeng. All rights reserved.
//

#import "PresentedViewController.h"
#import "CustomTransitioningDelegate.h"

@interface PresentedViewController ()

@property (nonatomic , strong) CustomTransitioningDelegate *delegate;

@end

@implementation PresentedViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        
        self.modalTransitionStyle = UIModalPresentationCustom;

        self.delegate = [[CustomTransitioningDelegate alloc] initWithOffset:100 andDirection:Right];
        self.transitioningDelegate = self.delegate;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
