//
//  MutexDemo3.m
//  GCD
//
//  Created by wbb on 2020/12/11.
//  Copyright © 2020 wbb. All rights reserved.
//

#import "MutexDemo3.h"
#import <pthread.h>

@interface MutexDemo3()
@property (assign, nonatomic) pthread_mutex_t mutex;
@property (assign, nonatomic) pthread_cond_t cond;
@property (strong, nonatomic) NSMutableArray *data;
@end

@implementation MutexDemo3

- (instancetype)init
{
    if (self = [super init]) {
        // 初始化属性
        pthread_mutexattr_t attr;
        pthread_mutexattr_init(&attr);
        pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE);
        // 初始化锁
        pthread_mutex_init(&_mutex, &attr);
        // 销毁属性
        pthread_mutexattr_destroy(&attr);
        
        // 初始化条件
        pthread_cond_init(&_cond, NULL);
        
        self.data = [NSMutableArray array];
    }
    return self;
}

- (void)otherTest
{
    [[[NSThread alloc] initWithTarget:self selector:@selector(__remove) object:nil] start];
    
    [[[NSThread alloc] initWithTarget:self selector:@selector(__add) object:nil] start];
}

// 生产者-消费者模式

// 线程1
// 删除数组中的元素
- (void)__remove
{
    pthread_mutex_lock(&_mutex);
    NSLog(@"__remove - begin");
    
    if (self.data.count == 0) {
        // 睡眠等待 (1._mutex解锁 2. 线程睡眠 3. 等待_cond 唤醒线程)
        // 唤醒后 继续对 mutex 加锁
        pthread_cond_wait(&_cond, &_mutex);
    }
    
    [self.data removeLastObject];
    NSLog(@"删除了元素");
    
    pthread_mutex_unlock(&_mutex);
}

// 线程2
// 往数组中添加元素
- (void)__add
{
    pthread_mutex_lock(&_mutex);
    
    sleep(1);
    
    [self.data addObject:@"Test"];
    NSLog(@"添加了元素");
    
    // 信号 激活一个等待该条件的锁
    pthread_cond_signal(&_cond);
    // 广播 激活所有等待该条件的锁
//    pthread_cond_broadcast(&_cond);
    NSLog(@"__add 解锁");
    pthread_mutex_unlock(&_mutex);
}

- (void)dealloc
{
    pthread_mutex_destroy(&_mutex);
    pthread_cond_destroy(&_cond);
}
@end
