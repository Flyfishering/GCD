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

@interface LockVC ()
@property (nonatomic, strong)OSSpinLockDemo *OSSPinLockObj;
@property (nonatomic, strong)OSSpinLockDemo2 *OSSPinLockObj2;
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
    [self OSSpinLockDemo];
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


@end
