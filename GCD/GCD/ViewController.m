//
//  ViewController.m
//  GCD
//
//  Created by wbb on 2020/12/3.
//  Copyright © 2020 wbb. All rights reserved.
//

#import "ViewController.h"
#import "GCDDeadLock.h"
#import "PermenantThread.h"

@interface ViewController ()
@property (strong, nonatomic) PermenantThread *thread;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /// 主队列 任务等待造成死锁
//    [GCDDeadLock testDeadLockMainQueue];
    /// 主队列 异步操作 不会死锁
//    [GCDDeadLock testUnDeadLockMainQueue_async];
    /// 主队列 新建一个队列 不会死锁
//    [GCDDeadLock testUnDeadLockMainQueue_newQueue];
    /// 串行队列 同步操作 死锁
//    [GCDDeadLock testDeadLockSerialQueue];
    /// 串行队列 同步操作 不会死锁
//    [GCDDeadLock testUnDeadLockSerialQueue_async];
    /// 串行队列 新创建一个队列 不会死锁
//    [GCDDeadLock testUnDeadLockSerialQueue_newQueue];

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
