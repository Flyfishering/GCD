//
//  WBBTheadBaseDemo.h
//  GCD
//
//  Created by wbb on 2020/12/9.
//  Copyright © 2020 wbb. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TheadBaseDemo : NSObject

- (void)moneyTest;
- (void)ticketTest;
- (void)otherTest;

#pragma mark - 暴露给子类去使用
- (void)__saveMoney;
- (void)__drawMoney;
- (void)__saleTicket;

@end

NS_ASSUME_NONNULL_END
