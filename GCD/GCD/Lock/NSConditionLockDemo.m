//
//  NSConditionLockDemo.m
//  GCD
//
//  Created by wbb on 2020/12/11.
//  Copyright © 2020 wbb. All rights reserved.
//

#import "NSConditionLockDemo.h"

@interface NSConditionLockDemo()
@property (strong, nonatomic) NSConditionLock *conditionLock;
@end

@implementation NSConditionLockDemo

- (instancetype)init
{
    if (self = [super init]) {
        self.conditionLock = [[NSConditionLock alloc] initWithCondition:1];
    }
    return self;
}

- (void)otherTest
{
    [[[NSThread alloc] initWithTarget:self selector:@selector(__one) object:nil] start];
    
    [[[NSThread alloc] initWithTarget:self selector:@selector(__two) object:nil] start];
    
    [[[NSThread alloc] initWithTarget:self selector:@selector(__three) object:nil] start];
}

- (void)__one
{
    [self.conditionLock lock];
    
    NSLog(@"__one");
    sleep(1);
    // 解锁 并将内部条件 设置为 2
    [self.conditionLock unlockWithCondition:2];
}

- (void)__two
{   // 当内部条件是 2 时 加锁
    [self.conditionLock lockWhenCondition:2];
    
    NSLog(@"__two");
    sleep(1);
    // 解锁 并将内部条件 设置为 3
    [self.conditionLock unlockWithCondition:3];
}

- (void)__three
{
    // 当内部条件是 3 时 加锁
    [self.conditionLock lockWhenCondition:3];
    
    NSLog(@"__three");
    
    [self.conditionLock unlock];
}

@end
