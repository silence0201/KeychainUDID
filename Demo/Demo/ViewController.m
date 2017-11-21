//
//  ViewController.m
//  Demo
//
//  Created by 杨晴贺 on 2017/11/21.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "ViewController.h"
#import "KeychainUDID.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 即使应用删除,仍一致(但是刷机后就不行了)
    NSLog(@"UDID:%@",[KeychainUDID UDID]);
}

@end
