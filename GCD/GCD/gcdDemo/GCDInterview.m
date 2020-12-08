//
//  GCDInterview.m
//  GCD
//
//  Created by wbb on 2020/12/8.
//  Copyright © 2020 wbb. All rights reserved.
//

#import "GCDInterview.h"

@implementation GCDInterview

- (void)interviewLog
{
    [self __interviewLog03];
}

#pragma mark - 面试题 1
// 问：下面的打印结果
// 答案: 1 2 (3 不会打印)
// 解释:performSelector: withObject:afterDelay: 是 Runloop 方法，需要开启 runloop 才会执行
- (void)__interviewLog01
{
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    dispatch_async(queue, ^{
        NSLog(@"1");
        // 这句代码的本质是往Runloop中添加定时器
        [self performSelector:@selector(__interviewLog) withObject:nil afterDelay:.1];
        NSLog(@"3");
    });
    
}

- (void)__interviewLog
{
    NSLog(@"2");
}

// 打印: 1 3 2
- (void)__interviewLog01_r01
{
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    dispatch_async(queue, ^{
        NSLog(@"1");
        // 这句代码的本质是往Runloop中添加定时器
        [self performSelector:@selector(__interviewLog) withObject:nil afterDelay:.0];
        NSLog(@"3");
        
        [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    });
}

/// 打印 1 3 2
///解释: 主线程中默认开启了 Runloop ， 任务 2 要在下一次 runloop 唤醒执行，所以最后打印
- (void)__interviewLog01_r02

{
    NSLog(@"1");
    [self performSelector:@selector(__interviewLog) withObject:nil afterDelay:.1];
    NSLog(@"3");
}

#pragma mark - 面试题 2
// 问： 下面的代码打印什么
// 答： 会奔溃 奔溃原因: target thread exited while waiting for the perform'
// 解释: NSThread 创建的线程执行完成立马退出，在一个已退出的线程上执行任务 会奔溃
- (void)__interviewLog02
{
    NSThread *thread = [[NSThread alloc] initWithBlock:^{
        NSLog(@"1");
    }];
    [thread start];
    
    [self performSelector:@selector(__interviewLog) onThread:thread withObject:nil waitUntilDone:YES];
}

// 打印： 1 2
// 解释: 采用 runloop 对线程保活，这样就不会奔溃了
- (void)__interviewLog02_r
{
    NSThread *thread = [[NSThread alloc] initWithBlock:^{
        NSLog(@"1");
        
        [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }];
    [thread start];
    // 唤醒 runloop
    [self performSelector:@selector(__interviewLog) onThread:thread withObject:nil waitUntilDone:YES];
}


#pragma mark - 面试题 3
// 问: 如何实现 并发执行 任务1， 任务2 ， 等任务1， 任务2 执行完成之后 再执行 任务3
// 答：采用 dispatch_group_t 实现
- (void)__interviewLog03
{
    // 创建队列组
        dispatch_group_t group = dispatch_group_create();
        // 创建并发队列
        dispatch_queue_t queue = dispatch_queue_create("my_queue", DISPATCH_QUEUE_CONCURRENT);
        
        // 添加异步任务
        dispatch_group_async(group, queue, ^{
            for (int i = 0; i < 5; i++) {
                NSLog(@"任务1-%@", [NSThread currentThread]);
            }
        });
        
        dispatch_group_async(group, queue, ^{
            for (int i = 0; i < 5; i++) {
                NSLog(@"任务2-%@", [NSThread currentThread]);
            }
        });
        
// 等前面的任务执行完毕后，会自动执行这个任务 主线程 中执行
    //    dispatch_group_notify(group, queue, ^{
    //        dispatch_async(dispatch_get_main_queue(), ^{
    //            for (int i = 0; i < 5; i++) {
    //                NSLog(@"任务3-%@", [NSThread currentThread]);
    //            }
    //        });
    //    });
        
    //    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
    //        for (int i = 0; i < 5; i++) {
    //            NSLog(@"任务3-%@", [NSThread currentThread]);
    //        }
    //    });
  
// 前面的任务执行后 再同时执行 下面的任务
        dispatch_group_notify(group, queue, ^{
            for (int i = 0; i < 5; i++) {
                NSLog(@"任务3-%@", [NSThread currentThread]);
            }
        });
        
        dispatch_group_notify(group, queue, ^{
            for (int i = 0; i < 5; i++) {
                NSLog(@"任务4-%@", [NSThread currentThread]);
            }
        });
}

@end
