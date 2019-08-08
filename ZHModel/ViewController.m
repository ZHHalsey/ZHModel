//
//  ViewController.m
//  ZHModel
//
//  Created by ZH on 2019/8/8.
//  Copyright © 2019 张豪. All rights reserved.
//

#import "ViewController.h"
#import "sonModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary *paraDic = @{@"banner_id":@"index",
        @"id":@"9ca614026f4b4ea592bae688420436fe",
        @"is_out_site":@"1",
        @"picture":@"/upload/20180803/77491533277527398.png",
        @"seq_num":@"1",
        @"char":@"哈哈哈"
    };
    
    // Demo
    sonModel *model1 = [[sonModel alloc]init];
//    [model1 ZH_modelWithDictionary:paraDic];
    [model1 ZH_modelWithDictionary:paraDic withOldKeyArr:@[@"id", @"char"] toNewKeyArr:@[@"myID", @"myChar"]];

    NSLog(@"model--%@, model.banner_id--%@, model.picture--%@, model.id--%@, model.char--%@, model.keyNil--%@", model1, model1.banner_id, model1.picture, model1.myID, model1.myChar, model1.keyNil);

    
}


@end
