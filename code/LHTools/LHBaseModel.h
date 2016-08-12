//
//  ModelParent.h
//  Memedia
//
//  Created by Kyle01 Kang on 15/10/16.
//  Copyright © 2015年 ME. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LHBaseModel : NSObject<NSCoding,NSCopying>

-(instancetype)initModelWithDic:(NSDictionary*)dic;

+(instancetype)createModelWithDic:(NSDictionary*)dic;

+(instancetype)createDefaultValuesModelWithDic:(NSDictionary *)dic;

+(instancetype)createModelDefaultEmpty;

-(void)setModelWithDic:(NSDictionary*)dic;

+(NSMutableArray *)creatArrayModelWithArray:(NSArray*)arr;

-(NSMutableDictionary *)convertFromObject;

-(NSMutableDictionary *)convertFromObjectIgnoredKeys:(NSArray *)keys;

@end

@interface NSObject(LHModel)

@end