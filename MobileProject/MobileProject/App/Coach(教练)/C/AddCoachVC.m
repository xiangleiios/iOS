//
//  AddCoachVC.m
//  MobileProject
//
//  Created by 向蕾 on 2018/11/16.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "AddCoachVC.h"
#import "XLInformationV.h"
#import "CGXPickerView.h"
@interface AddCoachVC ()
@property (nonatomic , strong)XLInformationV *school;
@property (nonatomic , strong)XLInformationV *fenXiao;
@property (nonatomic , strong)XLInformationV *name;
@property (nonatomic , strong)XLInformationV *pho;
@property (nonatomic , strong)XLInformationV *zhuangtai;
@property (nonatomic , assign)int isDimission;
@property (nonatomic , strong)UIImageView *head;
@property (nonatomic , strong)NSString *headURL;
@end

@implementation AddCoachVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationView setTitle:@"添加教练"];
    [self loadSubview];
    [self loadBut];
    // Do any additional setup after loading the view.
}

- (void)loadSubview{
    
    UILabel *lb = [[UILabel alloc] init];
    [self.view addSubview:lb];
    lb.text = @"头像";
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(30));
        make.top.mas_equalTo(self.view.mas_top).mas_offset(KFit_H6S(50) + kNavBarH);
        make.height.mas_equalTo(KFit_H6S(35));
    }];
    UIButton *but = [[UIButton alloc] init];
    [self.view addSubview:but];
    [but addTarget:self action:@selector(changeUp) forControlEvents:UIControlEventTouchUpInside];
    [but setImage:[UIImage imageNamed:@"arrows_right_icon"] forState:UIControlStateNormal];
    [but mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view).mas_offset(-KFit_W6S(20));
        make.centerY.mas_equalTo(lb);
        make.width.mas_equalTo(KFit_H6S(40));
        make.height.mas_equalTo(KFit_H6S(40));
    }];
    
    self.head = [[UIImageView alloc] init];
    [self.view addSubview:self.head];
    self.head.userInteractionEnabled = YES;
    [self.head setImage:[UIImage imageNamed:@"head_nor"]];
    [self.head mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(but.mas_left).mas_offset(-KFit_W6S(10));
        make.centerY.mas_equalTo(lb);
        make.width.height.mas_equalTo(KFit_H6S(100));
    }];
    self.head.layer.cornerRadius = KFit_W6S(50);
    self.head.layer.masksToBounds = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeUp)];
    // 允许用户交互
    [self.head addGestureRecognizer:tap];
    UILabel *line = [[UILabel alloc] init];
    [self.view addSubview:line];
    line.backgroundColor = kColor_N(240, 240, 240);
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(lb.mas_bottom).mas_offset(KFit_H6S(50));
        make.height.mas_equalTo(kFit_Font6(1));
    }];
    
    UIView *view = [[UIView alloc] init];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(line.mas_bottom);
        make.height.mas_equalTo(KFit_H6S(360));
    }];
    
    
    kWeakSelf(self)
    NSUserDefaults *defaults  =  [NSUserDefaults standardUserDefaults];
    NSArray *arrname = (NSArray *)[defaults objectForKey:SchoolList];
    
    self.school = [[XLInformationV alloc] informationWithTitle:@"所属总校" SubTitle:@"" TSSubTitle:@"请选择总校" Must:YES Click:YES];
    
    self.fenXiao = [[XLInformationV alloc] informationWithTitle:@"所属分校" SubTitle:@"" TSSubTitle:@"请选择分校" Must:NO Click:NO];
    self.fenXiao.userInteractionEnabled = NO;
    self.fenXiao.subfield.text = arrname[0][@"teamName"];
    self.fenXiao.subfield.tag = [arrname[0][@"teamSchoolDeptId"] intValue];
    self.school.senterBlock = ^{
        [CGXPickerView showStringPickerWithTitle:@"总校" DataSource:[XLCache singleton].teamCode_title DefaultSelValue:nil IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow) {
            NSLog(@"%@",selectValue);
            int i = [selectRow intValue];
            weakself.school.subfield.text = selectValue;
            weakself.school.subfield.tag = [[XLCache singleton].teamCode_value[[selectRow intValue]] intValue];
            weakself.fenXiao.subfield.text = arrname[i][@"teamName"];
            weakself.fenXiao.subfield.tag = [arrname[i][@"teamSchoolDeptId"] intValue];
        }];
    };
    self.school.subfield.text = [[XLCache singleton].teamCode_title firstObject];
    self.school.subfield.tag = [[[XLCache singleton].teamCode_value firstObject] integerValue];
    
    
    self.name = [[XLInformationV alloc] informationWithTitle:@"教练姓名" SubTitle:@"" TSSubTitle:@"请填写真实姓名" Must:YES Click:NO];
    
    self.pho = [[XLInformationV alloc] informationWithTitle:@"教练手机号" SubTitle:@"" TSSubTitle:@"请填写教练手机号码" Must:YES Click:NO];
    
    [view addSubview:self.school];
    [view addSubview:self.fenXiao];
    [view addSubview:self.name];
    [view addSubview:self.pho];
    
    NSArray *arr = @[self.school,self.fenXiao,self.name,self.pho];
    [arr mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:0.1 leadSpacing:0.1 tailSpacing:0.1];
    [arr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(view);
    }];
    if (self.type) {
        self.zhuangtai = [[XLInformationV alloc] informationWithTitle:@"供职状态" SubTitle:@"" TSSubTitle:@"请选择是否离职" Must:YES Click:YES];
        self.zhuangtai.senterBlock = ^{
            [CGXPickerView showStringPickerWithTitle:@"供职状态" DataSource:@[@"在职",@"离职"] DefaultSelValue:nil IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow) {
                NSLog(@"%@",selectValue);
                int i = [selectRow intValue];
                weakself.isDimission = i;
                weakself.zhuangtai.subfield.text = selectValue;
                
            }];
        };
        [self.view addSubview:self.zhuangtai];
        [self.zhuangtai mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.view);
            make.top.mas_equalTo(view.mas_bottom);
            make.height.mas_equalTo(KFit_H6S(90));
        }];
        
    }
    if (self.model) {
        self.name.subfield.text = self.model.name;
        self.pho.subfield.text = self.model.enrollPhone;
        [self.head sd_setImageWithURL:[NSURL URLWithString:KURLIma(self.model.headPic)]placeholderImage:[UIImage imageNamed:@"head_nor"]];
        self.headURL = self.model.headPic;
        self.school.subfield.text = self.model.schoolName;
        self.fenXiao.subfield.text = self.model.deptName;
        self.school.subfield.tag = [self.model.schoolDeptId integerValue];
        self.fenXiao.subfield.tag = [self.model.deptId integerValue];
        self.isDimission = self.model.isDimission;
        if (self.model.isDimission) {
            self.zhuangtai.subfield.text = @"离职";
        }else{
            self.zhuangtai.subfield.text = @"在职";
        }
    }
    
}

- (void)loadBut{
    UIButton *next = [[UIButton alloc] init];
    [self.view addSubview:next];
    //    [next setTitle:@"保存" forState:UIControlStateNormal];
    [next addTarget:self action:@selector(toSave) forControlEvents:UIControlEventTouchUpInside];
    [next setBackgroundImage:[UIImage createImageWithColor:kColor_N(0, 112, 234)] forState:UIControlStateNormal];
    [next setBackgroundImage:[UIImage createImageWithColor:kRGBAColor(0, 112, 234, 0.6)] forState:UIControlStateHighlighted];
    [next setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    next.layer.cornerRadius = 5;
    next.layer.masksToBounds = YES;
    [next mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(70));
        make.right.mas_equalTo(self.view).mas_offset(-KFit_W6S(70));
        make.bottom.mas_equalTo(self.view).mas_offset(-KFit_W6S(40));
        make.height.mas_equalTo(KFit_H6S(90));
    }];
    [next setTitle:@"保存" forState:UIControlStateNormal];
    
}

- (void)toSave{
    if (self.school.subfield.text.length < 1) {
        [MBProgressHUD showMsgHUD:@"请选择总校"];
        return;
    }
    if (self.name.subfield.text.length < 1) {
        [MBProgressHUD showMsgHUD:@"请填写教练姓名"];
        return;
    }
    if (self.pho.subfield.text.length < 1) {
        [MBProgressHUD showMsgHUD:@"请填写教练手机号"];
        return;
    }
    if (self.pho.subfield.text.length != 11) {
        [MBProgressHUD showMsgHUD:@"请填写正确的手机号"];
        return;
    }
    if (self.name.subfield.text.length > 5) {
        [MBProgressHUD showMsgHUD:@"教练姓名不能超过5个字符"];
        return;
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:self.name.subfield.text forKey:@"coachName"];
    [dic setValue:self.pho.subfield.text forKey:@"phoneNumber"];
    
    [dic setValue:[NSString stringWithFormat:@"%ld",(long)self.fenXiao.subfield.tag] forKey:@"schoolId"];
    [dic setValue:[NSString stringWithFormat:@"%ld",(long)self.school.subfield.tag] forKey:@"originalDeptId"];
    if (self.headURL) {
        
        [dic setValue:self.headURL forKey:@"headPic"];
    }
    NSString *url;
    if (self.type) {
        [dic setValue:[NSString stringWithFormat:@"%d",self.isDimission] forKey:@"isDimission"];
        [dic setValue:self.model.coachId forKey:@"id"];
        url = POSTTeamSchoolCoachCoachEdit;
    }else{
        url = POSTTeamSchoolCoachCoachAdd;
    }
    
    [FMNetworkHelper fm_request_postWithUrlString:url isNeedCache:NO parameters:dic successBlock:^(id responseObject) {
        [MBProgressHUD hideHUD];
        KKLog(@"%@",responseObject);
        if (kResponseObjectStatusCodeIsEqual(200)) {
            [MBProgressHUD showMsgHUD:@"保存成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [MBProgressHUD showMsgHUD:responseObject[@"message"]];
        }
    } failureBlock:^(NSError *error) {
        KKLog(@"%@", error);
        [MBProgressHUD hideHUD];
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
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
//        imagePickerController.allowsEditing = YES;
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
    [self uploadPictures:info[UIImagePickerControllerOriginalImage]];
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
            [self.head sd_setImageWithURL:[NSURL URLWithString:KURLIma(dic[@"url"])]];
            self.headURL = dic[@"url"];
            
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
