//
//  GCDPermenantThreadVC.m
//  GCD
//
//  Created by wbb on 2020/12/8.
//  Copyright © 2020 wbb. All rights reserved.
//

#import "GCDPermenantThreadVC.h"
#import "PermenantThread.h"

@interface GCDPermenantThreadVC ()

@property (strong, nonatomic) PermenantThread *thread;

@end



@implementation GCDPermenantThreadVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self permenantThereadDemo];
}

- (void)permenantThereadDemo
{
    UIButton *startButton = [UIButton new];
    startButton.frame = CGRectMake(100, 100, 100, 50);
    [startButton setBackgroundColor:[UIColor grayColor]];
    [startButton setTitle:@"开始" forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(startAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startButton];
    
    UIButton *endButton = [UIButton new];
    endButton.frame = CGRectMake(100, 200, 100, 50);
    [endButton setBackgroundColor:[UIColor grayColor]];
    [endButton setTitle:@"结束" forState:UIControlStateNormal];
    [endButton addTarget:self action:@selector(endAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:endButton];
}


- (void)startAction
{
    [self.thread executeTask:^{
        NSLog(@"执行任务 - %@", [NSThread currentThread]);
    }];
}

- (void)endAction
{
    [self.thread stop];
}

- (PermenantThread *)thread
{
    if (!_thread) {
        _thread = [[PermenantThread alloc] init];
    }
    return _thread;
}

@end
