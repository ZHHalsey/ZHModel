# ZHModel
完全自定义数据转模型框架

用法 : 
1 > 新建你的model类然后继承ZHModel
2 > 新建model中, 写入你的属性
3 > 然后调用对象方法就可直接解析

方法讲解:
1 > 
        /// 对象方法字典转模型(字典不包括系统关键字的话用这个)
        - (void)ZH_modelWithDictionary:(NSDictionary *)dic;
        用法 : 
        sonModel *model1 = [[sonModel alloc]init];
        [model1 ZH_modelWithDictionary:paraDic];
        
2 >
        /**
        *  对象方法字典转模型(字典包括系统关键字的话用这个去替换)
        * oldKey : 需要替换的数组key, 比如@[@"id", @"char"], 有几个就写几个
        * newKey : 自己写的替换成新的key, 比如@[@"myID", @"myChar"], 跟上面对应
        */
        - (void)ZH_modelWithDictionary:(NSDictionary *)dic withOldKeyArr:(NSArray *)oldKeyArr toNewKeyArr:(NSArray *)newKeyArr;
        用法 : 
        sonModel *model1 = [[sonModel alloc]init];
        [model1 ZH_modelWithDictionary:paraDic withOldKeyArr:@[@"id", @"char"] toNewKeyArr:@[@"myID", @"myChar"]];


        
        
        
        
