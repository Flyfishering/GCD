//
//  GCDGroup.m
//  GCD
//
//  Created by wbb on 2020/12/8.
//  Copyright © 2020 wbb. All rights reserved.
//

#import "GCDGroup.h"

@implementation GCDGroup

- (void)groupTest
{
    [self __groupTest04];
}

#pragma mark - api 说明
/*
 
 dispatch_group_create
 dispatch_group_async
    dispatch_group_t group: 传入 group
    dispatch_queue_t queue: 管理任务(block)的队列
    dispatch_block_t block: 执行的任务
    将异步执行的任务加入队列中，并与 group 关联。
    group 等待这个异步任务执行完成
 dispatch_group_async_f
    同 dispatch_group_async
    dispatch_group_t group: 传入 group
    dispatch_queue_t queue: 管理任务(block)的队列
    void *context: 上下文环境
    dispatch_function_t work: 异步执行的任务 c 语音函数地址(方法的第一个参数是 context)
    
 dispatch_group_wait
        dispatch_group_t group： 传入 group
        dispatch_time_t timeout: 超时时间
        等待 group 中的任务执行完成，或者时间超时。
        任务全部完成 返回 0
        超时 返回 非0
 dispatch_group_notify
        dispatch_group_t group: 关联的 group
        dispatch_queue_t queue: 管理任务的队列
        dispatch_block_t block: 执行的任务
        提交一个任务到一个队列中，等待 group 管理的 任务都执行完成后 (即 group 里的任务为空)，提交的任务立马执行
 dispatch_group_notify_f
        同 dispatch_group_notify
        dispatch_group_t group: 关联的 group
        dispatch_queue_t queue: 管理任务的队列
        void *context: 上下文，作为第一个参数 传入 work 函数中。
        dispatch_function_t work:执行的任务 c 语音函数地址(方法的第一个参数是 context)
 
 dispatch_group_enter
    明确表示任务进入 group，对对任务进行引用计数加一
 dispatch_group_leave
    明确表示任务进入 group，对对任务进行引用计数加一
    这两个方法成对出现
    明确表示某个任务已经进入，退出该组。
    使用这两个方法，对 group 关联的任务 进行引用计数管理，效果跟dispatch_group_async 一样。
 
 
 
 // 参考文章
 // https://mp.weixin.qq.com/s?__biz=MzA5NzMwODI0MA==&mid=2647768705&idx=1&sn=c53e15c779d0b862229823611ac3c154&exportkey=ASZvT5vXnX9YZNCfBCUsOCk%3D&pass_ticket=n868ofB%2FXB0JHlagX8B10IBCuNP2HC3ItwOtTRJ%2BqXuER5XwD0HqMw6EOFMwFUSf&wx_header=0
 */

#pragma mark - dispatch_group_async

- (void)__groupTest01
{
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("my_queue", DISPATCH_QUEUE_CONCURRENT);

    dispatch_group_async(group, queue, ^{
        for (NSInteger i=0; i<10; i++) {
            NSLog(@"任务一 %ld 线程 %@",i,[NSThread currentThread]);
        }
    });
    
    dispatch_group_async(group, queue, ^{
        for (NSInteger i=0; i<10; i++) {
            NSLog(@"任务二 %ld 线程 %@",i,[NSThread currentThread]);
        }
    });
    
    dispatch_group_async(group, queue, ^{
        for (NSInteger i=0; i<10; i++) {
            NSLog(@"任务三 %ld 线程 %@",i,[NSThread currentThread]);
        }
    });
    /// 等待 任务一，任务二，任务三 都执行完成后 开始执行任务四
    dispatch_group_notify(group, queue, ^{
        for (NSInteger i=0; i<10; i++) {
            NSLog(@"任务四 %ld 线程 %@",i,[NSThread currentThread]);
        }
    });
}

#pragma mark - dispatch_group_async_f

- (void)__groupTest02
{
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("my_queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_async_f(group, queue, NULL, __dispatch_function_01);
    
    dispatch_group_async_f(group, queue, NULL, __dispatch_function_02);

    dispatch_group_async_f(group, queue, NULL, __dispatch_function_03);

    /// 等待 任务一，任务二，任务三 都执行完成后 开始执行任务四
    dispatch_group_notify_f(group, queue, NULL, __dispatch_function_04);
}

void __dispatch_function_01(void* context)
{

    for (NSInteger i=0; i<10; i++) {
        NSLog(@"任务一 %ld 线程 %@",i,[NSThread currentThread]);
    }
}

void __dispatch_function_02(void* context)
{
    for (NSInteger i=0; i<10; i++) {
        NSLog(@"任务二 %ld 线程 %@",i,[NSThread currentThread]);
    }
}

void __dispatch_function_03(void* context)
{
    for (NSInteger i=0; i<10; i++) {
        NSLog(@"任务三 %ld 线程 %@",i,[NSThread currentThread]);
    }
}

void __dispatch_function_04(void* context)
{
    for (NSInteger i=0; i<10; i++) {
        NSLog(@"任务四 %ld 线程 %@",i,[NSThread currentThread]);
    }
}

#pragma mark - dispatch_group_wait

- (void)__groupTest03
{
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("my_queue", DISPATCH_QUEUE_CONCURRENT);

    dispatch_group_async(group, queue, ^{
        for (NSInteger i=0; i<1000; i++) {
            NSLog(@"任务一 %ld 线程 %@",i,[NSThread currentThread]);
        }
    });
    
    dispatch_group_async(group, queue, ^{
        for (NSInteger i=0; i<1000; i++) {
            NSLog(@"任务二 %ld 线程 %@",i,[NSThread currentThread]);
        }
    });
    
    dispatch_group_async(group, queue, ^{
        for (NSInteger i=0; i<1000; i++) {
            NSLog(@"任务三 %ld 线程 %@",i,[NSThread currentThread]);
        }
    });
    /// 等待 任务一，任务二，任务三 都执行完成后 开始执行任务四
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)1* NSEC_PER_SEC);
    //DISPATCH_TIME_FOREVER
    // 阻塞一秒后 执行下面的任务五
    long result = dispatch_group_wait(group, time);
    
    if (result) {
        NSLog(@"group 任务执行超时");
    }else{
        NSLog(@"group 任务执行完成");
    }
    NSLog(@"任务五");
    /// 等待 任务一，任务二，任务三 都执行完成 ， 开始执行任务四
    dispatch_group_notify(group, queue, ^{
        for (NSInteger i=0; i<10; i++) {
            NSLog(@"任务四 %ld 线程 %@",i,[NSThread currentThread]);
        }
    });
}

#pragma mark - dispatch_group_enter dispatch_group_leave

- (void)__groupTest04
{
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_enter(group);
    [self __requestFromNet01:^{
        dispatch_group_leave(group);
    }];
    
    //任务一，任务三 执行完成后 才会执行任务二
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"任务二");
    });
    
    dispatch_group_enter(group);
       [self __requestFromNet02:^{
           dispatch_group_leave(group);
    }];
    
    //任务一，任务三 执行完成后 才会执行任务二
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
           NSLog(@"任务四");
    });
    
    
}

- (void)__requestFromNet01:(void (^) (void))complete
{
    dispatch_queue_t queue = dispatch_queue_create("wbb.queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        for (NSInteger i=0; i<100; i++) {
            NSLog(@"任务一 %ld 线程 %@",i,[NSThread currentThread]);
        }
        complete();
    });
}

- (void)__requestFromNet02:(void (^) (void))complete
{
    dispatch_queue_t queue = dispatch_queue_create("wbb.queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        for (NSInteger i=0; i<100; i++) {
            NSLog(@"任务三 %ld 线程 %@",i,[NSThread currentThread]);
        }
        complete();
    });
}

@end
