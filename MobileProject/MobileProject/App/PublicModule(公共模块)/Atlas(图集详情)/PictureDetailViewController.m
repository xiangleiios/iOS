//
//  PictureDetailViewController.m
//  NNHeadline
//
//  Created by 菜鸟 on 15/5/22.
//  Copyright (c) 2015年 菜鸟. All rights reserved.
//

#import "PictureDetailViewController.h"
#import "SheetView.h"
@interface PictureDetailViewController ()<UITextViewDelegate>

@property (nonatomic , strong)ToolbarVC *toolbar;
@property (nonatomic, strong)UIView *bluviwe;
@property (nonatomic, strong)NSMutableArray *imgarr;
@property (nonatomic, assign)CGRect boun;
@property (nonatomic, strong) SheetView * sheetView;
@end

@implementation PictureDetailViewController


-(NSMutableArray *)imgarr{
    if (_imgarr==nil) {
        _imgarr=[NSMutableArray array];
    }
    return _imgarr;
}


-(void)backBarButtonItemClicked{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor blackColor]];
    [self loadsubview];
    _sheetView = [SheetView showSheet];
    [self.view addSubview:_sheetView];
    [self loadtoolbar];
    [self loadscrollview];
 
}

- (void)loadtoolbar{
    ToolbarVC *vc = [[ToolbarVC alloc]init];
    vc.color=[UIColor blackColor];
    vc.model = self.model;
    vc.viewcontroller = self;
    [self.view addSubview:vc.view];
    self.toolbar = vc;
    vc.view.frame = CGRectMake(0, kScreenH - kFit_Font6(50),kScreenW,kFit_Font6(50));
    [self addChildViewController:vc];
}


- (void)loadsubview{
    UIView *view=[[UIView alloc]initWithFrame:self.view.frame];
    view.backgroundColor=[UIColor blackColor];
    view.alpha=0.99;
    [self.view addSubview:view];
    _dataArray = [[NSMutableArray alloc]init];
    _imgArray = [[NSMutableArray alloc]init];
    /*
     *导航栏要换
     */
    UIView *naview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    naview.backgroundColor=[UIColor blackColor];
    [self.view addSubview:naview];
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(10, 20,KFit_W6S(60),KFit_H6S(60))];
    [button setBackgroundImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backBarButtonItemClicked) forControlEvents:UIControlEventTouchUpInside];
    [naview addSubview:button];
    
    self.bluviwe=[[UIView alloc]initWithFrame:self.view.frame];
    self.bluviwe.backgroundColor=[UIColor blackColor];
    self.bluviwe.hidden=YES;
    [self.view addSubview:self.bluviwe];
}

#pragma mark - 加载网络数据
-(void)loadscrollview{
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64-50-150)];
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.backgroundColor=kRGBAColor(17, 17, 17, 0.8);
    [self.view addSubview:_scrollView];
    for (FMSubmodel * submodel in self.model.images) {
        UIImageView * imgView = [[UIImageView alloc]init];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        [imgView setImageWithURL:[NSURL URLWithString:KURLIma(submodel.url)] placeholderImage:[UIImage imageNamed:@"lb-jiazaitu"]];
        [_imgArray addObject:imgView];
        imgView.userInteractionEnabled=YES;
        UITapGestureRecognizer *dianji=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tupiandianji)];
        [imgView addGestureRecognizer:dianji];
        }
    [self.dataArray addObjectsFromArray:self.model.images];
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width*_dataArray.count, 0);
    for (NSInteger num = 0; num<_dataArray.count; num++) {
        UIImageView * imgView = [_imgArray objectAtIndex:num];
        imgView.frame = CGRectMake(_scrollView.frame.size.width*num,_scrollView.frame.size.height-_scrollView.frame.size.width/4*3-50, _scrollView.frame.size.width, _scrollView.frame.size.width/4*3);
        [_scrollView addSubview:imgView];
    }
    [self scrollViewDidEndDecelerating:_scrollView];
}

-(void)tupiandianji{
    NSLog(@"点击手势");
    
    if (self.bluviwe.hidden) {
        _scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        
        [UIView animateWithDuration:0.5 animations:^{
    for (NSInteger num = 0; num<_dataArray.count; num++) {
        UIImageView * imgView = [_imgArray objectAtIndex:num];
        imgView.frame = CGRectMake(_scrollView.frame.size.width*num, SCREEN_HEIGHT/2-(imgView.image.size.height/2),_scrollView.frame.size.width, imgView.image.size.height);
        
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        
        UIPinchGestureRecognizer *rota=[[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(fangda:)];
        [imgView addGestureRecognizer:rota];
        
        
    }
        }];
    }else{
        _scrollView.frame = CGRectMake(0, 60, SCREEN_WIDTH, SCREEN_HEIGHT-64-50-150);
        [UIView animateWithDuration:0.5 animations:^{
            
        for (NSInteger num = 0; num<_dataArray.count; num++) {
            UIImageView * imgView = [_imgArray objectAtIndex:num];
            imgView.frame = CGRectMake(_scrollView.frame.size.width*num,_scrollView.frame.size.height-_scrollView.frame.size.width/4*3-50, _scrollView.frame.size.width, _scrollView.frame.size.width/4*3);
            [imgView removeGestureRecognizer:[imgView gestureRecognizers].lastObject];
            
        }
        }];

    }
    self.bluviwe.hidden=!self.bluviwe.hidden;
}


-(void)fangda:(UIPinchGestureRecognizer *)pinchGestureRecognizer{
    UIImageView *img=(UIImageView *)pinchGestureRecognizer.view;
    if (pinchGestureRecognizer.state == UIGestureRecognizerStateBegan) {
        self.boun=img.frame;
        
    }
    if (pinchGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        img.transform = CGAffineTransformScale(img.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
        pinchGestureRecognizer.scale = 1;
    }
    if (pinchGestureRecognizer.state==UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.2 animations:^{
            img.frame=self.boun;
        }];
    }

}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (!_dataArray.count) {
        return;
    }
    NSInteger page = scrollView.contentOffset.x/SCREEN_WIDTH;
    FMSubmodel *model = [_dataArray objectAtIndex:page];
    _sheetView.titleLabel.text = model.title;
    _sheetView.titleLabel.font=[UIFont systemFontOfSize:20];
    _sheetView.pageLabel.text = [NSString stringWithFormat:@"%ld/%ld",page+1,_dataArray.count];
//    _sheetView.contentLabel.text = self.model.summary;
}

-(void)viewDidAppear:(BOOL)animated
{
    
}
-(void)viewWillAppear:(BOOL)animated{
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    [self.navigationController fm_setStatusBarBackgroundColor:[UIColor clearColor]];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[self navigationController] setNavigationBarHidden:NO animated:NO];

}
-(void)viewDidDisappear:(BOOL)animated
{
    
}




@end
