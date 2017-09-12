//
//  SLQSelectAskAndAnswerInfoController.m
//
//
//  Created by MrSong on 17/2/24.
//  Copyright © 2017年 Xiao. All rights reserved.
#import <CoreText/CoreText.h>
#import "SLQSelectAskAndAnswerInfoController.h"
#import "SLQPrecompile.h"

@interface SLQSelectAskAndAnswerInfoController ()<
UITableViewDelegate,
UITableViewDataSource
>
/**问答消息*/
@property (nonatomic, strong) UITableView *tableView;
/**问答数组*/
@property (nonatomic, strong) NSMutableArray *askAndAnswerArray;
/**<#注释#>*/
@property (nonatomic, copy) GetAskAndAnserInfoBlock infoBlock;
@end

@implementation SLQSelectAskAndAnswerInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    
    if (self.controllerType == SLQSelectAskAndAnswerInfoControllerTypeAsk) {
        self.title = @"提问模板";
    }else {
        self.title = @"回答模板";
    }
}

- (void)getInfoBlock:(GetAskAndAnserInfoBlock )block {
    if (block) {
        self.infoBlock = block;
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.askAndAnswerArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SLQSelectAskAndAnswerInfoControllerCell"];
    //    cell.delegate = self;
    //    cell.index = self.askAndAnswerArray.count - indexPath.row;
    NSString *info = self.askAndAnswerArray[indexPath.row];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.text = info;
    cell.textLabel.font = [UIFont systemFontOfSize:FontSize];
    CGSize size = [self sizeString:info WithFont:[UIFont systemFontOfSize:FontSize] constrainedToSize:CGSizeMake(ScreenWidth - RowHeight, MAXFLOAT)];
    cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width, size.height > RowHeight?size.height:RowHeight);
    //
    return cell;
}

- (CGSize)sizeString:(NSString *)string WithFont:(UIFont *)font constrainedToSize:(CGSize)size {
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:font ,kCTFontAttributeName, nil];
    return [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin  attributes:dic context:nil].size;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *info = self.askAndAnswerArray[indexPath.row];
    if (self.controllerType == SLQSelectAskAndAnswerInfoControllerTypeAsk) {
        self.infoBlock(@"1",info);
    }else {
        self.infoBlock(@"2",info);
    }
    [self.navigationController popViewControllerAnimated:YES];
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableView *)tableView {
    if(!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 0) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.backgroundColor = RGBCOLOR(251, 249, 254);
        _tableView.estimatedRowHeight = RowHeight;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"SLQSelectAskAndAnswerInfoControllerCell"];
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}

- (NSMutableArray *)askAndAnswerArray
{
    if (!_askAndAnswerArray) {
        _askAndAnswerArray = [[NSMutableArray alloc] init];
        if (self.controllerType == SLQSelectAskAndAnswerInfoControllerTypeAsk) {
            [_askAndAnswerArray addObjectsFromArray:@[@"叫什么？",@"年龄多少？",@"职业是什么？",@"现住址是哪里？",@"户籍所在地是哪里？",@"把你犯罪过程描述一下"]];
        }else {
            [_askAndAnswerArray addObjectsFromArray:@[@"张三",@"我今年23",@"无业有名",@"佛山南海",@"广州琶洲",@"作为国内1T系统集成和软件领域领潮者的托普集团,一直致力于通信产品创新,近期强势推出了v60彩屏系列手机,预示着托普集团在手机领域将发起一轮强到i玫势‘ v阶系列是面对崇尚生活品位、追求个性生活的职业人士推出的彩屏手机,因此在外形设计上颇费心思、用细节勾勒出男女式样的不同,V60A是男款手机,燕瓷燕冬穿岌黑默瑜豆屏,纂耀豁毛耀覃糕』馨狱饥纂宝翼鳍:答鱿冀筑{:::内置了多种精美的待机图片和动画‘井提供网络下载功能以达到个性化的设置‘ 据悉,v6。系冽手扒是托普公司和国外奢名手机企业合作打造的一组精品,也是该著名手机企业同期推出的手机品牌中的极品,其极致品位的联袂演出值得期待。(文/D DD)印V(联袂激情 托普V60@DDD 作为国内IT系统集成和软件领域领潮者的托普集团,一直致力于通信产品创新,近期强势推出了V60彩屏系列手机,预示着托普集团在手机领域将发起一轮强劲攻势。"]];
        }
    }
    return  _askAndAnswerArray;
}
@end
