//
//  LockVC.m
//  GCD
//
//  Created by wbb on 2020/12/9.
//  Copyright © 2020 wbb. All rights reserved.
//

#import "LockVC.h"
#import "ThreadHiddenTrouble.h"
#import "OSSpinLockDemo.h"
#import "OSSpinLockDemo2.h"
#import "OSUnfairLockDemo.h"
#import "MutexDemo.h"

@interface LockVC ()

@end

@implementation LockVC

- (void)dealloc
{
    NSLog(@"LockVC %s",__func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    [self ThreadHiddenTroubleDemo];
//    [self OSSpinLockDemo];
//    [self OSUnfairLockDemo];
    [self MutexDemo];
}

/// 线程隐患
- (void)ThreadHiddenTroubleDemo
{
    [[ThreadHiddenTrouble new] moneyTest];
//    [[ThreadHiddenTrouble new] ticketTest];
}
/// 自旋锁
- (void)OSSpinLockDemo
{
//    [[OSSpinLockDemo new] moneyTest];
//    [[OSSpinLockDemo new] ticketTest];
    
    [[OSSpinLockDemo2 new] moneyTest];
//    [[OSSpinLockDemo2 new] ticketTest];
}

- (void)OSUnfairLockDemo
{
    [[OSUnfairLockDemo new] moneyTest];
    [[OSUnfairLockDemo new] ticketTest];
}

- (void)MutexDemo
{
    [[MutexDemo new] moneyTest];
    [[MutexDemo new] ticketTest];
}
@end
