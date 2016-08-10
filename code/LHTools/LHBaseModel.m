//
//  ModelParent.m
//  Memedia
//
//  Created by Kyle01 Kang on 15/10/16.
//  Copyright © 2015年 ME. All rights reserved.
//

#import "LHBaseModel.h"
#import "MJExtension.h"

@implementation LHBaseModel

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        [self mj_decode:decoder];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [self mj_encode:encoder];
}

-(id)copyWithZone:(NSZone *)zone {
    typeof(self) copiedObj = [[[self class] allocWithZone:zone] init];
    if (copiedObj) {
        NSDictionary* properties = [[self class] propertiesForClass:[self class]];
        for (NSString* key in properties) {
            id val = [self valueForKey:key];
            [copiedObj setValue:val forKey:key];
        }
    }
    return copiedObj;
}

-(instancetype)initModelWithDic:(NSDictionary*)dic
{
    if (self = [super init]) {
        if ([dic isKindOfClass:[NSDictionary class]]) {
            [self mj_setKeyValues:dic];
        }
    }
    return self;
}

+(instancetype)createModelWithDic:(NSDictionary*)dic
{
    LHBaseModel *ins = nil;
    if ([dic isKindOfClass:[NSDictionary class]]) {
        ins = [self mj_objectWithKeyValues:dic];
    }
    return ins;
}

+(instancetype)createDefaultValuesModelWithDic:(NSDictionary *)dic
{
    LHBaseModel *ins = [self createModelDefaultEmpty];
    if ([dic isKindOfClass:[NSDictionary class]]) {
        [ins setModelWithDic:dic];
    }
    return ins;
}

-(void)setModelWithDic:(NSDictionary*)dic
{
    [self mj_setKeyValues:dic];
}

+(NSMutableArray *)creatArrayModelWithArray:(NSArray*)arr
{
    if (![arr isKindOfClass:[NSArray class]]) {
        return [NSMutableArray array];
    }
    NSMutableArray *resultArr = [self mj_objectArrayWithKeyValuesArray:arr];
    return resultArr;
}

+(instancetype)createModelDefaultEmpty
{
    LHBaseModel *ins = [self new];
    NSDictionary* properties = [[self class] propertiesForClass:[self class]];
    for (NSString* key in properties) {
        NSString *value = properties[key];
        NSLog(@"%@",value);
        if ([[value lowercaseString] rangeOfString:@"array"].length>0) {
            [ins setValue:@[] forKey:key];
        }else if([[value lowercaseString] rangeOfString:@"dic"].length>0){
            [ins setValue:@{} forKey:key];
        }else if([[value lowercaseString] rangeOfString:@"string"].length>0){
            [ins setValue:@"" forKey:key];
        }else if([[value lowercaseString] rangeOfString:@"q"].length>0){
            [ins setValue:@0 forKey:key];
        }else{
            [ins setValue:@"" forKey:key];
        }
    }
    return ins;
}

-(NSMutableDictionary *)convertFromObject
{
    return [self mj_keyValues];
}
-(NSMutableDictionary *)convertFromObjectIgnoredKeys:(NSArray *)keys
{
    return [self mj_keyValuesWithIgnoredKeys:keys];
}

#pragma mark - Get properties for a class
+ (NSDictionary *)propertiesForClass:(Class)cls
{
    if (cls == NULL) {
        return nil;
    }
    
    NSMutableDictionary *results = [[NSMutableDictionary alloc] init];
    
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(cls, &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char *propName = property_getName(property);
        if(propName) {
            const char *propType = getPropertyType(property);
            NSString *propertyName = [NSString stringWithUTF8String:propName];
            NSString *propertyType = [NSString stringWithUTF8String:propType];
            [results setObject:propertyType forKey:propertyName];
        }
    }
    free(properties);
    
    // returning a copy here to make sure the dictionary is immutable
    return [NSDictionary dictionaryWithDictionary:results];
}

static const char *getPropertyType(objc_property_t property) {
    const char *attributes = property_getAttributes(property);
    //printf("attributes=%s\n", attributes);
    char buffer[1 + strlen(attributes)];
    strcpy(buffer, attributes);
    char *state = buffer, *attribute;
    while ((attribute = strsep(&state, ",")) != NULL) {
        if (attribute[0] == 'T' && attribute[1] != '@') {
            // it's a C primitive type:
            /*
             if you want a list of what will be returned for these primitives, search online for
             "objective-c" "Property Attribute Description Examples"
             apple docs list plenty of examples of what you get for int "i", long "l", unsigned "I", struct, etc.
             */
            NSString *name = [[NSString alloc] initWithBytes:attribute + 1 length:strlen(attribute) - 1 encoding:NSASCIIStringEncoding];
            return (const char *)[name cStringUsingEncoding:NSASCIIStringEncoding];
        }
        else if (attribute[0] == 'T' && attribute[1] == '@' && strlen(attribute) == 2) {
            // it's an ObjC id type:
            return "id";
        }
        else if (attribute[0] == 'T' && attribute[1] == '@') {
            // it's another ObjC object type:
            NSString *name = [[NSString alloc] initWithBytes:attribute + 3 length:strlen(attribute) - 4 encoding:NSASCIIStringEncoding];
            return (const char *)[name cStringUsingEncoding:NSASCIIStringEncoding];
        }
    }
    return "";
}

@end
