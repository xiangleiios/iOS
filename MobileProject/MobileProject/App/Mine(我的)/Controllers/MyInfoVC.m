//
//  MyInfoVC.m
//  MobileProject
//
//  Created by zsgy on 2017/10/30.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "MyInfoVC.h"
#import "ChangePhoVC.h"
#import "XLInformationV.h"
#import "ChangePasswordVC.h"
#import <CommonCrypto/CommonDigest.h>//MD5加密导入框架
@interface MyInfoVC ()<UIImagePickerControllerDelegate>
//@property (nonatomic , strong)XLMyNewsFunction *headerview;
@property (nonatomic , strong)XLInformationV *name;
@property (nonatomic , strong)UIImageView *HeadPortrait;
@end

@implementation MyInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationView setTitle:@"账户信息"];
    [self loadSubView];
//    [self loadfunctionbut];
    // Do any additional setup after loading the view.
}

- (void)loadSubView{
    
    self.HeadPortrait = [[UIImageView alloc] init];
    [self.view addSubview:self.HeadPortrait];
    [self.HeadPortrait mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(kNavBarH + KFit_H6S(20));
        make.right.mas_equalTo(self.view).mas_offset(-KFit_W6S(30));
        make.width.height.mas_equalTo(KFit_W6S(100));
    }];
    self.HeadPortrait.userInteractionEnabled = YES;
    self.HeadPortrait.layer.cornerRadius = KFit_W6S(50);
    self.HeadPortrait.layer.masksToBounds = YES;
    [self.HeadPortrait sd_setImageWithURL:[NSURL URLWithString:KURLIma([User UserOb].teamUserHead)] placeholderImage:[UIImage imageNamed:@"touxiang_nor"]];
    KKLog(@"%@",KURLIma([User UserOb].teamUserHead));
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeUp)];
    // 允许用户交互
    [self.HeadPortrait addGestureRecognizer:tap];
    
    
    UILabel *lbone = [[UILabel alloc] init];
    [self.view addSubview:lbone];
    lbone.text = @"我的头像";
    lbone.font = [UIFont systemFontOfSize:kFit_Font6(16)];
    [lbone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(30));
        make.centerY.mas_equalTo(self.HeadPortrait);
        make.height.mas_equalTo(KFit_H6S(30));
    }];
    
    UILabel *lb = [[UILabel alloc] init];
    [self.view addSubview:lb];
    lb.backgroundColor = kColor_N(240, 240, 240);
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.HeadPortrait.mas_bottom).mas_offset(KFit_H6S(20));
        make.height.mas_equalTo(1);
    }];
    
//    XLInformationV *name;
    if (USERFZR) {
        _name = [[XLInformationV alloc] informationWithTitle:@"登录账户" SubTitle:[User UserOb].mobile];
    }else{
        _name = [[XLInformationV alloc] informationWithTitle:@"登录账户" SubTitle:[User UserOb].mobile TSSubTitle:@"" Must:NO Click:YES];
        _name.senterBlock = ^{
            ChangePhoVC *vc = [[ChangePhoVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        };
    }
    [self.view addSubview:_name];
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lb.mas_bottom);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(KFit_H6S(90));
    }];
    
    XLInformationV *mima = [[XLInformationV alloc] informationWithTitle:@"登录密码" SubTitle:@"" TSSubTitle:@"修改密码" Must:NO Click:YES];
    [self.view addSubview:mima];
    mima.senterBlock = ^{
        ChangePasswordVC *vc = [[ChangePasswordVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    };
    [mima mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_name.mas_bottom);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(KFit_H6S(90));
    }];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _name.subfield.text = [User UserOb].mobile;
}
- (void)loadfunctionbut{
    UIButton *next = [[UIButton alloc] init];
    [self.view addSubview:next];
    [next setTitle:@"退出登录" forState:UIControlStateNormal];
    [next addTarget:self action:@selector(logOut:) forControlEvents:UIControlEventTouchUpInside];
    next.backgroundColor = kColor_N(0, 112, 234);
    [next setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    next.layer.cornerRadius = 5;
    next.layer.masksToBounds = YES;
    [next mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(70));
        make.right.mas_equalTo(self.view).mas_offset(-KFit_W6S(70));
        make.bottom.mas_equalTo(self.view).mas_offset(-KFit_W6S(40));
        make.height.mas_equalTo(KFit_H6S(90));
    }];
}
- (void)logOut:(UIButton *)sender{
    [[User UserOb] UserQuit];
    LoginVC *Loginvc = [[LoginVC alloc] init];
    AppDelegate *delegete = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIViewController *vc = delegete.window.rootViewController;
    delegete.window.rootViewController = Loginvc;
    vc = nil;
    [self presentViewController:Loginvc animated:YES completion:NULL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}







#pragma mark - 删除特殊字符

- (void)usernameDidChange:(UITextField *)username
{
    username.text = [self disable_emoji:username.text];
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"@／：；（）¥「」＂、[]{}#%-*+=_\\|~＜＞$€^•'@#$%^&*()_+'-/:;()¥&@\".,?!'[]{}#%^*+=_\\|~<>$£.,?!'\""];
    username.text = [username.text stringByTrimmingCharactersInSet:set];
}

- (NSString *)disable_emoji:(NSString *)text
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text
                                                               options:0
                                                                 range:NSMakeRange(0, [text length])
                                                          withTemplate:@""];
    return modifiedString;
}

- (void)changeUp{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"请选择添加途径" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //默认只有标题 没有操作的按钮:添加操作的按钮 UIAlertAction
    
    UIAlertAction *cancelBtn = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        //        NSLog(@"取消");
        [self PhotoLibrary];
    }];
    
    UIAlertAction *cancelBtXJ = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self xiangji];
        NSLog(@"取消");
        
    }];
    //添加确定
    UIAlertAction *sureBtn = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"确定");
        
    }];
    //设置`确定`按钮的颜色
    //    [sureBtn setValue:[UIColor redColor] forKey:@"titleTextColor"];
    //将action添加到控制器
    [alertVc addAction:cancelBtn];
    [alertVc addAction:cancelBtXJ];
    [alertVc addAction :sureBtn];
    //展示
    [self presentViewController:alertVc animated:YES completion:nil];
    
    
}


///
- (void)xiangji{
    UIImagePickerController * imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.mediaTypes = [NSArray arrayWithObject:(__bridge NSString *)kUTTypeImage];
    imagePickerController.delegate = self;
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIAlertView * alerr = [[UIAlertView alloc]initWithTitle:@"警告!" message:@"未找到该硬件设备或设备已损坏" delegate:self cancelButtonTitle:nil otherButtonTitles:@"我知道了", nil];
        [alerr show];
    }else{
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePickerController.allowsEditing = YES;
    }
    //利用模态进行调用系统框架
    [self.navigationController presentViewController:imagePickerController animated:YES completion:nil];
    
}
//照片库
- (void)PhotoLibrary{
    UIImagePickerController * imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.mediaTypes = [NSArray arrayWithObject:(__bridge NSString *)kUTTypeImage];
    imagePickerController.delegate = self;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.allowsEditing = YES;
    [self.navigationController presentViewController:imagePickerController animated:YES completion:nil];;
}

#pragma mark -相册代理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    KKLog(@"%@    ----- %@",picker,info);
    [self uploadPictures:info[UIImagePickerControllerEditedImage]];
    [picker dismissViewControllerAnimated:YES completion:NULL];
}


- (void)uploadPictures:(UIImage *)image{
    [MBProgressHUD showLoadingHUD:@"正在上传图片"];
    
    
    NSString *url = POSTUpLoadFile;
    
    
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:[User UserOb].token forHTTPHeaderField:@"token"];
    [manager.requestSerializer setValue:@"Mobile" forHTTPHeaderField:@"loginType"];
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 0.1) name:@"file" fileName:@"tupian.png" mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"成功返货=============%@",responseObject);
        [MBProgressHUD hideLoadingHUD];
        if (kResponseObjectStatusCodeIsEqual(200)) {
            NSDictionary *dic =responseObject[@"data"][@"data"];
            //            [self.imgarr addObject:dic[@"url"]];
            [self chengHeader:dic[@"url"]];
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideLoadingHUD];
    }];
}




- (void)chengHeader:(NSString *)img{
    NSString *url;
    NSDictionary *dic;
    if (USERFZR) {
        url = [NSString stringWithFormat:POSTUpdateTeamUserHeadImg,img];
    }else{
        url = POSTUpdateCoach;
        dic = @{@"headPic":img};
    }
    [FMNetworkHelper fm_request_postWithUrlString:url isNeedCache:NO parameters:dic successBlock:^(id responseObject) {
        KKLog(@"%@",responseObject);
        if (kResponseObjectStatusCodeIsEqual(200)) {
            NSUserDefaults *defaults  =  [NSUserDefaults standardUserDefaults];
            [defaults setObject:KURLIma(img) forKey:@"teamUserHead"];
            [defaults synchronize];
            [self.HeadPortrait sd_setImageWithURL:[NSURL URLWithString:KURLIma(img)] placeholderImage:[UIImage imageNamed:@"touxiang_nor"]];
            [self.vc.HeadPortrait sd_setImageWithURL:[NSURL URLWithString:KURLIma(img)] placeholderImage:[UIImage imageNamed:@"touxiang_nor"]];
            
        }
        
    } failureBlock:^(NSError *error) {
        KKLog(@"%@", error);
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
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
