//
//  WBBTheadBaseDemo.m
//  GCD
//
//  Created by wbb on 2020/12/9.
//  Copyright © 2020 wbb. All rights reserved.
//

#import "TheadBaseDemo.h"

@interface TheadBaseDemo()
@property (assign, nonatomic) int money;
@property (assign, nonatomic) int ticketsCount;
@end

@implementation TheadBaseDemo

- (void)dealloc
{
    NSLog(@"TheadBaseDemo %s",__func__);
}

/**
 存钱、取钱演示
 */
- (void)moneyTest
{
    self.money = 100;
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i++) {
            [self __saveMoney];
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i++) {
            [self __drawMoney];
        }
    });
}

/**
 存钱
 */
- (void)__saveMoney
{
    int oldMoney = self.money;
    sleep(.2);
    oldMoney += 50;
    self.money = oldMoney;
    
    NSLog(@"存50，还剩%d元 - %@", oldMoney, [NSThread currentThread]);
}

/**
 取钱
 */
- (void)__drawMoney
{
    int oldMoney = self.money;
    sleep(.2);
    oldMoney -= 20;
    self.money = oldMoney;
    
    NSLog(@"取20，还剩%d元 - %@", oldMoney, [NSThread currentThread]);
}

/**
 卖1张票
 */
- (void)__saleTicket
{
    int oldTicketsCount = self.ticketsCount;
    sleep(.2);
    oldTicketsCount--;
    self.ticketsCount = oldTicketsCount;
    NSLog(@"还剩%d张票 - %@", oldTicketsCount, [NSThread currentThread]);
}

/**
 卖票演示
 */
- (void)ticketTest
{
    self.ticketsCount = 15;
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 5; i++) {
            [self __saleTicket];
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 5; i++) {
            [self __saleTicket];
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 5; i++) {
            [self __saleTicket];
        }
    });
}

@end