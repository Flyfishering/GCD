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
    [self __interviewLog01_r02];
}

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
- (void)__interviewLog01_r00
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

// 打印： 1 2
// 解释:
- (void)__interviewLog01_r01
{
    NSThread *thread = [[NSThread alloc] initWithBlock:^{
        NSLog(@"1");
        
        [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }];
    [thread start];
    
    [self performSelector:@selector(__interviewLog) onThread:thread withObject:nil waitUntilDone:YES];
}
/// 打印 1 3 2
///解释: 主线程中默认开启了 Runloop ， 任务 2 要在下一次 runloop 唤醒执行，所以最后打印
- (void)__interviewLog01_r02

{
    NSLog(@"1");
    [self performSelector:@selector(__interviewLog) withObject:nil afterDelay:.1];
    NSLog(@"3");
}

@end
