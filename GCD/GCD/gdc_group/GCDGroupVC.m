//
//  GCDGroupVC.m
//  GCD
//
//  Created by wbb on 2020/12/8.
//  Copyright © 2020 wbb. All rights reserved.
//

#import "GCDGroupVC.h"
#import "GCDGroup.h"

@interface GCDGroupVC ()

@end

@implementation GCDGroupVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [[GCDGroup new] groupTest];
}


@end
