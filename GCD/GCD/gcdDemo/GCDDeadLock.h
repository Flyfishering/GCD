//
//  gcd_dead_lock.h
//  GCD
//
//  Created by wbb on 2020/12/3.
//  Copyright © 2020 wbb. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/// 线程死锁
@interface GCDDeadLock : NSObject

/// 主队列 任务等待造成死锁
+ (void)testDeadLockMainQueue;
/// 主队列 异步操作 不会死锁
+ (void)testUnDeadLockMainQueue_async;
/// 主队列 新建一个队列 不会死锁
+ (void)testUnDeadLockMainQueue_newQueue;

#pragma mark - 串行队列 死锁 及 解决方案
/// 串行队列 同步操作 死锁
+ (void)testDeadLockSerialQueue;
/// 串行队列 同步操作 不会死锁
+ (void)testUnDeadLockSerialQueue_async;
/// 串行队列 新创建一个队列 不会死锁
+ (void)testUnDeadLockSerialQueue_newQueue;

@end

NS_ASSUME_NONNULL_END
