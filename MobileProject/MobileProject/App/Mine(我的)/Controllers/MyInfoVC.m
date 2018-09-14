//
//  MyInfoVC.m
//  MobileProject
//
//  Created by zsgy on 2017/10/30.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "MyInfoVC.h"
#import "XLMyNewsFunction.h"
#import "XLInformationV.h"
#import "ChangePasswordVC.h"
#import <CommonCrypto/CommonDigest.h>//MD5加密导入框架
@interface MyInfoVC ()<UIImagePickerControllerDelegate>
@property (nonatomic , strong)XLMyNewsFunction *headerview;
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
    XLInformationV *name = [[XLInformationV alloc] informationWithTitle:@"登录账户" SubTitle:[User UserOb].mobile];
    [self.view addSubview:name];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(kNavBarH + KFit_H6S(60));
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
        make.top.mas_equalTo(name.mas_bottom);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(KFit_H6S(90));
    }];
    
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




#pragma mark-图片选项提示；
- (void)imageUpload{
    UIAlertController * aler = [UIAlertController alertControllerWithTitle:@"请选择" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * actionCamera = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIAlertView * alerr = [[UIAlertView alloc]initWithTitle:@"警告!" message:@"未找到该硬件设备或设备已损坏" delegate:self cancelButtonTitle:nil otherButtonTitles:@"我知道了", nil];
            [alerr show];
        }else{
            UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
            if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
            {
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                picker.delegate = self;
                //设置拍照后的图片可被编辑
                picker.allowsEditing = YES;
                picker.sourceType = sourceType;
                //利用模态进行调用系统框架
                [self.navigationController presentViewController:picker animated:YES completion:nil];
            }else
            {
                NSLog(@"模拟器中无法打开照相机,请在真机中使用");
            }
        }
        
        
    }];
    UIAlertAction * actionLibary = [UIAlertAction actionWithTitle:@"照片库" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.delegate = self;
        //设置选择后的图片可被编辑
        picker.allowsEditing = YES;
        [self.navigationController presentViewController:picker animated:YES completion:nil];;
        
    }];
    
    UIAlertAction * actionCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [aler addAction:actionCamera];
    [aler addAction:actionLibary];
    [aler addAction:actionCancel];
    [self presentViewController:aler animated:YES completion:nil];
    
}


#pragma mark- 相机，照片库图片代理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
        UIImage* image = [info objectForKey:@"UIImagePickerControllerEditedImage"]; /// UIImagePickerControllerOriginalImage
        image = [self imageScale:image maxEdge:300];
        NSData *data;
        if (UIImagePNGRepresentation(image) == nil)
        {
            data = UIImageJPEGRepresentation(image, 1.0);
        }
        else
        {
            data = UIImagePNGRepresentation(image);
        }
        
        
        //关闭相册界面
        [picker dismissModalViewControllerAnimated:YES];
        
        // 上传头像
        [self uploadUserHeadWithImageData:image];
        
    }
}
- (UIImage *)imageScale:(UIImage *)image maxEdge:(float)maxEdge
{
    float w = image.size.width;
    float h = image.size.height;
    
    float w1 = w;
    float h1 = h;
    if( w >= h )
    {
        if( w1 > maxEdge )
            w1 = maxEdge;
        
        h1 = w1 * h / w;
    }
    else{
        if( h1 > maxEdge )
            h1 = maxEdge;
        
        w1 = w * h1 / h;
    }
    
    
    UIGraphicsBeginImageContext(CGSizeMake(w1, h1));
    
    [image drawInRect:CGRectMake(0, 0, w1, h1)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext ();
    UIGraphicsEndImageContext();
    return scaledImage;
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissModalViewControllerAnimated:YES];
}

#pragma mark -头像上传


// 上传头像
- (void)uploadUserHeadWithImageData:(UIImage*)headerIma {
    User* bean = [User UserOb];
//    NSString *jm=[NSString stringWithFormat:@"qINgyunnnTv@5890%@",bean.uid];
//    NSString *key=[self md5HexDigest:jm];
//    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
//    [dic setValue:key forKey:@"key"];
//    [dic setValue:bean.uid forKey:@"uid"];
    NSString *url=[NSString stringWithFormat:userHeaderImage,bean.token];
    [FMNetworkHelper fm_uploadImagesWithUrlString:url parameters:nil name:@"avatar_file" images:[NSArray arrayWithObject:headerIma] fileNames:[NSArray arrayWithObject:@"avatar_file"] imageScale:1.0 imageType:@"image/png" progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        NSLog(@"bytesProgress:%.2f----totalBytesProgress:%.2f",bytesProgress,totalBytesProgress);
        
    } success:^(id responseObject) {
        NSDictionary *dic=responseObject[@"data"];
        bean.avatar_url=dic[@"data"];
        [[SDImageCache sharedImageCache]removeImageForKey:bean.avatar_url]; //先清除SD缓存的本地原来头像。因为SD检查到相同地址本地有缓存就不会再去下载。
        [self.headerview.img sd_setImageWithURL:[NSURL URLWithString:bean.avatar_url]];
        [self.delegate headerImageOrNikeNameChange:0];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        
    }];
}

//加密
- (NSString *)md5HexDigest:(NSString*)input
{
    const char* str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];//
    
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}
#pragma mark -修改昵称
- (void)promptedToChangeTheNickname{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"昵称修改" message:@"请输入新的昵称" preferredStyle:UIAlertControllerStyleAlert];
    
    // 添加按钮
    __weak typeof(alert) weakAlert = alert;
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        //        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        NSString *encodingString =[ [weakAlert.textFields.firstObject text] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding ];
        //        dic[@"nick_name"] = encodingString;
        //        NSString *ster = [[DataModule sharedInstance] getLoginedUserInfo].token;
        //        dic[@"token"] = ster;
        if ([weakAlert.textFields.firstObject text].length > 16) {
            //            [SVProgressHUD showErrorWithStatus:@"昵称仅限制16个字符以内"];
            [MBProgressHUD showAutoMessage:@"昵称仅限制16个字符以内"];
            [self presentViewController:alert animated:YES completion:nil];
            return ;
        }
        [self changeNickRequest:encodingString];
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }]];
    
    
    // 添加文本框
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.textColor = [UIColor redColor];
        textField.placeholder = @"昵称支持中英文以及数字";
        [textField addTarget:self action:@selector(usernameDidChange:) forControlEvents:UIControlEventEditingDidEnd];
    }];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)changeNickRequest:(NSString *)name{
    NSString *url=[NSString stringWithFormat:POSTChangeTheNickname,[User UserOb].token,name];
    [FMNetworkHelper fm_request_postWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
        if (kResponseObjectStatusCodeIsEqual(200)) {
            [MBProgressHUD showAutoMessage:@"修改成功"];
            User *use=[User UserOb];
            use.nick_name=[name stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:use.nick_name forKey:@"nick_name"];
            [defaults synchronize];
            [self.delegate headerImageOrNikeNameChange:1];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [MBProgressHUD showAutoMessage:responseObject[@"message"]];
        }
    } failureBlock:^(NSError *error) {
        
    } progress:nil];
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
