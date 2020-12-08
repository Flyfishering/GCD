//
//  WBBTableView.h
//  GCD
//
//  Created by wbb on 2020/12/8.
//  Copyright © 2020 wbb. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WBBTableViewObj : NSObject

@property (nonatomic, strong, readonly) UITableView *tableView;
@property (nonatomic, weak) UIViewController *pushVC;
@end

NS_ASSUME_NONNULL_END
