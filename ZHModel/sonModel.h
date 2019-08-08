//
//  sonModel.h
//  ZHModel
//
//  Created by ZH on 2019/8/8.
//  Copyright © 2019 张豪. All rights reserved.
//

#import "ZHModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface sonModel : ZHModel
/**
 字典 :
 @{@"banner_id":@"index",
 @"id":@"9ca614026f4b4ea592bae688420436fe",
 @"is_out_site":@"1",
 @"picture":@"/upload/20180803/77491533277527398.png",
 @"seq_num":@"1"
 };
 */
@property (nonatomic, copy)NSString *banner_id;
@property (nonatomic, copy)NSString *myID;
@property (nonatomic, copy)NSString *myChar;
@property (nonatomic, copy)NSString *is_out_site;
@property (nonatomic, copy)NSString *picture;
@property (nonatomic, copy)NSString *seq_num;
@property (nonatomic, copy)NSString *keyNil; // 字典中这个key不存在

@end

NS_ASSUME_NONNULL_END
