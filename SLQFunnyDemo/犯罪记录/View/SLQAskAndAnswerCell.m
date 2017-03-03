//
//  SLQAskAndAnswerCell.m
//
//
//  Created by MrSong on 17/2/24.
//  Copyright © 2017年 Xiao. All rights reserved.

#import "SLQAskAndAnswerCell.h"
#import "SLQAskAndAnswerModel.h"

#import "SLQPrecompile.h"
#import <CoreText/CoreText.h>
@implementation SLQAskAndAnswerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel *ask = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 30, 44)];
        ask.text = @"问:";
        ask.font = [UIFont boldSystemFontOfSize:FontSize];
        [self.contentView addSubview:ask];
        self.ask = ask;
        self.askBackground = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.ask.frame), ask.frame.origin.y, ScreenWidth - CGRectGetMaxX(self.ask.frame)-10, 50)];
        self.askBackground.backgroundColor = RGBCOLOR(248, 248, 248);
        self.askBackground.layer.masksToBounds = YES;
        self.askBackground.layer.cornerRadius = 8;
        [self.contentView addSubview:self.askBackground];
        
        UILabel *askLab = [[UILabel alloc] initWithFrame:CGRectMake(self.askBackground.frame.origin.x + 5, self.askBackground.frame.origin.y + 5, self.askBackground.frame.size.width - 10, self.askBackground.frame.size.height - 10)];
        self.askLab = askLab;
        [self.contentView addSubview:askLab];
        askLab.text = @"问:";
        askLab.font = [UIFont systemFontOfSize:FontSize];
        askLab.textColor = [UIColor blackColor];
        askLab.numberOfLines = 0;
//        askLab.backgroundColor = RGBCOLOR(255, 255, 255);
//        askLab.layer.borderWidth = 1;
//        askLab.layer.borderColor = [UIColor grayColor].CGColor;
        
        
        UILabel *answer = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth - 40, CGRectGetMaxX(self.askLab.frame) + 5, 30, 44)];
        answer.text = @":答";
        answer.textAlignment = NSTextAlignmentRight;
        answer.font = [UIFont boldSystemFontOfSize:FontSize];
        [self.contentView addSubview:answer];
        self.answer = answer;
        
        self.answerBackground = [[UIView alloc] initWithFrame:CGRectMake(30, answer.frame.origin.y, ScreenWidth - 40-30, 50)];
        self.answerBackground.backgroundColor = RGBCOLOR(156, 253, 11);
        self.answerBackground.layer.masksToBounds = YES;
        self.answerBackground.layer.cornerRadius = 8;
        [self.contentView addSubview:self.answerBackground];
        
        UILabel *answerLab = [[UILabel alloc] initWithFrame:CGRectMake(self.answerBackground.frame.origin.x + 5 , self.answerBackground.frame.origin.y + 5, self.answerBackground.frame.size.width - 10, self.answerBackground.frame.size.height - 10)];
        self.answerLab = answerLab;
        [self.contentView addSubview:answerLab];
        answerLab.text = @"答:";
        answerLab.textColor = [UIColor blackColor];
        answerLab.font = [UIFont systemFontOfSize:FontSize];
        answerLab.numberOfLines = 0;
    
        //        answerLab.backgroundColor = RGBCOLOR(156, 253, 11);
//        answerLab.layer.borderWidth = 1;
//        answerLab.layer.borderColor = [UIColor grayColor].CGColor;
        self.frame = CGRectMake(0, 0, ScreenWidth, CGRectGetMaxY(answerLab.frame));
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        self.layer.borderWidth = 1.0;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 10;
//        self.backgroundColor = [UIColor orangeColor];
    }
    return self;
}

- (void)setAskAndAnswerModel:(SLQAskAndAnswerModel *)askAndAnswerModel {
    _askAndAnswerModel = askAndAnswerModel;
    self.askLab.text = [NSString stringWithFormat:@"%@",askAndAnswerModel.ask];
    self.answerLab.text = [NSString stringWithFormat:@"%@",askAndAnswerModel.answer];
    CGSize size1 = [self sizeString:self.askLab.text WithFont:[UIFont systemFontOfSize:FontSize] constrainedToSize:CGSizeMake(self.askLab.frame.size.width, MAXFLOAT)];
    CGSize size2 = [self sizeString:self.answerLab.text WithFont:[UIFont systemFontOfSize:FontSize] constrainedToSize:CGSizeMake(self.answerLab.frame.size.width , MAXFLOAT)];
    
    NSLog(@"");
    self.ask.frame = CGRectMake(10, 0, 30, 44);
    self.askBackground.frame =  CGRectMake(CGRectGetMaxX(self.ask.frame), self.ask.frame.origin.y, self.askBackground.frame.size.width, (size1.height) > 44 ?size1.height + 10:44 + 10);
    self.askLab.frame = CGRectMake(self.askBackground.frame.origin.x + 5, self.askBackground.frame.origin.y + 5, self.askBackground.frame.size.width - 10, (size1.height) > 44 ?size1.height :44);
    
    self.answer.frame = CGRectMake(ScreenWidth - 44, CGRectGetMaxY(self.askBackground.frame) + 5, 30, 44);
    self.answerBackground.frame =  CGRectMake(30, self.answer.frame.origin.y, self.answerBackground.frame.size.width, (size2.height) > 44 ?size2.height + 10:44+10);
    self.answerLab.frame = CGRectMake(self.answerBackground.frame.origin.x + 5 , self.answerBackground.frame.origin.y + 5, self.answerBackground.frame.size.width - 10, (size2.height) > 44 ?size2.height:44);

    
    self.frame = CGRectMake(0, 0, ScreenWidth,CGRectGetMaxY(self.answerBackground.frame));
    
}
#pragma mark - 计算文本size
- (CGSize)sizeString:(NSString *)string WithFont:(UIFont *)font constrainedToSize:(CGSize)size {
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:font ,kCTFontAttributeName, nil];
    return [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin  attributes:dic context:nil].size;
}
@end
