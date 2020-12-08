//
//  GCDInterviewVC.m
//  GCD
//
//  Created by wbb on 2020/12/8.
//  Copyright © 2020 wbb. All rights reserved.
//

#import "GCDInterviewVC.h"
#import "GCDInterview.h"

@interface GCDInterviewVC ()
@property (nonatomic, strong)GCDInterview *gcdInterview;
@end

@implementation GCDInterviewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.gcdInterview interviewLog];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.gcdInterview interviewLog];
}

- (GCDInterview *)gcdInterview
{
    if (!_gcdInterview) {
        _gcdInterview = [GCDInterview new];
    }
    return _gcdInterview;
}

@end
