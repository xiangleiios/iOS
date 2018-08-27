//
//  FMNavSegmentVC.h
//  MobileProject
//
//  Created by zsgy on 17/6/23.
//  Copyright © 2017年 Mingoy. All rights reserved.
//

#import "FMNavSegmentVC.h"
#import "UIColor+FMExtension.h"
#import "UIImage+FMExtension.h"


#define kSpace 30
@interface FMNavSegmentVC ()<UIScrollViewDelegate>

@property (nonatomic , strong)UIButton *selectbut;
@property (nonatomic , strong)UILabel *selectlab;
@property (nonatomic , strong)UIScrollView *scroll;


@end

@implementation FMNavSegmentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
    
    [self initNavButtons];//导航样式
}

//导航样式
- (void)initNavButtons{
//    self.navigationController.navigationBar.translucent = NO;
//    UIBarButtonItem *itme = [[UIBarButtonItem alloc] init];
//    [itme setImage:[UIImage imageNamed:@"personal_center_selected_icon"]];
//    self.navigationItem.leftBarButtonItem = itme;
    
    //导航上的两个按钮
    UIView *bacview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    UIButton *buton=[[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth/2,0 , kScreenWidth*0.2, 40)];
//    [buton setTitle:@"推荐" forState:UIControlStateSelected];
    [buton setTitle:@"推荐" forState:UIControlStateNormal];
    [buton setImage:[UIImage imageNamed:@"matrix_detail_icon"] forState:UIControlStateNormal];
    [buton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [buton setTitleColor:[UIColor colorWithRed:252/255.0 green:102/255.0 blue:78/255.0 alpha:1] forState:UIControlStateSelected];
    [bacview addSubview:buton];
    buton.tag=0;
    buton.selected=YES;
    self.selectbut=buton;
    self.self.yfButton1th=buton;
    
    UIButton *buttwo=[[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth/4*3, 0, kScreenWidth*0.2, 40)];
//    [buttwo setTitle:@"广场" forState:UIControlStateSelected];
    [buttwo setTitle:@"广场" forState:UIControlStateNormal];
    [buttwo setImage:[UIImage imageNamed:@"politics_selected_icon"] forState:UIControlStateNormal];
    [buttwo setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [buttwo setTitleColor:[UIColor colorWithRed:252/255.0 green:102/255.0 blue:78/255.0 alpha:1] forState:UIControlStateSelected];
    [bacview addSubview:buttwo];
    self.yfButton2th = buttwo;
    buttwo.tag=1;
 
//    buttwo.selected = YES;
//    self.selectbut = buttwo;
    self.navigationItem.titleView=bacview;
    
//    self.selectlab=[[UILabel alloc]initWithFrame:CGRectMake( kScreenWidth*0.2 /* bacview.width/2 */, 40, kScreenWidth*0.2, 4)];
//    self.selectlab.backgroundColor=[UIColor colorWithRed:252/255.0 green:102/255.0 blue:78/255.0 alpha:1];
//    [bacview addSubview:self.selectlab];
    //按钮点击方法
    [buton addTarget:self action:@selector(navigationMethod:) forControlEvents:UIControlEventTouchUpInside];
    [buttwo addTarget:self action:@selector(navigationMethod:) forControlEvents:UIControlEventTouchUpInside];
    // *创建滚动视图
    [self addscrollview];
}



- (void)addscrollview{
    self.scroll =[[UIScrollView alloc]initWithFrame:self.view.frame];
    self.scroll.height -= kNavBarH;
    self.scroll.contentSize=CGSizeMake(2*kScreenWidth,0);
    self.scroll.bounces=NO;
    self.scroll.pagingEnabled=YES;
    self.scroll.delegate=self;
    
//    self.scroll.backgroundColor=[UIColor redColor];
    [self.view addSubview:self.scroll];
    [self addsubVC];
}

- (void)addsubVC {
   

}

#pragma mark-滚动视图代理
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if(scrollView.contentOffset.x/kScreenWidth){
        [self navigationMethod:self.yfButton2th];

    }else{
        [self navigationMethod:self.self.yfButton1th];

    }
}

- (void)navigationMethod:(UIButton *)sender{
    
    self.selectbut.selected=NO;
    sender.selected=YES;    //一二两行顺序不能换
    self.selectbut=sender;
    [UIView animateWithDuration:0.3 animations:^{
        self.selectlab.frame=CGRectMake(sender.frame.origin.x, 40, kScreenWidth*0.2, 4);
    }];
    self.scroll.contentOffset=CGPointMake(sender.tag*kScreenWidth, 0);

}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

//    [self navigationMethod:self.self.yfButton1th];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.yfButton1th.selected = YES;
    self.selectbut = self.yfButton1th;
    
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage fm_imageWithColor:kWhiteColor] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = nil;
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];

//    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:164/255.0 green:173/255.0 blue:181/255.0 alpha:1]];
   
//    self.selectlab.frame=CGRectMake(self.selectbut.frame.origin.x, 40, kScreenWidth*0.2, 4);
    // 设置scrollView滚动到指定位置
//    [self.scroll setContentOffset:CGPointMake(kScreenWidth,0) animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}


@end
