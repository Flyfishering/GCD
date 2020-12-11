//
//  MutexDemo.m
//  GCD
//
//  Created by wbb on 2020/12/11.
//  Copyright © 2020 wbb. All rights reserved.
//

#import "MutexDemo.h"
#import <pthread.h>

@interface MutexDemo()
@property (nonatomic, assign) pthread_mutex_t ticketMutexLock;
@property (nonatomic, assign) pthread_mutex_t moneyMutexLock;
@end

@implementation MutexDemo

- (instancetype)init
{
    if (self = [super init]) {
        [self __initMutex:&_ticketMutexLock];
        [self __initMutex:&_moneyMutexLock];
    }
    return self;
}

- (void)__initMutex:(pthread_mutex_t *)mutex
{
    pthread_mutexattr_t attr;
    pthread_mutexattr_init(&attr);
    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_DEFAULT);
    pthread_mutex_init(mutex, &attr);
    
//    pthread_mutex_init(mutex, NULL);
}

- (void)__saleTicket
{
    pthread_mutex_lock(&_ticketMutexLock);
    
    [super __saleTicket];
    
    pthread_mutex_unlock(&_ticketMutexLock);
}

- (void)__saveMoney
{
    pthread_mutex_lock(&_moneyMutexLock);
    
    [super __saveMoney];
    
    pthread_mutex_unlock(&_moneyMutexLock);
}

- (void)__drawMoney
{
    pthread_mutex_lock(&_moneyMutexLock);
    
    [super __drawMoney];
    
    pthread_mutex_unlock(&_moneyMutexLock);
}

- (void)dealloc
{
    pthread_mutex_destroy(&_moneyMutexLock);
    pthread_mutex_destroy(&_ticketMutexLock);
}


@end
