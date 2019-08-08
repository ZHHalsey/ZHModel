//
//  ZHModel.h
//  ZHModel
//
//  Created by ZH on 2019/8/8.
//  Copyright © 2019 张豪. All rights reserved.

//  代码地址:https://github.com/ZHHalsey/ZHModel


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZHModel : NSObject

/// 对象方法字典转模型(字典不包括系统关键字)
- (void)ZH_modelWithDictionary:(NSDictionary *)dic;

/**
 * 对象方法字典转模型(字典包括系统关键字的话用这个去替换)
 * oldKey : 需要替换的数组key, 比如@[@"id", @"char"], 有几个就写几个
 * newKey : 自己写的替换成新的key, 比如@[@"myID", @"myChar"], 跟上面对应
 */
- (void)ZH_modelWithDictionary:(NSDictionary *)dic withOldKeyArr:(NSArray *)oldKeyArr toNewKeyArr:(NSArray *)newKeyArr;



@end

NS_ASSUME_NONNULL_END
