//
//  ScrollInfinite.m
//  XLProject
//
//  Created by zsgy on 17/8/21.
//  Copyright © 2017年 zsgy. All rights reserved.
//

#import "ScrollInfinite.h"

#define PAGESIZE (1)
static NSInteger page = 1;
@implementation ScrollInfinite

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (NSMutableArray *)subViewArr{
    if (_subViewArr==nil) {
        _subViewArr=[NSMutableArray array];
    }
    return _subViewArr;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadScroll];
    }
    return self;
}

- (void)loadScroll{
    //初始化scrollView 大小为屏幕大小
    UIScrollView *rotateScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    
    //设置分页效果
    rotateScrollView.pagingEnabled = YES;
    //水平滚动条隐藏
    rotateScrollView.showsHorizontalScrollIndicator = NO;
    rotateScrollView.tag = 1000;
    self.scroll=rotateScrollView;
    [self addSubview:rotateScrollView];

    
    //为滚动视图指定代理
    rotateScrollView.delegate = self;
    
}
#pragma mark-添加数据源
- (void)setTitleArr:(NSArray *)titleArr{
    _titleArr=titleArr;
    NSInteger cent_i=titleArr.count/PAGESIZE;
    if ((titleArr.count%PAGESIZE)!=0) {
        cent_i++;
    }
    page=cent_i;
    //设置滚动范围
    self.scroll.contentSize = CGSizeMake(0, CGRectGetHeight(self.frame)*page);
    for (NSInteger i=0; i<cent_i; i++) {
        UIView *sub=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame)*i, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
//        sub.backgroundColor=kRandomColor;
        [self.subViewArr addObject:sub];
        [self.scroll addSubview:sub];
    }
    ////为滚动视图的下边添加一个视图，使得它和第一个视图一模一样。
    UIView *belowView=[[UIView alloc]initWithFrame:CGRectMake(0, cent_i*CGRectGetHeight(self.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    [self.scroll addSubview:belowView];
    CGFloat h=CGRectGetHeight(self.frame)/PAGESIZE;
    for (NSInteger i=0; i<titleArr.count; i++) {
        UIButton *butt = [[UIButton alloc]initWithFrame:CGRectMake(0, i%PAGESIZE*h, CGRectGetWidth(self.frame), h)];
        butt.titleLabel.font=[UIFont systemFontOfSize:kFit_Font6(15)];
        
        butt.titleLabel.textAlignment = NSTextAlignmentLeft;
        butt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        butt.tag = i;
        butt.titleEdgeInsets=UIEdgeInsetsMake(0, kFit_Font6(1), 0, 0);
        [butt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [butt setImage:[UIImage imageNamed:@"wz-yuan"] forState:UIControlStateNormal];
        [butt addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        NSString *str = i <= titleArr.count ? titleArr[i] : nil;
        [butt setTitle:str forState:UIControlStateNormal];
        butt.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        NSInteger view_i=i/PAGESIZE;
        UIView *v=self.subViewArr[view_i];
        [v addSubview:butt];
        if (i<PAGESIZE) {
            UIButton *but = [[UIButton alloc]initWithFrame:CGRectMake(0, i%PAGESIZE*h, CGRectGetWidth(self.frame), h)];
            [but setImage:[UIImage imageNamed:@"wz-yuan"] forState:UIControlStateNormal];
            but.titleLabel.font=[UIFont systemFontOfSize:kFit_Font6(15)];
            
            but.titleLabel.textAlignment = NSTextAlignmentLeft;
            but.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            but.tag = i;
            but.titleEdgeInsets=UIEdgeInsetsMake(0, kFit_Font6(1), 0, 0);
            [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [but addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            NSString *str = i <= titleArr.count ? titleArr[i] : nil;
            [but setTitle:str forState:UIControlStateNormal];
            but.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            [belowView addSubview:but];
        }
        
    }
    //启动定时器
    self.rotateTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(changeView) userInfo:nil repeats:YES];
}


- (void)buttonAction:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(ScrollInfiniteButten:tagIndex:)]) {
        [self.delegate ScrollInfiniteButten:sender tagIndex:sender.tag];
    }
    
}


#pragma mark -- 滚动视图的代理方法 
//开始拖拽的代理方法，在此方法中暂停定时器。
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    NSLog(@"正在拖拽视图，所以需要将自动播放暂停掉");
    //setFireDate：设置定时器在什么时间启动
    //[NSDate distantFuture]:将来的某一时刻
    [self.rotateTimer setFireDate:[NSDate distantFuture]];
}
//视图静止时（没有人在拖拽），开启定时器，让自动轮播
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //视图静止之后，过1.5秒在开启定时器
    //[NSDate dateWithTimeInterval:1.5 sinceDate:[NSDate date]] 返回值为从现在时刻开始 再过1.5秒的时刻。
    NSLog(@"开启定时器");
    [self.rotateTimer setFireDate:[NSDate dateWithTimeInterval:1.5 sinceDate:[NSDate date]]];
}
//定时器的回调方法 切换界面
- (void)changeView{
    //得到scrollView
    UIScrollView *scrollView = [self viewWithTag:1000];
    //通过改变contentOffset来切换滚动视图的子界面
    float offset_Y = scrollView.contentOffset.y;
    //每次切换一个屏幕
    offset_Y += CGRectGetHeight(self.frame);
    //说明要从最右边的多余视图开始滚动了，最右边的多余视图实际上就是第一个视图。所以偏移量需要更改为第一个视图的偏移量。
    if (offset_Y > CGRectGetHeight(self.frame)*page) {
        scrollView.contentOffset = CGPointMake(0, 0);
    }
    //说明正在显示的就是最右边的多余视图，最右边的多余视图实际上就是第一个视图。所以pageControl的小白点需要在第一个视图的位置。
    if (offset_Y == CGRectGetHeight(self.frame)*page) {
        self.myPageControl.currentPage = 0;
    }else{
        self.myPageControl.currentPage = offset_Y/CGRectGetHeight(self.frame);
    }
    //得到最终的偏移量
    CGPoint resultPoint = CGPointMake(0, offset_Y);
    //切换视图时带动画效果
    //最右边的多余视图实际上就是第一个视图，现在是要从第一个视图向第二个视图偏移，所以偏移量为一个屏幕宽度
    if (offset_Y >CGRectGetHeight(self.frame)*page) {
        self.myPageControl.currentPage = 1;
        [scrollView setContentOffset:CGPointMake(0,CGRectGetHeight(self.frame)) animated:YES];
    }else{
        [scrollView setContentOffset:resultPoint animated:YES];
    }
}




@end
