//
//  BaseRequest.h
//  Memedia
//
//  Created by Kyle01 Kang on 15/12/11.
//  Copyright © 2015年 ME. All rights reserved.
//

#import "LHBaseRequest.h"
#import "MJExtension.h"
#import "HYBNetworking.h"



@implementation LHBaseRequest

-(instancetype)init
{
    self = [super init];
    [self setDefault];
    return self;
}
-(void)setDefault
{
    _url = [self requestUrl];
}

-(NSString *)requestUrl
{
    return @"http://";
}

- (BOOL)requestValidator {
    return YES;
}

- (BOOL)responseValidator {
    return YES;
}

-(NSDictionary *)getParams
{
    NSMutableDictionary *paramDic = [self mj_keyValuesWithIgnoredKeys:@[@"url"]];
    return paramDic;
}

+(instancetype)createWithParams:(NSDictionary*)params
{
    LHBaseRequest *ins = nil;
    if ([params isKindOfClass:[NSDictionary class]]) {
        ins = [self mj_objectWithKeyValues:params];
    }
    return ins;
}

- (void)postRequestCompleted:(DataCompletionBlock)respenseBlock
{
    [self postWithUrl:self.url params:[self getParams] completed:^(id webData, BOOL isFinished) {
        respenseBlock(webData,isFinished);
    }];
}

- (void)postWithParams:(NSDictionary *)params requestCompleted:(DataCompletionBlock)respenseBlock
{
    [self postWithUrl:self.url params:params completed:^(id webData, BOOL isFinished) {
        respenseBlock(webData,isFinished);
    }];
}

- (void)cancelRequest
{
//    HYBURLSessionTask *task;
//    [task cancelRequest];
}

+ (void)cancelRequestWithUrl:(NSString *)url
{
    [HYBNetworking cancelRequestWithURL:url];
}

+ (void)cancelRequestAll
{
    [HYBNetworking cancelAllRequest];
}






- (HYBURLSessionTask *)postWithUrl:(NSString*)url params:(id )params completed:(DataCompletionBlock)successBlock
{
    NSDictionary *paramDic;
    if ([params isKindOfClass:[LHBaseRequest class]]) {
        paramDic = [(LHBaseRequest*)(params) getParams];
    }else{
        paramDic = [params copy];
    }
    
    url = [NSString stringWithFormat:@"http://test.weldo.cn/index.php?r=%@",url];
    //获取当前时间戳
    NSDate *nowDate = [NSDate date];
    NSString *timeStr = [NSString stringWithFormat:@"%.f",[nowDate timeIntervalSince1970]];
    
    NSMutableDictionary *mp = @{}.mutableCopy;
    [mp setValue:timeStr forKey:@"_timestamp"];
    
    [mp addEntriesFromDictionary:paramDic];
    
    
    
    HYBURLSessionTask *task = [HYBNetworking postWithUrl:url refreshCache:NO params:mp.copy success:^(id response) {
        if([response isKindOfClass:[NSDictionary class]]){
            NSString *successStr = response[@"success"];
            if(successStr.boolValue){
                successBlock(response[@"data"],YES);
            }else{
                NSString *messageStr = response[@"message"];
                
                successBlock(messageStr,NO);
            }
        }else{
            successBlock(response,NO);
        }
    } fail:^(NSError *error) {
        successBlock(error,NO);
    }];
    
    return task;

}
@end



