//
//  LoginRequest.h
//  LHTools
//
//  Created by kangylk on 16/8/9.
//  Copyright © 2016年 kangylk. All rights reserved.
//

#import "LHBaseRequest.h"

@interface LoginRequest : LHBaseRequest

@property (nonatomic,copy) NSString *username;
@property (nonatomic,copy) NSString *password;

+(instancetype)createWithUserName:(NSString*)username password:(NSString*)password;

@end
