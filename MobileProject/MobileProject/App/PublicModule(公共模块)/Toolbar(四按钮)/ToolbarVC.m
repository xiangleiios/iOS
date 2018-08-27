//
//  ToolbarVC.m
//  MobileProject
//
//  Created by zsgy on 17/8/4.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "ToolbarVC.h"
#import "CommentDetailsVC.h"
@interface ToolbarVC ()
@property (nonatomic , strong)UIImageView *backview;
@property (nonatomic , strong)UIButton *Input;
@property (nonatomic , strong)UIButton *comments;
@property (nonatomic , strong)UIButton *share;
@property (nonatomic , strong)UIButton *collection;
@end

@implementation ToolbarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadBackView];
    [self loadFunctionButs];
    /* 判断是否收藏*/
    [self determineWhetherToCollect];
}

- (void)loadBackView{
    self.backview = [[UIImageView alloc]init];
    self.backview.userInteractionEnabled = YES;
    [self.backview setImage:[UIImage imageNamed:@"comment_background"]];
    [self.view addSubview:self.backview];
    [self.backview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(kFit_Font6(50));
    }];
    if (self.color == nil) {
       self.backview.backgroundColor = kRGBColor(250, 109, 86);
        self.backview.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.backview.layer.borderWidth = 0.5;
    }else{
        self.backview.backgroundColor =self.color;
    }
    
    
    
}

- (void)loadFunctionButs{
//    self.Input = [[UIButton alloc]init];
//    [self.Input setImage:[UIImage imageNamed:@"xq-shuru"] forState:UIControlStateNormal];
//    [self.Input addTarget:self action:@selector(toinput) forControlEvents:UIControlEventTouchUpInside];
//    [self.backview addSubview:self.Input];
    
    self.comments = [[UIButton alloc]init];
    [self.comments setImage:[UIImage imageNamed:@"icon_comment"] forState:UIControlStateNormal];
    [self.comments setTitle:@"评论" forState:UIControlStateNormal];
    [self.comments setTitleColor:kRGBColor(74, 74, 74) forState:UIControlStateNormal];
    [self.comments addTarget:self action:@selector(toCommentDetails) forControlEvents:UIControlEventTouchUpInside];
    self.comments.titleLabel.font=[UIFont systemFontOfSize:kFit_Font6(15)];
    [self.backview addSubview:self.comments];
    
    
    self.share = [[UIButton alloc]init];
    [self.share setImage:[UIImage imageNamed:@"icon_share"] forState:UIControlStateNormal];
    [self.share setTitle:@"分享" forState:UIControlStateNormal];
    [self.share setTitleColor:kRGBColor(74, 74, 74) forState:UIControlStateNormal];
    [self.share addTarget:self action:@selector(toshare) forControlEvents:UIControlEventTouchUpInside];
    self.share.titleLabel.font=[UIFont systemFontOfSize:kFit_Font6(15)];
    [self.backview addSubview:self.share];
    
    self.collection = [[UIButton alloc]init];
    [self.collection setImage:[UIImage imageNamed:@"icon_collected"] forState:UIControlStateNormal];
    [self.collection setImage:[UIImage imageNamed:@"icon_alreadycollected"] forState:UIControlStateSelected];
    [self.collection setTitle:@"收藏" forState:UIControlStateNormal];
    [self.collection setTitleColor:kRGBColor(74, 74, 74) forState:UIControlStateNormal];
    [self.collection addTarget:self action:@selector(tocollection:) forControlEvents:UIControlEventTouchUpInside];
    self.collection.titleLabel.font=[UIFont systemFontOfSize:kFit_Font6(15)];
    [self.backview addSubview:self.collection];
    
    
    NSArray *arr = [NSArray arrayWithObjects:self.comments,self.collection,self.share, nil];
    [arr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:KFit_W6S(160) leadSpacing:KFit_W6S(80) tailSpacing:KFit_W6S(80)];
    [arr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.backview);
        make.height.mas_equalTo(KFit_W6S(70));
    }];
    self.comments.imageEdgeInsets = UIEdgeInsetsMake(0, KFit_W6S(50), 0, -KFit_W6S(100));
    self.comments.titleEdgeInsets = UIEdgeInsetsMake(0, -KFit_W6S(10), 0, KFit_W6S(50));
    self.share.imageEdgeInsets = UIEdgeInsetsMake(0, KFit_W6S(50), 0, -KFit_W6S(100));
    self.share.titleEdgeInsets = UIEdgeInsetsMake(0, -KFit_W6S(10), 0, KFit_W6S(50));

    self.collection.imageEdgeInsets = UIEdgeInsetsMake(0, KFit_W6S(50), 0, -KFit_W6S(100));
    self.collection.titleEdgeInsets = UIEdgeInsetsMake(0, -KFit_W6S(10), 0, KFit_W6S(50));

}

#pragma mark-弹出评论
//- (void)toinput{
//    [self.viewcontroller.inputvc.input.textView becomeFirstResponder];
//}

#pragma mark-跳转评论
- (void)toCommentDetails{
    CommentDetailsVC *vc=[[CommentDetailsVC alloc]init];
    vc.model=self.model;
    [self.viewcontroller.navigationController pushViewController:vc animated:YES];
}

#pragma mark-分享
- (void)toshare{
    XLshare *share = [[XLshare alloc]init];
    share.title = self.model.title;
    share.image_url = self.model.image_url.length ? KURLIma(self.model.image_url) : (self.model.images.count > 0?KURLIma([self.model.images firstObject].url):@"");
    share.subTitle = self.model.subtitle;
    NSString *url = @"";
    if ([self.model.module_type isEqualToString:[FMSingle moduleTypeScenic]]) { // 景点分享
        url = [NSString stringWithFormat:GETscenicsShare,self.model.idid];
        
    }else if ([self.model.module_type isEqualToString:[FMSingle moduleTypeTopic]]) {
        url = [NSString stringWithFormat:GETtopicsShare,self.model.idid];
        
    }else if ([self.model.module_type isEqualToString:[FMSingle moduleTypeArticle]]) {
        url = [NSString stringWithFormat:GETarticlesShare,self.model.idid];
    }else if ([self.model.module_type isEqualToString:[FMSingle moduleTypeFilm]]) {
        url = [NSString stringWithFormat:GETfilmsShare,self.model.idid];
    }else if ([self.model.module_type isEqualToString:[FMSingle moduleTypeActivity]]) {
        url = [NSString stringWithFormat:GETactivitiesShare,self.model.idid];
    }else if ([self.model.module_type isEqualToString:[FMSingle moduleTypeShow]]) {
        url = [NSString stringWithFormat:GETshowsShare,self.model.idid];
    }
    share.url = url;
    [share umengShare:self.view];
}


- (void)tocollection:(UIButton *)sender{
    if (![[User UserOb] UserLogin]) {
        [FMHelper fm_showLoginAlertWithController:self.viewcontroller tipsStringIfNilShowDefault:nil];
        return;
    }
    if (sender.selected) {
    //取消收藏
        NSString *url = [NSString stringWithFormat:GETfavoritesDelete,self.model.idid,self.model.module_type,[User UserOb].token];
        [self addOrCancelCollection:url finishShow:@"已取消" isGetRequest:YES];;
    }else{
    //添加收藏
        NSString *urladd = [NSString stringWithFormat:POSTaddFavorites,self.model.idid,self.model.module_type,[User UserOb].token];
        [self addOrCancelCollection:urladd finishShow:@"收藏成功" isGetRequest:NO];
    }
}
#pragma mark-添加取消收藏
- (void)addOrCancelCollection:(NSString *)url finishShow:(NSString *)hud isGetRequest:(BOOL)isGet {
    if (isGet) {
        [FMNetworkHelper fm_request_getWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
            if (kResponseObjectStatusCodeIsEqual(200)) {
                [MBProgressHUD showAutoMessage:hud];
                self.collection.selected = !self.collection.selected;
            }else{
                [MBProgressHUD showAutoMessage:responseObject[@"message"]];
            }
        } failureBlock:^(NSError *error) {
            
        } progress:nil];
    }else {
        [FMNetworkHelper fm_request_postWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
            if (kResponseObjectStatusCodeIsEqual(200)) {
                [MBProgressHUD showAutoMessage:hud];
                self.collection.selected = !self.collection.selected;
            }else{
                [MBProgressHUD showAutoMessage:responseObject[@"message"]];
            }
        } failureBlock:^(NSError *error) {
            
        } progress:nil];
    }
    
}

#pragma mark-判断是否收藏
- (void)determineWhetherToCollect{
    //登录才判断
    if ([[User UserOb] UserLogin]) {
        NSString *url = [NSString stringWithFormat:GETfavoritesExist,self.model.idid,self.model.module_type,[User UserOb].token];
        [FMNetworkHelper fm_request_getWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
            if (kResponseObjectStatusCodeIsEqual(200)) {
                self.collection.selected = YES;
            }
        } failureBlock:^(NSError *error) {
            
        } progress:nil];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
