//
//  DMToastViewController.m
//  MyAlertView封装
//
//  Created by DM_dsz on 2019/10/25.
//  Copyright © 2019 cctv-person. All rights reserved.
//

#import "DMToastViewController.h"
#import "DMProgressManager.h"
@interface DMToastViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) NSArray *toastArr;

@end

@implementation DMToastViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _toastArr = @[@"一行文字",@"多行文字",@"成功提示",@"失败提示",@"警告提示",@"外部配置错误提示",@"外部配置一行文字",@"超长文字提醒"];
    [self shareView];
    // Do any additional setup after loading the view.
}
- (void)shareView
{
    UITableView * table = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    [table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tableviewcell"];
    [self.view addSubview:table];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableviewcell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tableviewcell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld.%@",indexPath.row+1,_toastArr[indexPath.row]];
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _toastArr.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        [DMProgressManager DM_showHUDWithText:@"最长不超14个字"];
    }
    if (indexPath.row == 1) {
        [DMProgressManager DM_showHUDWithText:@"最长不超过14个字，如果超出14个字换行"];
    }
    if (indexPath.row == 2) {
        [DMProgressManager DM_showHUDWithSuccess:@"成功提示"];

    }
    if (indexPath.row == 3) {
        [DMProgressManager DM_showHUDWithError:@"错误提示"];
    }
    if (indexPath.row == 4) {
        [DMProgressManager DM_showHUDWithWarning:@"警告提示"];

    }if (indexPath.row == 5) {
        [DMProgressManager DM_showHUDWithState:^(DMProgressManager * _Nonnull make) {
            make.message(@"错误提示");
            make.hudState(DMProgressHUDStateTypeError);
        }];
        
    }if (indexPath.row == 6) {
        [DMProgressManager DM_showHUDWithState:^(DMProgressManager * _Nonnull make) {
            make.message(@"最长不超14个字");
        }];
        
    } if (indexPath.row == 7) {
        [DMProgressManager DM_showHUDWithText:@"据刘向《说苑·善说》记载：春秋时代，楚王母弟鄂君子皙在河中游玩，钟鼓齐鸣。摇船者是位越人，趁乐声刚停，便抱双桨用越语唱了一支歌。鄂君子皙听不懂，叫人翻译成楚语。就是上面的歌谣。歌中唱出了越人对子皙的那种深沉真挚的爱恋之情，歌词声义双关，委婉动听。是中国最早的译诗，也是古代楚越文化交融的结晶和见证。"];
    }
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
