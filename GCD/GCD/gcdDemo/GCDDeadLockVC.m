//
//  GCDDeadLockVC.m
//  GCD
//
//  Created by wbb on 2020/12/8.
//  Copyright © 2020 wbb. All rights reserved.
//

#import "GCDDeadLockVC.h"
#import "GCDDeadLock.h"

@interface GCDDeadLockVC ()

@end

@implementation GCDDeadLockVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    
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
