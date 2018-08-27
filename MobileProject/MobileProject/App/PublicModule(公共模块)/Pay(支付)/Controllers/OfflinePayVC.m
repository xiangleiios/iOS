//
//  OfflinePayVC.m
//  MobileProject
//
//  Created by zsgy on 2018/6/19.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "OfflinePayVC.h"
#import "MyAccountVC.h"
#import "PayVc.h"
#import "FMPayRequest.h"
#import "XLUPPay.h"
@interface OfflinePayVC ()<UIImagePickerControllerDelegate>
@property (nonatomic , strong)UILabel *number;
@property (nonatomic , strong)UILabel *money;
@property (nonatomic , strong)UIButton *cameraBut;
@property (nonatomic , strong)UIButton *PhotoBut;
@property (nonatomic , strong)UIImageView *img;
@property (nonatomic , strong)NSString *imgUrl;
@end

@implementation OfflinePayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationView setTitle:self.title];
    [self.navigationView.titleLabel setTextColor:[UIColor blackColor]];
    [self loadSubview];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)loadSubview{
    self.number = [[UILabel alloc] init];
    [self.view addSubview:self.number];
    self.number.text = @"支付金额";
    self.number.textAlignment = NSTextAlignmentCenter;
    self.number.font = [UIFont systemFontOfSize:kFit_Font6(16)];
    [self.number mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(30));
        make.right.mas_equalTo(self.view).mas_offset(-KFit_W6S(30));
        make.top.mas_equalTo(self.view).mas_offset(KFit_H6S(20) + kNavBarH);
        make.height.mas_equalTo(KFit_H6S(40));
    }];
    
    self.money = [[UILabel alloc] init];
    [self.view addSubview:self.money];
    self.money.text = [NSString stringWithFormat:@"%@元",self.num];
    self.money.textAlignment = NSTextAlignmentCenter;
    self.money.textColor = kColor_N(247, 123, 34);
    self.money.font = [UIFont systemFontOfSize:kFit_Font6(16)];
    [self.money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(30));
        make.right.mas_equalTo(self.view).mas_offset(-KFit_W6S(30));
        make.top.mas_equalTo(self.number.mas_bottom).mas_offset(KFit_H6S(40));
        make.height.mas_equalTo(KFit_H6S(40));
    }];
    // 创建Attributed
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:self.money.text];
    // 需要改变的第一个文字的位置
//    NSUInteger firstLoc = [[noteStr string] rangeOfString:@":"].location + 1;
    // 需要改变的最后一个文字的位置
    NSUInteger secondLoc = [[noteStr string] rangeOfString:@"元"].location;
    // 需要改变的区间
    NSRange range = NSMakeRange(0, secondLoc);
    // 改变颜色
    [noteStr addAttribute:NSForegroundColorAttributeName value:kColor_N(247, 123, 34) range:range];
    // 改变字体大小及类型
    [noteStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:kFit_Font6(30)] range:range];
    // 为label添加Attributed
    [self.money setAttributedText:noteStr];
    
    
    if (self.payType == PayTypeOffline) {
        [self loadUpBut];
    }else{
        UIButton *but = [[UIButton alloc] init];
        [but setTitle:@"支付" forState:UIControlStateNormal];
        [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [but addTarget:self action:@selector(toPay) forControlEvents:UIControlEventTouchUpInside];
        but.backgroundColor = kColor_N(40, 174, 104);
        but.layer.cornerRadius = 5;
        [self.view addSubview:but];
        [but mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.money);
            make.top.mas_equalTo(self.money.mas_bottom).mas_offset(KFit_H6S(70));
            make.height.mas_equalTo(KFit_H6S(80));
        }];
    }
}

- (void)loadUpBut{
    UILabel *ts = [[UILabel alloc] init];
    [self.view addSubview:ts];
    ts.text = @"上传充值凭证：";
    ts.font = [UIFont systemFontOfSize:kFit_Font6(16)];
    [ts mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(30));
        make.right.mas_equalTo(self.view).mas_offset(-KFit_W6S(30));
        make.top.mas_equalTo(self.money.mas_bottom).mas_offset(KFit_H6S(40));
        make.height.mas_equalTo(KFit_H6S(40));
    }];
    
    self.cameraBut = [[UIButton alloc] init];
    [self.cameraBut setImage:[UIImage imageNamed:@"camera"] forState:UIControlStateNormal];
    [self.view addSubview:self.cameraBut];
    [self.cameraBut addTarget:self action:@selector(TakingPictures) forControlEvents:UIControlEventTouchUpInside];
    [self.cameraBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(ts.mas_bottom).mas_offset(KFit_H6S(30));
        make.left.mas_equalTo(ts);
        make.size.mas_equalTo(CGSizeMake(KFit_H6S(160), KFit_H6S(160)));
    }];
    
    self.img = [[UIImageView alloc] init];
    [self.view addSubview:self.img];
    self.img.hidden = YES;
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(ts.mas_bottom).mas_offset(KFit_H6S(30));
        make.left.mas_equalTo(ts);
        make.size.mas_equalTo(CGSizeMake(KFit_H6S(160), KFit_H6S(160)));
    }];
    
    
    self.PhotoBut = [[UIButton alloc] init];
    [self.PhotoBut setImage:[UIImage imageNamed:@"photo"] forState:UIControlStateNormal];
    [self.view addSubview:self.PhotoBut];
    [self.PhotoBut addTarget:self action:@selector(PhotoLibrary) forControlEvents:UIControlEventTouchUpInside];
    [self.PhotoBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(ts.mas_bottom).mas_offset(KFit_H6S(30));
        make.left.mas_equalTo(self.cameraBut.mas_right).mas_offset(KFit_W6S(25));
        make.size.mas_equalTo(CGSizeMake(KFit_H6S(160), KFit_H6S(160)));
    }];
    
    UIButton *but = [[UIButton alloc] init];
    [but setTitle:@"上传凭证" forState:UIControlStateNormal];
    [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(toUpPictures) forControlEvents:UIControlEventTouchUpInside];
    but.backgroundColor = kColor_N(40, 174, 104);
    but.layer.cornerRadius = 5;
    [self.view addSubview:but];
    [but mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.money);
        make.top.mas_equalTo(self.PhotoBut.mas_bottom).mas_offset(KFit_H6S(70));
        make.height.mas_equalTo(KFit_H6S(80));
    }];
    
    
}

//拍照
- (void)TakingPictures{
    UIImagePickerController * imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.mediaTypes = [NSArray arrayWithObject:(__bridge NSString *)kUTTypeImage];
    imagePickerController.delegate = self;
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIAlertView * alerr = [[UIAlertView alloc]initWithTitle:@"警告!" message:@"未找到该硬件设备或设备已损坏" delegate:self cancelButtonTitle:nil otherButtonTitles:@"我知道了", nil];
        [alerr show];
    }else{
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
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
    [self.navigationController presentViewController:imagePickerController animated:YES completion:nil];;
}


#pragma mark -相册代理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    KKLog(@"%@    ----- %@",picker,info);
    [self uploadPictures:info[UIImagePickerControllerOriginalImage]];
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)toPay{
    [self Quickpayment];
}


- (void)Quickpayment{
    if (self.imgUrl == nil) {
        self.imgUrl = @"";
    }
    [MBProgressHUD showLoadingHUD:@"请求支付"];
    NSString *url=[NSString stringWithFormat:POSTMembersAccountRecharge,[User UserOb].token,self.num,self.payType,self.imgUrl];
    NSDictionary *dic= @{@"money":self.num,@"type":[NSString stringWithFormat:@"%ld",(self.payType +1)],@"image":self.imgUrl};
    [FMNetworkHelper fm_request_getWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
        NSLog(@"成功返货=============%@",responseObject);
        NSDictionary *dic = responseObject[@"data"];
        if (kResponseObjectStatusCodeIsEqual(200)) {
            if (self.payType == PayTypeYL) {
                [XLUPPay upPayRequestWithOrder:dic[@"order_num"] pushVc:self];
            }else if (self.payType == PayTypeWX){
                [FMPayRequest fm_payRequestWithOrder:dic[@"order_num"] pushVc:self isAlipay:NO];
            }else if (self.payType == PayTypeAli){
                [FMPayRequest fm_payRequestWithOrder:dic[@"order_num"] pushVc:self isAlipay:YES];
            }
        }else{
            [MBProgressHUD showAutoMessage:responseObject[@"message"]];
        }
    } failureBlock:^(NSError *error) {
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}



- (void)toUpPictures{
    if (self.img.hidden) {
        XLAlertView *alert = [[XLAlertView alloc] initWithTitle:@"提示" message:@"请上传凭证" sureBtn:@"确定" cancleBtn:nil];
        [alert showXLAlertView];
    }else{
        [self pay];
    }
    
}



- (void)pay{
    
    if (self.imgUrl == nil) {
        self.imgUrl = @"";
    }
    NSString *url=[NSString stringWithFormat:POSTMembersAccountRecharge,[User UserOb].token,self.num,self.payType,self.imgUrl];
    NSDictionary *dic= @{@"money":self.num,@"type":[NSString stringWithFormat:@"%ld",(self.payType +1)],@"image":self.imgUrl};
    [FMNetworkHelper fm_request_getWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
        NSLog(@"成功返货=============%@",responseObject);
        
        if (kResponseObjectStatusCodeIsEqual(200)) {
            XLAlertView *alert = [[XLAlertView alloc] initWithMessage:@"充值凭证已上传，请等待平台确认" SuccessOrFailure:YES];
            [alert showPrompt];
            
        }else{
            [MBProgressHUD showAutoMessage:responseObject[@"message"]];
        }
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[MyAccountVC class]]) {
                [self.navigationController popToViewController:controller animated:YES];
            }
            if ([controller isKindOfClass:[PayVc class]]) {
                if (self.payType == PayTypeOffline) {
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }else{
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }
        }
    } failureBlock:^(NSError *error) {
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
//    [FMNetworkHelper fm_request_postWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
//        NSLog(@"成功返货=============%@",responseObject);
//
//        if (kResponseObjectStatusCodeIsEqual(200)) {
//            XLAlertView *alert = [[XLAlertView alloc] initWithMessage:@"充值凭证已上传，请等待平台确认" SuccessOrFailure:YES];
//            [alert showPrompt];
//            [self.navigationController popViewControllerAnimated:YES];
//        }else{
//            [MBProgressHUD showAutoMessage:responseObject[@"message"]];
//        }
//    } failureBlock:^(NSError *error) {
//        KKLog(@"%@",error);
//    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
//
//    }];
    
//    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
//    [manager POST:url parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        KKLog(@"%@",error);
//    }];
}

- (void)uploadPictures:(UIImage *)image{
    [MBProgressHUD showLoadingHUD:@"正在上传图片"];
    
    NSString *url=[NSString stringWithFormat:POSTFileUpload,[User UserOb].token];

    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 0.1) name:@"image_file" fileName:@"tupian.png" mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"成功返货=============%@",responseObject);
        [MBProgressHUD hideLoadingHUD];
        if (kResponseObjectStatusCodeIsEqual(200)) {
            self.img.hidden = NO;
            self.PhotoBut.hidden = YES;
            self.cameraBut.hidden = YES;
            self.imgUrl = responseObject[@"data"];
            [self.img setImage:image];
        }else{
            [MBProgressHUD showAutoMessage:responseObject[@"message"]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideLoadingHUD];
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
