//
//  LoginRequest.m
//  LHTools
//
//  Created by kangylk on 16/8/9.
//  Copyright © 2016年 kangylk. All rights reserved.
//

#import "LoginRequest.h"

@implementation LoginRequest
+ (instancetype)createWithUserName:(NSString*)username password:(NSString*)password
{
    LoginRequest *request = [LoginRequest new];
    request.username = username;
    request.password = password;
    return request;
}
- (void)setDefault
{
    self.url = @"http://api.huuhoo.com/login";
}

@end
