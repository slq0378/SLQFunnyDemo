//
//  SLQAskAndAnswerModel.h
//
//
//  Created by MrSong on 17/2/24.
//  Copyright © 2017年 Xiao. All rights reserved.

#import <Foundation/Foundation.h>

@interface SLQAskAndAnswerModel : NSObject
/// 主键编号
@property (nonatomic, copy) NSString *keyid;
/// 提问
@property (nonatomic, copy) NSString *ask;
/// 回答
@property (nonatomic, copy) NSString *answer;

/// 创建时间
@property (nonatomic, copy) NSString *createTime;
@end
