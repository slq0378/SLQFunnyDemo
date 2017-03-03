//
//  SLQAskAndAnswerViewController.m
//
//
//  Created by MrSong on 17/2/24.
//  Copyright © 2017年 Xiao. All rights reserved.
#import "SLQAskAndAnswerViewController.h"
#import "SLQAskAndAnswerModel.h"
#import "SLQSelectAskAndAnswerInfoController.h"
#import "SLQPrecompile.h"


@interface SLQAskAndAnswerViewController ()
///提问view
@property (nonatomic, strong) UIView  *askView;
/**回答view*/
@property (nonatomic, strong) UIView *answerView;

///提问view
@property (nonatomic, strong) UITextView  *askTextView;
/**回答view*/
@property (nonatomic, strong) UITextView *answerTextView;
/**<#注释#>*/
@property (nonatomic, copy) GetAskAndAnserModelBlock getDataBlock;


/**keyid*/
@property (nonatomic, strong) NSString *keyid;
@end

@implementation SLQAskAndAnswerViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.title = @"问答";
//    [self replaceRightButtonImage:nil Title:@"保存" clickSEL:@selector(saveData)];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveData)];
    self.navigationItem.rightBarButtonItems = @[rightButton];
    [self initData];
    [self initUI];
}

#pragma mark - 初始化
- (void)initData {
    self.keyid = [self uuid];
}

- (NSString*)uuid
{
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    
    return [result stringByReplacingOccurrencesOfString:@"-" withString:@""];
}


- (void)initUI{
    [self.view addSubview:self.askView];
    [self.view addSubview:self.answerView];
}
- (NSString *)getCurrentDate {
    // 设置当前时间
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    dateformatter.dateFormat = @"YYYY-MM-dd HH:mm:ss";
    NSDate *currentDate = [NSDate date];
    NSString *createTime = [dateformatter stringFromDate:currentDate];
    return createTime;
}
- (void)saveData{
    NSLog(@"saveData");
    SLQAskAndAnswerModel *mod = [[SLQAskAndAnswerModel alloc] init];
    if (self.askAndAnswerModel) {
        mod.keyid = self.askAndAnswerModel.keyid;
        mod.createTime = self.askAndAnswerModel.createTime;
    }else {
        mod.keyid = self.keyid;
        mod.createTime = [self getCurrentDate];
    }
    mod.ask = self.askTextView.text?:@"";
    mod.answer = self.answerTextView.text?:@"";
    
    self.getDataBlock(mod);
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)askBtnClick {
    NSLog(@"ask");
    SLQSelectAskAndAnswerInfoController *vc = [SLQSelectAskAndAnswerInfoController new];
    vc.controllerType = SLQSelectAskAndAnswerInfoControllerTypeAsk;
    vc.view.backgroundColor = [UIColor whiteColor];
    __weak typeof (self)weakSelf = self;
    [vc getInfoBlock:^(NSString *type, NSString *info) {
        if ([type isEqualToString:@"1"]) {
            weakSelf.askTextView.text = info;
        }else {
            weakSelf.answerTextView.text = info;
        }
    }];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)answerBtnClick {
    NSLog(@"answer");
    SLQSelectAskAndAnswerInfoController *vc = [SLQSelectAskAndAnswerInfoController new];
    vc.controllerType = SLQSelectAskAndAnswerInfoControllerTypeAnswer;
    vc.view.backgroundColor = [UIColor whiteColor];
    __weak typeof (self)weakSelf = self;
    [vc getInfoBlock:^(NSString *type, NSString *info) {
        if ([type isEqualToString:@"1"]) {
            weakSelf.askTextView.text = info;
        }else {
            weakSelf.answerTextView.text = info;
        }
    }];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)setAskAndAnswerModel:(SLQAskAndAnswerModel *)askAndAnswerModel {
    _askAndAnswerModel = askAndAnswerModel;
    
    self.askTextView.text = askAndAnswerModel.ask ? :@"";
    self.answerTextView.text = askAndAnswerModel.answer ? :@"";
}

- (void)askAndAnserModelBlock:( GetAskAndAnserModelBlock )block {
    
    if (block) {
        self.getDataBlock = block;
    }
}
#pragma mark -
- (UIView *)askView {
    if (!_askView) {
        _askView = [[UIView alloc] initWithFrame:CGRectMake(0, 64 + 5, ScreenWidth,200)];
        //_rightView.backgroundColor = [UIColor redColor];
        UIButton *askBtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 100, 44 * KHeightScale)];
        askBtn.tag = 646;
        [askBtn setTitle:@"提问" forState:UIControlStateNormal];
        [askBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [askBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [askBtn setBackgroundColor:RGBCOLOR(38, 171, 40)];
        askBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize];
        [askBtn addTarget:self action:@selector(askBtnClick) forControlEvents:UIControlEventTouchUpInside];
        askBtn.layer.masksToBounds = YES;
        askBtn.layer.cornerRadius = 8;
        [_askView addSubview:askBtn];
        
        UITextView *askTextView = [[UITextView alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(askBtn.frame) + 5, ScreenWidth - 10, 200)];
        self.askTextView = askTextView;
        [_askView addSubview:askTextView];
        askTextView.layer.masksToBounds = YES;
        askTextView.layer.cornerRadius = 8;
        askTextView.layer.borderWidth = 1;
        askTextView.layer.borderColor = [UIColor grayColor].CGColor;
        askTextView.text = @"";
        askTextView.font = [UIFont systemFontOfSize:FontSize];
        
        // _placeholderLabel
        UILabel *placeHolderLabel = [[UILabel alloc] init];
        placeHolderLabel.text = @"问:";
        placeHolderLabel.numberOfLines = 0;
        placeHolderLabel.textColor = [UIColor lightGrayColor];
        [placeHolderLabel sizeToFit];
        [askTextView addSubview:placeHolderLabel];
        
        [askTextView setValue:placeHolderLabel forKey:@"_placeholderLabel"];
        
        _askView.frame = CGRectMake(0, NavigationBarHeight + 5, ScreenWidth, CGRectGetMaxY(askTextView.frame));
    }
    return _askView;
}

- (UIView *)answerView {
    if (!_answerView) {
        _answerView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.askView.frame), ScreenWidth, 200)];
        UIButton *answerBtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 100, 44 * KHeightScale)];
        answerBtn.tag = 645;
        [answerBtn setTitle:@"回答" forState:UIControlStateNormal];
        [answerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [answerBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [answerBtn setBackgroundColor:RGBCOLOR(222, 222, 222)];
        answerBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize];
        [answerBtn addTarget:self action:@selector(answerBtnClick) forControlEvents:UIControlEventTouchUpInside];
        answerBtn.layer.masksToBounds = YES;
        answerBtn.layer.cornerRadius = 8;

        [_answerView addSubview:answerBtn];
        
        UITextView *answerTextView = [[UITextView alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(answerBtn.frame) + 5, ScreenWidth - 10, 200)];
        self.answerTextView = answerTextView;
        answerTextView.layer.masksToBounds = YES;
        answerTextView.layer.cornerRadius = 8;
        answerTextView.layer.borderWidth = 1;
        answerTextView.layer.borderColor = [UIColor grayColor].CGColor;
        [_answerView addSubview:answerTextView];
        answerTextView.text = @"";
        answerTextView.font = [UIFont systemFontOfSize:FontSize];
        
        // _placeholderLabel
        UILabel *placeHolderLabel = [[UILabel alloc] init];
        placeHolderLabel.text = @"答:";
        placeHolderLabel.numberOfLines = 0;
        placeHolderLabel.textColor = [UIColor lightGrayColor];
        [placeHolderLabel sizeToFit];
        [answerTextView addSubview:placeHolderLabel];
        
        [answerTextView setValue:placeHolderLabel forKey:@"_placeholderLabel"];
        
        _answerView.frame = CGRectMake(0, CGRectGetMaxY(self.askView.frame), ScreenWidth, CGRectGetMaxY(answerTextView.frame));
    }
    return _answerView;
}
@end
