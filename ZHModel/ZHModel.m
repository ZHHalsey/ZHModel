//
//  ZHModel.m
//  ZHModel
//
//  Created by ZH on 2019/8/8.
//  Copyright © 2019 张豪. All rights reserved.
//  代码地址:https://github.com/ZHHalsey/ZHModel

#import "ZHModel.h"
#import <objc/runtime.h>

@implementation ZHModel

// 对象方法字典转模型(字典包括系统关键字的话用这个去替换)
- (void)ZH_modelWithDictionary:(NSDictionary *)dic withOldKeyArr:(NSArray *)oldKeyArr toNewKeyArr:(NSArray *)newKeyArr{
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList(self.class, &count);
    NSMutableArray *ivarArr = [[NSMutableArray alloc]initWithCapacity:0];
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        const char *IvarName = ivar_getName(ivar);
        [ivarArr addObject:[NSString stringWithFormat:@"%s", IvarName]];
    }
    NSMutableDictionary *mutableDic = [self replaceDic:dic withOldKeyArr:oldKeyArr toNewKeyArr:newKeyArr];
    for (int i = 0; i< ivarArr.count; i++) {
        ivarArr[i] = [ivarArr[i] substringFromIndex:1]; // 去下划线
        if ([mutableDic.allKeys containsObject:ivarArr[i]]) {
            [self ZH_setValue:mutableDic[ivarArr[i]] forKey:ivarArr[i]];
        }else{
            [self ZH_setValue:nil forKey:ivarArr[i]];
        }
    }
}
/// 对象方法字典转模型(字典不包括系统关键字)
- (void)ZH_modelWithDictionary:(NSDictionary *)dic{
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList(self.class, &count);
    NSMutableArray *ivarArr = [[NSMutableArray alloc]initWithCapacity:0];
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        const char *IvarName = ivar_getName(ivar);
        [ivarArr addObject:[NSString stringWithFormat:@"%s", IvarName]];
    }
    for (int i = 0; i< ivarArr.count; i++) {
        ivarArr[i] = [ivarArr[i] substringFromIndex:1]; // 去下划线
        if ([dic.allKeys containsObject:ivarArr[i]]) {
            [self ZH_setValue:dic[ivarArr[i]] forKey:ivarArr[i]];
        }else{
            [self ZH_setValue:nil forKey:ivarArr[i]];
        }
    }
}
- (void)ZH_setValue:(nullable id)value forKey:(NSString *)key{

    if (key == nil || key.length == 0) {
        NSLog(@"传入的key为nil或者key长度为0");
        return;
    }
    [self setValue:value forKey:key];
    NSString *setKey = [NSString stringWithFormat:@"set%@:", key.capitalizedString];
    NSString *setIsKey = [NSString stringWithFormat:@"setIs%@:", key.capitalizedString];

    if([self respondsToSelector:NSSelectorFromString(setKey)]){
        [self performSelector:NSSelectorFromString(setKey) withObject:value];
        return;
    }
    if([self respondsToSelector:NSSelectorFromString(setIsKey)]){
        [self performSelector:NSSelectorFromString(setIsKey) withObject:value];
        return;
    }
    if (![self.class accessInstanceVariablesDirectly]){
        // 异常
        NSException *exception = [NSException exceptionWithName:@"ZH_EXCEPTION" reason:[NSString stringWithFormat:@"你没有实现这个key:'%@'的setter方法, 而且你还不允许访问成员变量", key] userInfo:nil];
        @throw exception;
        return;
    }
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList(self.class, &count);
    NSMutableArray *ivarArr = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        const char *bianlaing_name = ivar_getName(ivar);
        [ivarArr addObject:[NSString stringWithFormat:@"%s", bianlaing_name]];
    }
    for (int i = 0; i < count; i++) {
        NSString *keyName = ivarArr[i];
        Ivar ivar = ivars[i];
        if ([keyName isEqualToString:[NSString stringWithFormat:@"_%@", key]]) {
            object_setIvar(self, ivar, value);
            free(ivars);
            return;
        }
    }
    for (int i = 0; i < count; i++) {
        NSString *keyName = ivarArr[i];
        Ivar ivar = ivars[i];
        if ([keyName isEqualToString:[NSString stringWithFormat:@"_is%@", key.capitalizedString]]) {
            object_setIvar(self, ivar, value);
            free(ivars);
            return;
        }
    }
    for (int i = 0; i < count; i++) {
        NSString *keyName = ivarArr[i];
        Ivar ivar = ivars[i];
        if ([keyName isEqualToString:[NSString stringWithFormat:@"%@", key]]) {
            object_setIvar(self, ivar, value);
            free(ivars);
            return;
        }
    }
    for (int i = 0; i < count; i++) {
        NSString *keyName = ivarArr[i];
        Ivar ivar = ivars[i];
        if ([keyName isEqualToString:[NSString stringWithFormat:@"is%@", key.capitalizedString]]) {
            object_setIvar(self, ivar, value);
            free(ivars);
            return;
        }
    }
    [self setValue:value forUndefinedKey:key];
    free(ivars);
}
// 更换字典的key(删除原有键值对, 添加新键值对)
- (NSMutableDictionary *)replaceDic:(NSDictionary *)dic withOldKeyArr:(NSArray *)oldKeyWordArr toNewKeyArr:(NSArray *)newKeyWordArr{
    NSMutableDictionary *mutableDic = [dic mutableCopy];
    for (int i = 0; i < mutableDic.allKeys.count; i++) {
        for (int j = 0; j < oldKeyWordArr.count; j++) {
            if ([mutableDic.allKeys[i] isEqualToString:oldKeyWordArr[j]]) {
                NSString *value = mutableDic[oldKeyWordArr[j]];
                [mutableDic removeObjectForKey:oldKeyWordArr[j]];
                [mutableDic setObject:value forKey:newKeyWordArr[j]];
            }
        }
    }
    return mutableDic;
}


@end
