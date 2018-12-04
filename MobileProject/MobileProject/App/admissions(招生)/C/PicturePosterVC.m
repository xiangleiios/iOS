//
//  PicturePosterVC.m
//  MobileProject
//
//  Created by 向蕾 on 2018/9/30.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "PicturePosterVC.h"
#import "CGXPickerView.h"
#import "XLCache.h"
#import "UIImage+LXQRCode.h"
#import "pictureV.h"
#import "CodeShareV.h"
#define FONT kFit_Font6(14)
@interface PicturePosterVC ()<UITextFieldDelegate>
@property (nonatomic , strong)UIView *imgback;
@property (nonatomic , strong)UIImageView *img;
@property (nonatomic , strong)UILabel *name;
@property (nonatomic , strong)UITextField *pho;
@property (nonatomic , strong)UILabel *jiaxia;
@property (nonatomic , strong)UITextField *price;
@property (nonatomic , strong)UITextField *template;

@property (nonatomic , strong)UIButton *savebut;
@property (nonatomic , strong)UIButton *sharebut;
@property (nonatomic , strong)UIButton *makebut;

@property (nonatomic , strong)UIButton *mobanChoose;
@property (nonatomic , strong)UIButton *jiaxiaoChoose;
@property (nonatomic , strong)UIImageView *QrCode;
@property (nonatomic , strong)NSMutableArray *titleArr; // 驾校名数组
@property (nonatomic , strong)NSMutableArray *teamNameArr; //分队名数组
@property (nonatomic , strong)NSMutableArray *idArr;
@property (nonatomic , strong)NSMutableArray *nameArr;
@property (nonatomic , strong)NSMutableArray *deptIdArr;
@property (nonatomic , strong)UIImage *posters;
@property (nonatomic , strong)NSString *postersurl;
@property (nonatomic , strong)NSString *headurl;//头像
@end


@implementation PicturePosterVC

- (NSMutableArray *)titleArr{
    if (_titleArr == nil) {
        _titleArr = [NSMutableArray array];
    }
    return _titleArr;
}
- (NSMutableArray *)deptIdArr{
    if (_deptIdArr == nil) {
        _deptIdArr = [NSMutableArray array];
    }
    return _deptIdArr;
}

- (NSMutableArray *)teamNameArr{
    if (_teamNameArr == nil) {
        _teamNameArr = [NSMutableArray array];
    }
    return _teamNameArr;
}

- (NSMutableArray *)nameArr{
    if (_nameArr == nil) {
        _nameArr = [NSMutableArray array];
    }
    return _nameArr;
}
- (NSMutableArray *)idArr{
    if (_idArr == nil) {
        _idArr = [NSMutableArray array];
    }
    return _idArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationView setTitle:self.model.tittle];
    [self loadsubview];
    [self loadBut];
    // Do any additional setup after loading the view.
}

- (void)loadsubview{
    self.imgback = [[UIView alloc] init];
    [self.view addSubview:_imgback];
    self.imgback.layer.cornerRadius = kFit_Font6(5);
    self.imgback.layer.masksToBounds = YES;
    
    [_imgback mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(kNavBarH + KFit_W6S(30));
        make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(30));
        make.right.mas_equalTo(self.view).mas_offset(-KFit_W6S(30));
        make.bottom.mas_equalTo(self.view).mas_offset(-KFit_H6S(160));
    }];
    
    self.img = [[UIImageView alloc] init];
//    self.img.backgroundColor = [UIColor redColor];
    [self.img sd_setImageWithURL:[NSURL URLWithString:KURLIma(_model.imgUrl)]];
    [self.imgback addSubview:self.img];
    
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(self.imgback);
    }];
    
    
    UILabel *lbone = [[UILabel alloc] init];
    lbone.userInteractionEnabled = YES;
    [self.imgback addSubview:lbone];
    lbone.backgroundColor = [UIColor whiteColor];
    [lbone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imgback).mas_offset(KFit_W6S(30));
        make.bottom.mas_equalTo(self.imgback).mas_offset(-KFit_H6S(65));
        make.right.mas_equalTo(self.imgback).mas_offset(-KFit_W6S(30));
        make.height.mas_equalTo(KFit_H6S(45));
    }];
    
    UILabel *lbtwo = [[UILabel alloc] init];
    [self.imgback addSubview:lbtwo];
    lbtwo.backgroundColor = [UIColor whiteColor];
    [lbtwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imgback).mas_offset(KFit_W6S(30));
        make.bottom.mas_equalTo(lbone.mas_top).mas_offset(-KFit_H6S(15));
        make.right.mas_equalTo(self.imgback).mas_offset(-KFit_W6S(260));
        make.height.mas_equalTo(KFit_H6S(45));
    }];
    
    UILabel *lbthree = [[UILabel alloc] init];
    [self.imgback addSubview:lbthree];
    lbthree.backgroundColor = [UIColor whiteColor];
    [lbthree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imgback).mas_offset(KFit_W6S(30));
        make.bottom.mas_equalTo(lbtwo.mas_top).mas_offset(-KFit_H6S(15));
        make.right.mas_equalTo(self.imgback).mas_offset(-KFit_W6S(260));
        make.height.mas_equalTo(KFit_H6S(45));
    }];
    
    UILabel *lbfour = [[UILabel alloc] init];
    [self.imgback addSubview:lbfour];
    lbfour.backgroundColor = [UIColor whiteColor];
    [lbfour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imgback).mas_offset(KFit_W6S(30));
        make.bottom.mas_equalTo(lbthree.mas_top).mas_offset(-KFit_H6S(15));
        make.width.mas_equalTo(KFit_W6S(180));
        make.height.mas_equalTo(KFit_H6S(45));
    }];
    
    UILabel *lbfive = [[UILabel alloc] init];
    [self.imgback addSubview:lbfive];
    lbfive.backgroundColor = [UIColor whiteColor];
    [lbfive mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lbfour.mas_right).mas_offset(KFit_W6S(15));
        make.bottom.mas_equalTo(lbthree.mas_top).mas_offset(-KFit_H6S(15));
        make.height.mas_equalTo(KFit_W6S(45));
        make.right.mas_equalTo(lbthree);
    }];
    
    self.template = [[UITextField alloc] init];
    [self.imgback addSubview:self.template];
    self.template.textColor = [UIColor blackColor];
    self.template.text = @"通过率高，随到随学";
    self.template.font = [UIFont systemFontOfSize:FONT];
    [self.template mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(lbone);
        make.left.mas_equalTo(lbone).mas_offset(KFit_W6S(10));
        make.right.mas_equalTo(lbone).mas_offset(-KFit_W6S(40));
    }];
    

    self.mobanChoose = [[UIButton alloc] init];
    [self.mobanChoose setImage:[UIImage imageNamed:@"down_click"] forState:UIControlStateNormal];
    [self.imgback addSubview:self.mobanChoose];
    [self.mobanChoose addTarget:self action:@selector(chooseMB) forControlEvents:UIControlEventTouchUpInside];
    [self.mobanChoose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(lbone);
        make.right.mas_equalTo(lbone.mas_right).mas_offset(-KFit_W6S(10));
        make.width.height.mas_equalTo(KFit_W6S(40));
    }];
    
    self.price = [[UITextField alloc] init];
    self.price.textColor = [UIColor blackColor];
    self.price.text = @"3000";
    self.price.delegate = self;
    self.price.keyboardType = UIKeyboardTypeNumberPad;
    self.price.font = [UIFont systemFontOfSize:FONT];
    [self.price addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.imgback addSubview:self.price];
    [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(lbtwo);
        make.left.mas_equalTo(lbtwo).mas_offset(KFit_W6S(10));
        make.width.mas_equalTo(KFit_W6S(90));
    }];
    
    UILabel *yuan = [[UILabel alloc] init];
    [self.imgback addSubview:yuan];
    yuan.text = @"元";
    yuan.font = [UIFont systemFontOfSize:FONT];
    [yuan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(lbtwo);
        make.left.mas_equalTo(self.price.mas_right);
        make.width.mas_equalTo(KFit_W6S(40));
    }];
    
    UILabel *tsone = [[UILabel alloc] init];
    [self.imgback addSubview:tsone];
    tsone.text = @"学车惊爆价";
    tsone.font = [UIFont systemFontOfSize:kFit_Font6(13)];
    [tsone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(lbtwo);
        make.left.mas_equalTo(yuan.mas_right).mas_offset(KFit_W6S(15));
        make.width.mas_equalTo(KFit_W6S(150));
    }];
    
    self.jiaxia = [[UILabel alloc] init];
    [self.imgback addSubview:self.jiaxia];
    self.jiaxia.font = [UIFont systemFontOfSize:FONT];
    [self.jiaxia mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(lbthree);
        make.left.mas_equalTo(lbthree).mas_offset(KFit_W6S(10));
        make.right.mas_equalTo(lbthree).mas_offset(-KFit_W6S(40));
    }];
    if (USERFZR) {
        self.jiaxiaoChoose = [[UIButton alloc] init];
        [self.imgback addSubview:self.jiaxiaoChoose];
        [self.jiaxiaoChoose setImage:[UIImage imageNamed:@"down_click"] forState:UIControlStateNormal];
        [self.jiaxiaoChoose addTarget:self action:@selector(chooseJX) forControlEvents:UIControlEventTouchUpInside];
        [self.jiaxiaoChoose mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(lbthree);
            make.right.mas_equalTo(lbthree.mas_right).mas_offset(-KFit_W6S(10));
            make.width.height.mas_equalTo(KFit_W6S(40));
        }];
    }
    
    self.name = [[UILabel alloc] init];
//    self.name.text = @"想想想";
    self.name.font = [UIFont systemFontOfSize:FONT];
    [self.imgback addSubview:self.name];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(lbfour);
        make.left.mas_equalTo(lbfour).mas_offset(KFit_W6S(10));
        make.right.mas_equalTo(lbfour).mas_offset(-KFit_W6S(70));
    }];
    
    UILabel *tstwo = [[UILabel alloc] init];
    [self.imgback addSubview:tstwo];
    tstwo.text = @"教练";
    tstwo.font = [UIFont systemFontOfSize:kFit_Font6(13)];
    [tstwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(lbfour);
        make.right.mas_equalTo(lbfour).mas_offset(-KFit_W6S(10));
        make.left.mas_equalTo(self.name.mas_right);
    }];
    
    self.pho = [[UITextField alloc] init];
    self.pho.userInteractionEnabled = NO;
    [self.imgback addSubview:self.pho];
    self.pho.text = [User UserOb].mobile;
    self.pho.font = [UIFont systemFontOfSize:FONT];
    [self.pho mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(lbfive);
        make.left.mas_equalTo(lbfive).mas_offset(KFit_W6S(10));
        make.right.mas_equalTo(lbfive).mas_offset(-KFit_W6S(10));
    }];
    
    
    UILabel *lbts = [[UILabel alloc] init];
    [self.imgback addSubview:lbts];
    lbts.textColor = [UIColor whiteColor];
    lbts.text = @"最终解释权归属驾校所有 海报由中天驾考提供";
    lbts.font = [UIFont systemFontOfSize:kFit_Font6(10)];
    lbts.textAlignment = NSTextAlignmentCenter;
    [lbts mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.imgback);
        make.bottom.mas_equalTo(self.imgback).mas_offset(- KFit_H6S(20));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(500), KFit_H6S(20)));
    }];
    
    UILabel *lbtstwo = [[UILabel alloc] init];
    [self.imgback addSubview:lbtstwo];
    lbtstwo.textColor = [UIColor whiteColor];
    lbtstwo.text = @"用微信扫描或识别二维码";
    lbtstwo.font = [UIFont systemFontOfSize:kFit_Font6(10)];
    lbtstwo.textAlignment = NSTextAlignmentCenter;
    [lbtstwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.pho);
        make.left.mas_equalTo(self.pho.mas_right);
        make.right.mas_equalTo(self.imgback);
        make.height.mas_equalTo(KFit_H6S(20));
    }];
    
    self.QrCode = [[UIImageView alloc] init];
    [self.imgback addSubview:self.QrCode];
    self.QrCode.backgroundColor = [UIColor whiteColor];
    [self.QrCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(lbone.mas_top).mas_offset(-KFit_H6S(10));
        make.width.height.mas_equalTo(KFit_W6S(120));
        make.centerX.mas_equalTo(lbtstwo);
    }];
    
}
#pragma mark - 生成海报按钮
- (void)loadBut{
    self.makebut = [[UIButton alloc] init];
    [self.view addSubview:self.makebut];
    self.makebut.layer.cornerRadius = kFit_Font6(5);
    self.makebut.layer.masksToBounds = YES;
    [self.makebut setTitle:@"生成招生海报" forState:UIControlStateNormal];
    [self.makebut setBackgroundImage:[UIImage createImageWithColor:kColor_N(0, 112, 234)] forState:UIControlStateNormal];
    [self.makebut setBackgroundImage:[UIImage createImageWithColor:kRGBAColor(0, 112, 234, 0.6)] forState:UIControlStateHighlighted];
    [self.makebut addTarget:self action:@selector(making) forControlEvents:UIControlEventTouchUpInside];
    [self.makebut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(30));
        make.right.bottom.mas_equalTo(self.view).mas_offset(-KFit_W6S(30));
        make.height.mas_equalTo(KFit_H6S(90));
    }];
}
#pragma mark - 分享和保存按钮
- (void)laodShourAndSave{
    self.sharebut = [[UIButton alloc] init];
    [self.view addSubview:self.sharebut];
    self.sharebut.layer.cornerRadius = kFit_Font6(5);
    self.sharebut.layer.masksToBounds = YES;
    [self.sharebut setTitle:@"分享海报" forState:UIControlStateNormal];
    [self.sharebut setBackgroundImage:[UIImage createImageWithColor:kColor_N(0, 112, 234)] forState:UIControlStateNormal];
    [self.sharebut setBackgroundImage:[UIImage createImageWithColor:kRGBAColor(0, 112, 234, 0.6)] forState:UIControlStateHighlighted];
    [self.sharebut addTarget:self action:@selector(toShare) forControlEvents:UIControlEventTouchUpInside];
    
    
     self.savebut = [[UIButton alloc] init];
     [self.view addSubview:self.savebut];
     self.savebut.layer.cornerRadius = kFit_Font6(5);
     self.savebut.layer.masksToBounds = YES;
     [self.savebut setTitle:@"保存海报" forState:UIControlStateNormal];
    self.savebut.layer.borderColor = kColor_N(0, 112, 234).CGColor;
    self.savebut.layer.borderWidth = 0.5;
    [self.savebut setTitleColor:kColor_N(0, 112, 234) forState:UIControlStateNormal];
//     [self.savebut setBackgroundImage:[UIImage createImageWithColor:kColor_N(147, 158, 180)] forState:UIControlStateNormal];
//     [self.savebut setBackgroundImage:[UIImage createImageWithColor:kRGBAColor(147, 158, 180, 0.6)] forState:UIControlStateHighlighted];
    [self.savebut addTarget:self action:@selector(toSave) forControlEvents:UIControlEventTouchUpInside];
    
    NSArray *arr = @[self.sharebut,self.savebut];
    [arr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:KFit_W6S(30) leadSpacing:KFit_W6S(30) tailSpacing:KFit_W6S(30)];
    [arr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view).mas_offset(-KFit_W6S(30));
        make.height.mas_equalTo(KFit_H6S(90));
    }];
    
}
#pragma mark -调用分享
- (void)toShare{
    CodeShareV *v = [[CodeShareV alloc] init];
    v.type = ShareTypeImage;
    XLshare *share = [[XLshare alloc]init];
    share.shareImg = self.posters;
    v.share = share;
    [v show];
}

#pragma mark -保存海报
- (void)toSave{
//    pictureV *v = [[pictureV alloc] init];
//    [v.img setImage:self.posters];
//    [v show];
//
//    XLAlertView *alert = [[XLAlertView alloc] initWithMessage:@"保存成功，可在我的海报中查看"];
//    [alert showPrompt];
    UIImageWriteToSavedPhotosAlbum(self.posters, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
}
#pragma mark - 上传图片
- (void)uploadPictures:(UIImage *)image{
    [MBProgressHUD showLoadingHUD:@"正在保存"];
    NSString *url = POSTUpLoadFile;

    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:[User UserOb].token forHTTPHeaderField:@"token"];
    [manager.requestSerializer setValue:@"Mobile" forHTTPHeaderField:@"loginType"];
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 0.1) name:@"file" fileName:@"tupian.png" mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"成功返货=============%@",responseObject);
        
        if (kResponseObjectStatusCodeIsEqual(200)) {
            NSDictionary *dic =responseObject[@"data"][@"data"];
            self.postersurl = dic[@"url"];
            [self laodSave];
        }else{
            [MBProgressHUD hideLoadingHUD];
            [MBProgressHUD showAutoMessage:responseObject[@"message"]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideLoadingHUD];
    }];
}

#pragma mark -调用保存接口
- (void)laodSave{
    if (![self.idArr containsObject:[NSNumber numberWithInteger:self.jiaxia.tag]]) {
        [MBProgressHUD showMsgHUD:@"数据错误"];
        return;
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:self.postersurl forKey:@"memo"];
    [dic setValue:@"1" forKey:@"type"];
    
    NSMutableDictionary *dictwo = [NSMutableDictionary dictionary];
    [dictwo setValue:self.name.text forKey:@"coachName"];
    [dictwo setValue:self.pho.text forKey:@"coachPhone"];
    NSInteger i = [self.idArr indexOfObject:[NSNumber numberWithInteger:self.jiaxia.tag]];
    KKLog(@"-----------------------%d",i);
    [dictwo setValue:self.titleArr[i] forKey:@"schoolName"];
    [dictwo setValue:self.teamNameArr[i] forKey:@"teamName"];
    [dictwo setValue:self.price.text forKey:@"price"];
    [dictwo setValue:self.template.text forKey:@"memo"];
    NSString *str = [dictwo mj_JSONString];
    [dic setValue:str forKey:@"content"];//类容
    
    if (self.type == PostersListTypeMy) {
        [dic setValue:self.model.resource forKey:@"resource"];//模板编号
    }else{
        [dic setValue:self.model.moduleCode forKey:@"resource"];//模板编号
    }
    
//    [dic setValue:@"" forKey:@"userImg"];
    [dic setValue:self.deptIdArr[i] forKey:@"userSign"];
    [dic setValue:self.nameArr[i] forKey:@"userName"];
    [dic setValue:self.model.imgUrl forKey:@"imgUrl"];
    [dic setValue:@"1" forKey:@"userType"];
    [FMNetworkHelper fm_request_postWithUrlString:POSTPostAdd isNeedCache:NO parameters:dic successBlock:^(id responseObject) {
        KKLog(@"%@",responseObject);
        [MBProgressHUD hideLoadingHUD];
        if (kResponseObjectStatusCodeIsEqual(200)) {
            
        }
        
    } failureBlock:^(NSError *error) {
        [MBProgressHUD hideLoadingHUD];
        KKLog(@"%@", error);
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
    
}

#pragma mark - 生成海报
- (void)making{
    self.mobanChoose.hidden = YES;
    self.jiaxiaoChoose.hidden = YES;
    NSString *str;
    if (USERFZR) {
        str = [NSString stringWithFormat:XIAOCHENGXUEWMschool,[NSString stringWithFormat:@"%ld",(long)self.jiaxia.tag]];
    }else{
        str = [NSString stringWithFormat:XIAOCHENGXUEWM,[NSString stringWithFormat:@"%ld",(long)self.jiaxia.tag]];
    }
    
//    UIImage *logImage = [UIImage LX_ImageOfQRFromURL:str codeSize:KFit_W6S(120)];
    UIImage *logImage =[UIImage LX_ImageOfQRFromURL:str codeSize:self.QrCode.width logoName:@"erwim_ewm" radius:KFit_W6S(40) borderWidth:3 borderColor:[UIColor whiteColor]];
    [self.QrCode setImage:logImage];
    
    UIImage *img = [UIImage fm_shotWithView:self.imgback];
    self.posters = img;
    self.makebut.hidden = YES;
    [self laodShourAndSave];
    /// 先上传图片
    [self uploadPictures:self.posters];
}


//- (void)chooseMB{
//    
//}
- (void)chooseJX{
    [CGXPickerView showStringPickerWithTitle:@"报考驾校" DataSource:self.titleArr DefaultSelValue:nil IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow) {
        NSLog(@"%@",selectValue);
//        self.jiaxia.text = selectValue;
        self.jiaxia.text = [NSString stringWithFormat:@"%@ (%@)",self.titleArr[[selectRow intValue]],self.teamNameArr[[selectRow intValue]]];
        self.jiaxia.tag = [self.idArr[[selectRow intValue]] intValue];
        self.name.text = self.nameArr[[selectRow intValue]];
        NSLog(@"%@",self.idArr[[selectRow intValue]]);
    }];
}

- (void)chooseMB{
    NSArray *arr = @[@"一次性收费，车接车送，精心指导",@"教学耐心细致，严格保证训练时间",@"通过率高，随到随学，一人一车",@"周一至周日，随到随学",@"介绍新学员报名有奖励哦",@"免费试学，报名60天拿证",@"老带新报名立减200元",@"拼团报名价格更低哦",@"准驾车型，教练帮您约课",@"45天拿证，含补考费，通过率高"];
    [CGXPickerView showStringPickerWithTitle:@"报考驾校" DataSource:arr DefaultSelValue:nil IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow) {
        NSLog(@"%@",selectValue);
        self.template.text = selectValue;
//        self.jiaxia.text = [NSString stringWithFormat:@"%@ (%@)",self.titleArr[[selectRow intValue]],self.teamNameArr[[selectRow intValue]]];
//        self.jiaxia.tag = [self.idArr[[selectRow intValue]] intValue];
//        self.name.text = self.nameArr[[selectRow intValue]];
        NSLog(@"%@",self.idArr[[selectRow intValue]]);
    }];
}

//保存到相册


-(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSString *msg = nil ;
    if(error){ msg = @"保存图片失败" ;
        
    }else{ msg = @"已保存图片到相册" ;
        
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"保存图片" message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [self loaddetail];
}
- (void)loaddetail{

    [FMNetworkHelper fm_request_postWithUrlString:[NSString stringWithFormat:@"%@?id=%@",_url,_model.idid] isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
        KKLog(@"%@",responseObject);
        if (kResponseObjectStatusCodeIsEqual(200)) {
            NSArray *arr = responseObject[@"data"][@"enrollist"];
            for (NSDictionary *dic in arr) {
                [self.idArr addObject:dic[@"id"]];
                [self.titleArr addObject:dic[@"schoolName"]];
                [self.nameArr addObject:dic[@"name"]];
                [self.teamNameArr addObject:dic[@"deptName"]];
                [self.deptIdArr addObject:dic[@"deptId"]];
                self.headurl = [NSString stringWithFormat:@"%@",dic[@"headImg"]];
            }
            self.jiaxia.text = [NSString stringWithFormat:@"%@ (%@)",[self.titleArr firstObject],[self.teamNameArr firstObject]];
            self.jiaxia.tag =  [[self.idArr firstObject] intValue];
            self.name.text = [self.nameArr firstObject];
        }else{
            [MBProgressHUD showMsgHUD:responseObject[@"message"]];
        }
        
    } failureBlock:^(NSError *error) {
        KKLog(@"%@", error);
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}
//设置文本框只能输入数字

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    //如果是限制只能输入数字的文本框
    return [self validateNumber:string];
    
}


- (BOOL)validateNumber:(NSString*)number {
    
    BOOL res =YES;
    
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    
    int i =0;
    
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i,1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length ==0) {
            res =NO;
            break;
        }
        i++;
    }
    return res;
}


- (void)textFieldDidChange:(UITextField *)textField{
    UITextRange *selectedRange = textField.markedTextRange;
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    if (!position) {
        // 没有高亮选择的字
        // 1. 过滤非汉字、字母、数字字符
        
        // 2. 截取
        if (textField.text.length >= 5) {
            textField.text = [textField.text substringToIndex:5];
            
        }
        
    } else {
        // 有高亮选择的字 不做任何操作
        
    }
    
}
// 过滤字符串中的非汉字、字母、数字
- (NSString *)filterCharactor:(NSString *)string withRegex:(NSString *)regexStr{
    NSString *filterText = string; NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexStr options:NSRegularExpressionCaseInsensitive error:&error];
    NSString *result = [regex stringByReplacingMatchesInString:filterText options:NSMatchingReportCompletion range:NSMakeRange(0, filterText.length) withTemplate:@""];
    return result;
    
}
    

@end
