//
//  RequestViewController.m
//  LHTools
//
//  Created by kangylk on 16/8/9.
//  Copyright © 2016年 kangylk. All rights reserved.
//

#import "RequestViewController.h"

#import "LoginRequest.h"

@interface RequestViewController ()

@end

@implementation RequestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self test1];
    [self test2];
    [self test3];
    [self test4];
    [self test5];
    
    
}
- (void)test1
{
    NSLog(@"%s",__FUNCTION__);
    LoginRequest *request = [LoginRequest new];
    request.username = @"wangzhang";
    request.password = @"123456";
    [request postRequestCompleted:^(id webData, BOOL isFinished) {
        if (isFinished) {
            
        }else{
            
        }
        [self test2];
    }];
}

- (void)test2
{
    NSLog(@"%s",__FUNCTION__);
    LoginRequest *request = [LoginRequest createWithParams:@{@"username":@"wangzhang",@"password":@"123456"}];
    [request postRequestCompleted:^(id webData, BOOL isFinished) {
        if (isFinished) {
            
        }else{
            
        }
        [self test3];
    }];
}
- (void)test3
{
    NSLog(@"%s",__FUNCTION__);
    LHBaseRequest *request = [LHBaseRequest new];
    request.url = @"http://api.huuhoo.com/test";
    [request postRequestCompleted:^(id webData, BOOL isFinished) {
        [self test4];
    }];
}
- (void)test4
{
    NSLog(@"%s",__FUNCTION__);
    LHBaseRequest *request = [LHBaseRequest new];
    request.url = @"http://api.huuhoo.com/test";
    [request postWithParams:@{@"username":@"wangzhang",@"password":@"123456"}
           requestCompleted:^(id webData, BOOL isFinished) {
               if (isFinished) {
                   
               }else{
                   
               }
               [self test5];
    }];
}

- (void)test5
{
    NSLog(@"%s",__FUNCTION__);
    LoginRequest *request = [LoginRequest createWithUserName:@"zhangsan" password:@"123456"];
    [request postRequestCompleted:^(id webData, BOOL isFinished) {
        if (isFinished) {
            
        }else{
            
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    NSLog(@"%s",__FUNCTION__);
    NSLog(@"%@",@"23dfaf");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
