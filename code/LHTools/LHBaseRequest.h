//
//  BaseRequest.h
//  Memedia
//
//  Created by Kyle01 Kang on 15/12/11.
//  Copyright © 2015年 ME. All rights reserved.
//

#import <Foundation/Foundation.h>


//static NSString * const kRequestMethod_POST = @"POST";
//static NSString * const kRequestMethod_post = @"post";
//static NSString * const kRequestMethod_GET = @"GET";
//static NSString * const kRequestMethod_file = @"file";

typedef void (^DataCompletionBlock)(id webData,BOOL isFinished);

@interface LHBaseRequest : NSObject

@property (nonatomic, copy) NSString *url;

/**
 *  override subClass
 *
 *  @return  requestUrl
 */
-(NSString *)requestUrl;


+(instancetype)createWithParams:(NSDictionary*)params;

/**
 *  发送网络请求
 *
 *  @param respenseBlock 请求完成回调
 */
- (void)postRequestCompleted:(DataCompletionBlock)respenseBlock;
- (void)postWithParams:(NSDictionary *)params requestCompleted:(DataCompletionBlock)respenseBlock;

/**
 *  取消请求
 */
- (void)cancelRequest;

+ (void)cancelRequestWithUrl:(NSString *)url;

//- (void)cancelRequestGroupId:(NSString*)groupId;
//
+ (void)cancelRequestAll;
@end



