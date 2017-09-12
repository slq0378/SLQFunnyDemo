//
//  SLQSelectAskAndAnswerInfoController.h
//
//
//  Created by MrSong on 17/2/24.
//  Copyright © 2017年 Xiao. All rights reserved.
#import <UIKit/UIKit.h>
typedef void(^GetAskAndAnserInfoBlock)(NSString *type,NSString *info);

typedef NS_ENUM(NSUInteger, SLQSelectAskAndAnswerInfoControllerType) {
    SLQSelectAskAndAnswerInfoControllerTypeAsk,
    SLQSelectAskAndAnswerInfoControllerTypeAnswer
};

@interface SLQSelectAskAndAnswerInfoController : UIViewController

/**SLQSelectAskAndAnswerInfoControllerType*/
@property (nonatomic, assign) SLQSelectAskAndAnswerInfoControllerType controllerType;
- (void)getInfoBlock:(GetAskAndAnserInfoBlock )block;
@end
