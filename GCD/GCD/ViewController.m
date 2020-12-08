//
//  ViewController.m
//  GCD
//
//  Created by wbb on 2020/12/3.
//  Copyright © 2020 wbb. All rights reserved.
//

#import "ViewController.h"
#import "WBBTableViewObj.h"

@interface ViewController ()
@property (nonatomic, strong) WBBTableViewObj *tableViewObj;
@end

@implementation ViewController

- (void)loadView
{
    [super loadView];
    [self.view addSubview:self.tableViewObj.tableView];
    self.tableViewObj.tableView.frame = self.view.bounds;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}



- (WBBTableViewObj *)tableViewObj
{
    if (!_tableViewObj) {
        _tableViewObj = [WBBTableViewObj new];
        _tableViewObj.pushVC = self;
    }
    return _tableViewObj;
}

@end
