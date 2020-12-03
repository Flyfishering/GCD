//
//  gcd_dead_lock.m
//  GCD
//
//  Created by wbb on 2020/12/3.
//  Copyright © 2020 wbb. All rights reserved.
//

#import "GCDDeadLock.h"

@implementation GCDDeadLock

#pragma mark - 主队列 死锁 及 解决方案

/// 主队列 任务等待造成死锁
+ (void)testDeadLockMainQueue
{
    NSLog(@"执行任务1");
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_sync(queue, ^{
        NSLog(@"执行任务2");
    });
    
    NSLog(@"执行任务3");
}

/// 主队列 异步操作 不会死锁
+ (void)testUnDeadLockMainQueue_async
{
    NSLog(@"执行任务1");
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_async(queue, ^{
        NSLog(@"执行任务2");
    });
    
    NSLog(@"执行任务3");
}

/// 主队列 新建一个队列 不会死锁
+ (void)testUnDeadLockMainQueue_newQueue
{
    NSLog(@"执行任务1");
    
//    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_queue_t queue_serial = dispatch_queue_create("test.wbb.com", DISPATCH_QUEUE_SERIAL);
//    dispatch_queue_t queue_concurrent = dispatch_queue_create("test.wbb.com", DISPATCH_QUEUE_CONCURRENT);

    dispatch_async(queue_serial, ^{
        NSLog(@"执行任务2");
    });
    
    NSLog(@"执行任务3");
}

#pragma mark - 串行队列 死锁 及 解决方案
/// 串行队列 同步操作 死锁
+ (void)testDeadLockSerialQueue
{
    // 串行队列
    dispatch_queue_t queue = dispatch_queue_create("test.wbb.com", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(queue, ^{
        NSLog(@"执行任务1");
        
        dispatch_sync(queue, ^{
            NSLog(@"执行任务2");
        });
        
        NSLog(@"执行任务3");
    });
}

/// 串行队列 同步操作 不会死锁
+ (void)testUnDeadLockSerialQueue_async
{
    // 串行队列
    dispatch_queue_t queue = dispatch_queue_create("test.wbb.com", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(queue, ^{
        NSLog(@"执行任务1");
        
        dispatch_async(queue, ^{
            NSLog(@"执行任务2");
        });
        
        NSLog(@"执行任务3");
    });
}

/// 串行队列 新创建一个队列 不会死锁
+ (void)testUnDeadLockSerialQueue_newQueue
{
    // 串行队列
    dispatch_queue_t queue = dispatch_queue_create("test.wbb.com", DISPATCH_QUEUE_SERIAL);
    
//    dispatch_queue_t queue_serial = dispatch_queue_create("test.wbb.com", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue_concurrent = dispatch_queue_create("test.wbb.com", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue_concurrent, ^{
        NSLog(@"执行任务1");
        
        dispatch_async(queue, ^{
            NSLog(@"执行任务2");
        });
        
        NSLog(@"执行任务3");
    });
}


@end
