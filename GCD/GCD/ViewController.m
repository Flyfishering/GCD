//
//  ViewController.m
//  GCD
//
//  Created by wbb on 2020/12/3.
//  Copyright © 2020 wbb. All rights reserved.
//

#import "ViewController.h"
#import "GCDDeadLock.h"

@interface ViewController ()

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
    [GCDDeadLock testUnDeadLockSerialQueue_newQueue];

}


@end
