//
//  PermenantThread.h
//  GCD
//
//  Created by wbb on 2020/12/7.
//  Copyright © 2020 wbb. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void (^PermenantThreadTask)(void);



/// 线程保活
@interface PermenantThread : NSObject


/**
 开启线程
 */
//- (void)run;

/**
 在当前子线程执行一个任务
 */
- (void)executeTask:(PermenantThreadTask)task;

/**
 结束线程
 */
- (void)stop;

@end

NS_ASSUME_NONNULL_END
