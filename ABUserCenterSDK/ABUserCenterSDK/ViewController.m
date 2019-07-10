//
//  ViewController.m
//  ABUserCenterSDK
//
//  Created by caobo56 on 2019/7/8.
//  Copyright © 2019 caobo56. All rights reserved.
//

#import "ViewController.h"
#import "ABUCAPI.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary * dict = @{@"username":@"ab10002",
                            @"password":@"abic@123",
                            @"grant_type":@"password"
                            };
    [ABUCAPI loginWithParams:dict completion:^(NSError * _Nonnull error, id  _Nonnull data) {
        NSLog(@"data == %@",data);
    }];
}

@end
