//
//  SLQAskNoteViewController.m
//
//
//  Created by MrSong on 17/2/24.
//  Copyright © 2017年 Xiao. All rights reserved.

#import "SLQAskNoteViewController.h"
#import "SLQAskAndAnswerViewController.h"
#import "SLQAskAndAnswerCell.h"
#import "SLQAskAndAnswerModel.h"
#import "SLQPrecompile.h"


#define SLQAskAndAnswerCellID @"SLQAskAndAnswerCell"
@interface SLQAskNoteViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
/**新增按钮*/
@property (nonatomic, strong) UIButton *addButton;
/**问答消息*/
@property (nonatomic, strong) UITableView *tableView;
/**问答数组*/
@property (nonatomic, strong) NSMutableArray *askAndAnswerArray;
@end

@implementation SLQAskNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"犯罪记录";
    

    [self initData];
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}

#pragma mark - 初始化
- (void)initData {

}

- (void)initUI{
    [self.view addSubview:self.addButton];
    [self.view addSubview:self.tableView];
}




/**
 新增问答
 */
- (void)addBtnClick {
    NSLog(@"新增问答");
    SLQAskAndAnswerViewController *vc = [[SLQAskAndAnswerViewController alloc] init];
    vc.view.backgroundColor = [UIColor whiteColor];
    WEAKSELF
    [vc askAndAnserModelBlock:^(SLQAskAndAnswerModel *model) {
        [weakSelf.askAndAnswerArray addObject:model];
        [weakSelf.tableView reloadData];
    }];
    
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.askAndAnswerArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLQAskAndAnswerCell *cell = [tableView dequeueReusableCellWithIdentifier:SLQAskAndAnswerCellID];
//    cell.delegate = self;
//    cell.index = self.askAndAnswerArray.count - indexPath.row;
    SLQAskAndAnswerModel *model = self.askAndAnswerArray[indexPath.row];
    cell.askAndAnswerModel = model;
    
//    UILongPressGestureRecognizer *longGes = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
//    cell.userInteractionEnabled = YES;
//    [cell addGestureRecognizer:longGes];
//    
//    cell.uploadBtn.enabled = YES;
    //    if ([model.status isEqualToString:@"2"]) {
    //        cell.uploadBtn.enabled = NO;
    //    }
    //
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    SLQAskAndAnswerModel *askModel = self.askAndAnswerArray[indexPath.row];
    
    SLQAskAndAnswerViewController *vc = [[SLQAskAndAnswerViewController alloc] init];
    vc.view.backgroundColor = [UIColor whiteColor];
    WEAKSELF
    vc.askAndAnswerModel = askModel;
    [vc askAndAnserModelBlock:^(SLQAskAndAnswerModel *model) {
        [weakSelf.askAndAnswerArray replaceObjectAtIndex:indexPath.row withObject:model];
        [weakSelf.tableView reloadData];
    }];
    [self.navigationController pushViewController:vc animated:YES];
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark -

- (UIButton *)addButton {
    if (!_addButton) {
        _addButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 64, ScreenWidth-20,44)];
        _addButton.tag = 645;
        [_addButton setTitle:@"新增问答" forState:UIControlStateNormal];
        [_addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_addButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [_addButton setBackgroundColor:GREENCOLOR];
        _addButton.titleLabel.font = [UIFont systemFontOfSize:FontSize];
        [_addButton addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _addButton.layer.masksToBounds = YES;
        _addButton.layer.cornerRadius = 8;
    }
    return _addButton;
}

- (UITableView *)tableView {
    if(!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.addButton.frame) + 5, ScreenWidth, ScreenHeight - CGRectGetMaxY(self.addButton.frame) - 5) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = RGBCOLOR(251, 249, 254);
        _tableView.estimatedRowHeight = RowHeight;
        [_tableView registerClass:[SLQAskAndAnswerCell class] forCellReuseIdentifier:SLQAskAndAnswerCellID];
    }
    return _tableView;
}

- (NSMutableArray *)askAndAnswerArray
{
    if (!_askAndAnswerArray) {
        _askAndAnswerArray = [[NSMutableArray alloc] init];
    }
    return  _askAndAnswerArray;
}
@end
