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
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSArray *vcArray;
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
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIViewController *vc = [[NSClassFromString(self.vcArray[indexPath.row]) alloc] init];
    vc.title = self.dataSource[indexPath.row];
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

- (NSArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = @[@"gcd-队列引起的线程死锁",
                        @"gcd-线程保活"];
    }
    return _dataSource;
}

- (NSArray *)vcArray
{
    if (!_vcArray) {
        _vcArray = @[
            @"GCDDeadLockVC",
        @"GCDPermenantThreadVC"
        ];
    }
    return _vcArray;
}
@end
