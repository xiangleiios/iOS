//
//  FMLoginViewController.m
//  MobileProject
//
//  Created by Mingoy on 16/10/10.
//  Copyright © 2016年 Mingoy. All rights reserved.
//

#import "FMLoginViewController.h"
#import "FMShare.h"

@interface FMLoginViewController()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic,strong) NSArray             *dataArray;
@property (nonatomic,strong) UITableView         *myTableView;
@end

@implementation FMLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"第三方登录跟获取用户信息功能";
    
    if (!self.dataArray) {
        self.dataArray=@[@"QQ登录",@"新浪登录",@"微信登录",@"",@"QQ获得用户信息",@"新浪获得用户信息",@"微信获得用户信息",@"",@"QQ登录后取消授权",@"新浪登录后取消授权",@"微信登录后取消授权"];
    }
    
    //初始化表格
    if (!_myTableView) {
        _myTableView                                = [[UITableView alloc] initWithFrame:CGRectMake(0,0.5, kScreenW, kScreenH) style:UITableViewStylePlain];
        _myTableView.showsVerticalScrollIndicator   = NO;
        _myTableView.showsHorizontalScrollIndicator = NO;
        _myTableView.dataSource                     = self;
        _myTableView.delegate                       = self;
        [_myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        [self.view addSubview:_myTableView];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource, UITableViewDelegate相关内容

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    cell.accessoryType    = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text   = self.dataArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    __weak typeof(self)weakSelf = self;
    switch (indexPath.row) {
        case 0:
        {
            if(![FMPlatformHelper installPlatAppWithType:FMSocialPlatformType_QQ])
            {
                [weakSelf showResult:@"没有安装QQ软件,将此功能隐藏"];
                return;
            }
            
            [FMPlatformHelper authWithPlatform:FMSocialPlatformType_QQ withCompletion:^(NSString *uid, NSString *openid,NSString *accessToken, NSError *error) {
                if (error) {
                    NSLog(@"出错了");
                    return;
                }
                
                NSString *result=[NSString stringWithFormat:@"获得到的值为：uid:%@--token:%@--openid:%@",uid,accessToken,openid];
                [weakSelf showResult:result];
            }];
            break;
        }
        case 1:
        {
            NSLog(@"新浪登录 要把程序的Bundle ID跟回调页面都对应上才可以，否则会出现弹出又马上消失的情况，可以用官网的Bundle ID测试");
            
            [FMPlatformHelper authWithPlatform:FMSocialPlatformType_Sina withCompletion:^(NSString *uid, NSString *openid, NSString *accessToken, NSError *error) {
                if (error) {
                    NSLog(@"出错了,%@",error);
                    return;
                }
                
                NSString *result=[NSString stringWithFormat:@"获得到的值为：uid:%@--token:%@",uid,accessToken];
                [weakSelf showResult:result];
            }];
            break;
        }
        case 2:
        {
            [FMPlatformHelper authWithPlatform:FMSocialPlatformType_WechatSession withCompletion:^(NSString *uid, NSString *openid, NSString *accessToken, NSError *error) {
                if (error) {
                    NSLog(@"出错了");
                    return;
                }
                
                NSString *result=[NSString stringWithFormat:@"获得到的值为：uid:%@--token:%@--openid:%@",uid,accessToken,openid];
                [weakSelf showResult:result];
            }];
            break;
        }
        case 4:
        {
            [FMPlatformHelper getUserInfoWithPlatform:FMSocialPlatformType_QQ withCompletion:^(UMSocialUserInfoResponse *userinfo,NSString *name, NSString *iconUrl, NSString *gender, NSError *error) {
                if (error) {
                    NSLog(@"出错了");
                    return;
                }
                
                NSString *result=[NSString stringWithFormat:@"获得到的值为：name:%@--性别:%@",name,gender];
                [weakSelf showResult:result];

            }];
            break;
        }
        case 5:
        {
            [FMPlatformHelper getUserInfoWithPlatform:FMSocialPlatformType_Sina withCompletion:^(UMSocialUserInfoResponse *userinfo,NSString *name, NSString *iconUrl, NSString *gender, NSError *error) {
                if (error) {
                    NSLog(@"出错了,%@",error);
                    return;
                }
                
                NSString *result=[NSString stringWithFormat:@"获得到的值为：name:%@--性别:%@",name,gender];
                [weakSelf showResult:result];
                
            }];
            break;
        }
        case 6:
        {
            [FMPlatformHelper getUserInfoWithPlatform:FMSocialPlatformType_WechatSession withCompletion:^(UMSocialUserInfoResponse *userinfo,NSString *name, NSString *iconUrl, NSString *gender, NSError *error) {
                if (error) {
                    NSLog(@"出错了");
                    return;
                }
                
                NSString *result=[NSString stringWithFormat:@"获得到的值为：name:%@--性别:%@",name,gender];
                [weakSelf showResult:result];
                
            }];
            break;
        }
        case 8:
        {
            [FMPlatformHelper cancelAuthWithPlatform:FMSocialPlatformType_QQ withCompletion:^(id result, NSError *error) {
                if (error) {
                    NSLog(@"出错了");
                    return;
                }
                
                NSString *ressult=@"取消成功";
                [weakSelf showResult:ressult];
            }];
            break;
        }
        case 9:
        {
            [FMPlatformHelper cancelAuthWithPlatform:FMSocialPlatformType_Sina withCompletion:^(id result, NSError *error) {
                if (error) {
                    NSLog(@"出错了");
                    return;
                }
                
                NSString *ressult=@"取消成功";
                [weakSelf showResult:ressult];
            }];
            break;
        }
        case 10:
        {
            [FMPlatformHelper cancelAuthWithPlatform:FMSocialPlatformType_WechatSession withCompletion:^(id result, NSError *error) {
                if (error) {
                    NSLog(@"出错了");
                    return;
                }
                
                NSString *ressult=@"取消成功";
                [weakSelf showResult:ressult];
            }];
            break;
        }
        default:
            break;
    }
}


#pragma mark 自定义代码

- (void)showResult:(NSString *)result
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:result delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
    });
}

@end
