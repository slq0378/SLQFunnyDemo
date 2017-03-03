//
//  SLQAskAndAnswerCell.m
//
//
//  Created by MrSong on 17/2/24.
//  Copyright © 2017年 Xiao. All rights reserved.

#import <UIKit/UIKit.h>
@class SLQAskAndAnswerModel;

@interface SLQAskAndAnswerCell : UITableViewCell

@property (nonatomic,strong) SLQAskAndAnswerModel *askAndAnswerModel;

///提问view
@property (nonatomic, strong) UILabel  *ask;
/**回答view*/
@property (nonatomic, strong) UILabel *answer;

///提问背景view
@property (nonatomic, strong) UIView  *askBackground;
/**回答背景view*/
@property (nonatomic, strong) UIView *answerBackground;
///提问view
@property (nonatomic, strong) UILabel  *askLab;
/**回答view*/
@property (nonatomic, strong) UILabel *answerLab;

@end
