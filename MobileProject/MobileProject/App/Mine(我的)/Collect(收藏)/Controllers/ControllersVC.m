//
//  ControllersVC.m
//  MobileProject
//
//  Created by zsgy on 2017/11/10.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "ControllersVC.h"
#import "SegmentViewController.h"
#import "ControllersListVC.h"
@interface ControllersVC ()
@property (nonatomic ,strong)SegmentViewController *segmentVC;
@property (nonatomic , strong)UIButton *navbut;
@property (nonatomic , strong)NSMutableArray *controlArray;
@end

@implementation ControllersVC
-(NSMutableArray *)controlArray{
    if (_controlArray==nil) {
        _controlArray=[NSMutableArray array];
    }
    return _controlArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"我的收藏";
    [self loadsubview];
    [self loadNav];
    // Do any additional setup after loading the view.
}

- (void)loadNav{
    UIButton *but=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, KFit_W6S(80), KFit_W6P(40))];
    self.navbut=but;
    [but setTitle:@"确定" forState:UIControlStateSelected];
    [but setTitle:@"编辑" forState:UIControlStateNormal];
    [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [but setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    but.titleLabel.font=[UIFont systemFontOfSize:kFit_Font6(16)];
    [but addTarget:self action:@selector(rightNav:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:but];
    self.navigationItem.rightBarButtonItem = rightBarItem;
}
- (void)rightNav:(UIButton *)senter{
    if (senter.selected) {
        for (ControllersListVC *vc in self.controlArray) {
            [vc ExittheEditor];
        }
    }else{
        for (ControllersListVC *vc in self.controlArray) {
            [vc enterTheEdit];
        }
    }
    senter.selected=!senter.selected;
}

- (void)loadsubview{
    self.segmentVC = [[SegmentViewController alloc]init];
    NSArray *titleArray= @[@"资讯",@"景点",@"演出",@"活动",@"其他"];
    NSArray *type=@[[FMSingle moduleTypeArticle],[FMSingle moduleTypeScenic],[FMSingle moduleTypeFilm],[FMSingle moduleTypeActivity],[FMSingle moduleTypePage]];
    
    for (int i = 0; i < titleArray.count; i ++) {
        
        ControllersListVC *vc = kAllocInit(ControllersListVC);
        vc.module_type=type[i];
        [self.controlArray addObject:vc];
    }
    self.segmentVC.titleArray = titleArray;
    self.segmentVC.fontSize = kFit_Font6(16);
    self.segmentVC.titleSelectedColor = kRGBColor(226, 52, 69);;
    self.segmentVC.titleColor = kRGBColor(102, 102, 102);;
    self.segmentVC.headViewBackgroundColor = kWhiteColor;
    self.segmentVC.bottomScreenLineColor = [UIColor lightGrayColor];
    self.segmentVC.bottomLineColor = kRGBColor(226, 52, 69);;
    self.segmentVC.subViewControllers = self.controlArray;
    self.segmentVC.buttonWidth = KFit_W6S(180);
    self.segmentVC.buttonHeight = KFit_H6S(60);
    self.segmentVC.bottomLineHeight = kFit_Font6(3);
    self.segmentVC.bottomLineWidth = KFit_W6S(160);
    //    vc.topToNav = KFit_H6S(620);
    [self.segmentVC initSegment];
    self.segmentVC.view.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.segmentVC addParentController:self];
    NSArray *gestureArray = self.navigationController.view.gestureRecognizers;
    //当是侧滑手势的时候设置scrollview需要此手势失效才生效即可 让某个scrollView支持全局侧滑手势 【viewDidLoad方法中调用】
    for (UIGestureRecognizer *gesture in gestureArray) {
        if ([gesture isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]) {
            [self.segmentVC.mainScrollView.panGestureRecognizer requireGestureRecognizerToFail:gesture];
        }
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
