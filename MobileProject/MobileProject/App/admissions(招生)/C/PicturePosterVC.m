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
@interface PicturePosterVC ()
@property (nonatomic , strong)UIView *imgback;
@property (nonatomic , strong)UIImageView *img;
@property (nonatomic , strong)UITextField *name;
@property (nonatomic , strong)UITextField *pho;
@property (nonatomic , strong)UILabel *jiaxia;
@property (nonatomic , strong)UITextField *price;
@property (nonatomic , strong)UITextField *template;

@property (nonatomic , strong)UIButton *savebut;
@property (nonatomic , strong)UIButton *sharebut;
@property (nonatomic , strong)UIButton *makebut;

@property (nonatomic , strong)UIButton *mobanChoose;
@property (nonatomic , strong)UIButton *jiaxiaoChoose;
@end


@implementation PicturePosterVC
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
    self.img.backgroundColor = [UIColor redColor];
    [self.imgback addSubview:self.img];
    [self.img sd_setImageWithURL:[NSURL URLWithString:_model.imgUrl]];
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
    self.template.font = [UIFont systemFontOfSize:kFit_Font6(15)];
    [self.template mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(lbone);
        make.left.mas_equalTo(lbone).mas_offset(KFit_W6S(10));
        make.right.mas_equalTo(lbone).mas_offset(-KFit_W6S(40));
    }];
    

    self.mobanChoose = [[UIButton alloc] init];
    self.mobanChoose.backgroundColor = [UIColor yellowColor];
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
    self.price.font = [UIFont systemFontOfSize:kFit_Font6(15)];
    [self.imgback addSubview:self.price];
    [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(lbtwo);
        make.left.mas_equalTo(lbtwo).mas_offset(KFit_W6S(10));
        make.width.mas_equalTo(KFit_W6S(90));
    }];
    
    UILabel *yuan = [[UILabel alloc] init];
    [self.imgback addSubview:yuan];
    yuan.text = @"元";
    yuan.font = [UIFont systemFontOfSize:kFit_Font6(15)];
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
    self.jiaxia.font = [UIFont systemFontOfSize:kFit_Font6(15)];
    self.jiaxia.text = @"大学生驾校";
    [self.jiaxia mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(lbthree);
        make.left.mas_equalTo(lbthree).mas_offset(KFit_W6S(10));
        make.right.mas_equalTo(lbthree).mas_offset(-KFit_W6S(40));
    }];
    
    self.jiaxiaoChoose = [[UIButton alloc] init];
    [self.imgback addSubview:self.jiaxiaoChoose];
    self.jiaxiaoChoose.backgroundColor = [UIColor greenColor];
    [self.jiaxiaoChoose addTarget:self action:@selector(chooseJX) forControlEvents:UIControlEventTouchUpInside];
    [self.jiaxiaoChoose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(lbthree);
        make.right.mas_equalTo(lbthree.mas_right).mas_offset(-KFit_W6S(10));
        make.width.height.mas_equalTo(KFit_W6S(40));
    }];
    
    self.name = [[UITextField alloc] init];
    self.name.text = @"想想想";
    self.name.font = [UIFont systemFontOfSize:kFit_Font6(15)];
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
    [self.imgback addSubview:self.pho];
    self.pho.text = @"12312312312";
    self.pho.font = [UIFont systemFontOfSize:kFit_Font6(15)];
    [self.pho mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(lbfive);
        make.left.mas_equalTo(lbfive).mas_offset(KFit_W6S(10));
        make.right.mas_equalTo(lbfive).mas_offset(-KFit_W6S(10));
    }];
    
    
}

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

- (void)making{
    self.mobanChoose.hidden = YES;
    self.jiaxiaoChoose.hidden = YES;
    UIImage *img = [UIImage fm_shotWithView:self.imgback];
    UIImageWriteToSavedPhotosAlbum(img, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
}


- (void)chooseMB{
    
}
- (void)chooseJX{
    [CGXPickerView showStringPickerWithTitle:@"报考驾校" DataSource:[XLCache singleton].teamCode_title DefaultSelValue:nil IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow) {
        NSLog(@"%@",selectValue);
        self.jiaxia.text = selectValue;
        self.jiaxia.tag = [[XLCache singleton].schoolDeptId[[selectRow intValue]] intValue];
        NSLog(@"%@",[XLCache singleton].teamCode_value[[selectRow intValue]]);
    }];
}
//保存到相册


-(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSString *msg = nil ;
    if(error){ msg = @"保存图片失败" ;
        
    }else{ msg = @"保存图片成功" ;
        
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"保存图片结果提示" message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
    
}




@end
