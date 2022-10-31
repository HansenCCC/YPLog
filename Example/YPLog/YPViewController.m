//
//  YPViewController.m
//  YPLog
//
//  Created by chenghengsheng on 10/31/2022.
//  Copyright (c) 2022 chenghengsheng. All rights reserved.
//

#import "YPViewController.h"
#import <YPLog/YPLog.h>

@interface YPViewController ()

@end

@implementation YPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    YPLogInfo(@"asdfasdfasd发送到发送");
}

@end
