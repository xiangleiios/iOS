//
//  MyPicturePosterVC.m
//  MobileProject
//
//  Created by 向蕾 on 2018/10/9.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "MyPicturePosterVC.h"
#import "CodeShareV.h"

#import "PicturePosterVC.h"
@interface MyPicturePosterVC ()
@property (nonatomic , strong)UIView *imgback;
@property (nonatomic , strong)UIImageView *img;

@property (nonatomic , strong)UIButton *savebut;
@property (nonatomic , strong)UIButton *sharebut;
@property (nonatomic , strong)UIButton *makebut;

@end

@implementation MyPicturePosterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationView setTitle:_model.tittle];
    [self loadsubview];
    
    [self laodShourAndSave];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
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
    [self.img sd_setImageWithURL:[NSURL URLWithString:KURLIma(_model.memo)]];
    [self.imgback addSubview:self.img];
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(self.imgback);
    }];
}

#pragma mark - 分享和保存按钮
- (void)laodShourAndSave{
    self.makebut = [[UIButton alloc] init];
    [self.view addSubview:self.makebut];
    self.makebut.layer.cornerRadius = kFit_Font6(5);
    self.makebut.layer.masksToBounds = YES;
    self.makebut.layer.borderColor = kColor_N(220, 220, 220).CGColor;
    self.makebut.layer.borderWidth = 0.5;
    [self.makebut setTitle:@"再次制作" forState:UIControlStateNormal];
    [self.makebut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.makebut setBackgroundImage:[UIImage createImageWithColor:kColor_N(255, 255, 255)] forState:UIControlStateNormal];
    [self.makebut setBackgroundImage:[UIImage createImageWithColor:kRGBAColor(255, 255, 255, 0.6)] forState:UIControlStateHighlighted];
    [self.makebut addTarget:self action:@selector(making) forControlEvents:UIControlEventTouchUpInside];
    
    
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
    [self.savebut setBackgroundImage:[UIImage createImageWithColor:kColor_N(147, 158, 180)] forState:UIControlStateNormal];
    [self.savebut setBackgroundImage:[UIImage createImageWithColor:kRGBAColor(147, 158, 180, 0.6)] forState:UIControlStateHighlighted];
    [self.savebut addTarget:self action:@selector(toSave) forControlEvents:UIControlEventTouchUpInside];
    
    NSArray *arr = @[self.makebut,self.sharebut,self.savebut];
    [arr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:KFit_W6S(10) leadSpacing:KFit_W6S(30) tailSpacing:KFit_W6S(30)];
    [arr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view).mas_offset(-KFit_W6S(30));
        make.height.mas_equalTo(KFit_H6S(90));
    }];
    
}
- (void)making{
    PicturePosterVC *vc = [[PicturePosterVC alloc] init];
    vc.type = PostersListTypeMy ;
    vc.url = POSTUserDetail;
    vc.model = self.model;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -调用分享
- (void)toShare{
    CodeShareV *v = [[CodeShareV alloc] init];
    v.type = ShareTypeImage;
    XLshare *share = [[XLshare alloc]init];
    share.shareImgUrl = self.model.memo;
    v.share = share;
    [v show];
}

#pragma mark -保存海报
- (void)toSave{
    UIImageWriteToSavedPhotosAlbum(self.img.image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
}
-(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSString *msg = nil ;
    if(error){ msg = @"保存图片失败" ;
        
    }else{ msg = @"已保存图片到相册" ;
        
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"保存图片" message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
    
}
@end
