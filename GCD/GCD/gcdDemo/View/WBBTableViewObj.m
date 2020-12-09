//
//  WBBTableView.m
//  GCD
//
//  Created by wbb on 2020/12/8.
//  Copyright © 2020 wbb. All rights reserved.
//

#import "WBBTableViewObj.h"

@interface WBBTableViewObj()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSDictionary *dataSource;
@end


@implementation WBBTableViewObj

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.textLabel.text = self.dataSource.allValues[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIViewController *vc = [[NSClassFromString(self.dataSource.allKeys[indexPath.row]) alloc] init];
    vc.title = self.dataSource.allValues[indexPath.row];
    [self.pushVC.navigationController pushViewController:vc animated:YES];
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    }
    return _tableView;
}

- (NSDictionary *)dataSource
{
    if (!_dataSource) {
        _dataSource = @{
            @"GCDDeadLockVC":@"gcd-队列引起的线程死锁",
            @"GCDPermenantThreadVC":@"gcd-线程保活",
            @"GCDInterviewVC":@"gcd-面试题相关",
            @"GCDGroupVC":@"gcd_dispatch_group",
        };
    }
    return _dataSource;
}
@end
