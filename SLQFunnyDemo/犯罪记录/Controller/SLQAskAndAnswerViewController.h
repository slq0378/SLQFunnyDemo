//
//  SLQAskAndAnswerViewController.h
//
//
//  Created by MrSong on 17/2/24.
//  Copyright © 2017年 Xiao. All rights reserved.

#import <UIKit/UIKit.h>
@class SLQAskAndAnswerModel;
typedef void(^GetAskAndAnserModelBlock)(SLQAskAndAnswerModel *model);

@interface SLQAskAndAnswerViewController : UIViewController
/**<#注释#>*/
@property (nonatomic, strong) SLQAskAndAnswerModel *askAndAnswerModel;

- (void)askAndAnserModelBlock:(GetAskAndAnserModelBlock )block;
@end
