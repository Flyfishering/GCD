//
//  OSSpinLockDemo2.m
//  GCD
//
//  Created by wbb on 2020/12/10.
//  Copyright © 2020 wbb. All rights reserved.
//

#import "OSSpinLockDemo2.h"
#import <libkern/OSAtomic.h>

@implementation OSSpinLockDemo2

static OSSpinLock moneyLock_;

+ (void)initialize
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        moneyLock_ = OS_SPINLOCK_INIT;
    });
}

- (void)dealloc
{
    NSLog(@"OSSpinLockDemo %s",__func__);
}

- (void)__drawMoney
{
    OSSpinLockLock(&moneyLock_);
    
    [super __drawMoney];
    
    OSSpinLockUnlock(&moneyLock_);
}

- (void)__saveMoney
{
    OSSpinLockLock(&moneyLock_);
    
    [super __saveMoney];
    
    OSSpinLockUnlock(&moneyLock_);
}

- (void)__saleTicket
{
    static OSSpinLock ticketLock = OS_SPINLOCK_INIT;
    
    OSSpinLockLock(&ticketLock);
    
    [super __saleTicket];
    
    OSSpinLockUnlock(&ticketLock);
}

@end
