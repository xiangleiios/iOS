//
//  CommentBtn.m
//  AllTest
//
//  Created by 菜鸟 on 15/7/4.
//  Copyright (c) 2015年 菜鸟. All rights reserved.
//

#import "CommentBtn.h"
#define Height 52
#define kHeight 5
#define TopSpace 16
#define LeftSpace 16
#define BtnW 60

#define WIDTH_v self.bounds.size.width
#define HEIGHT_v self.bounds.size.height
@implementation CommentBtn
{
    UIImageView * _imgView;

}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, Height)];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:244/255.0 alpha:1];
        [self addTextLabel];
        [self addBtn];
        [self layoutSubviews];
        NSLog(@"----------------这个是评论页面");
    }
    return self;
}



- (void)addImgView
{
    _imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"评论_03"]];
    [self addSubview:_imgView];
}

- (void)addTextLabel{

    self.textbut =[[UIButton alloc]initWithFrame:CGRectMake(10, 10, WIDTH_v-130,HEIGHT_v-20)];
    [_textbut setTitle:@"说点什么" forState:UIControlStateNormal];
    [self.textbut setTitleColor:[UIColor colorWithWhite:196/255.0 alpha:1] forState:UIControlStateNormal];
    self.textbut.backgroundColor=[UIColor whiteColor];
    self.textbut.layer.cornerRadius=15;
    self.textbut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self addSubview:_textbut];
}
- (void)textbutjump{
//    [self.delegate pushCommentViewController];
}

- (void)addBtn
{
  
    self.butcollection=[[UIButton alloc]initWithFrame:CGRectMake(WIDTH_v-85, 0, 50, HEIGHT_v)];
    [self addSubview:self.butcollection];
    UIImage *image1=[UIImage imageNamed:@"icon_collect"];
    [self.butcollection setImage:image1 forState:UIControlStateNormal];
    
    UIImage *image4=[UIImage imageNamed:@"tj_shoucang1"];
    [self.butcollection setImage:image4 forState:UIControlStateSelected];
    
    
  
    self.butshare=[[UIButton alloc]initWithFrame:CGRectMake(WIDTH_v-50, 0, 50, HEIGHT_v)];
    [self addSubview:self.butshare];

    UIImage *image2=[UIImage imageNamed:@"icon_share"];
    [self.butshare setImage:image2 forState:UIControlStateNormal];
    
 

//    NSArray *arr=[NSArray arrayWithObjects:_btn,self.butcollection,self.butshare, nil];
//    [arr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:1 leadSpacing:1 tailSpacing:1];
//    [arr mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.textbut.mas_right);
//        make.top.bottom.mas_equalTo(self);
//    }];
    
    _btn = [[UIButton alloc]init];
    _btn.layer.cornerRadius = 4;
    _btn.layer.masksToBounds = YES;
 
    _btn.frame = CGRectMake(WIDTH_v-120, 0, 50, HEIGHT_v);
    [self addSubview:_btn];
    UIImage *image3=[UIImage imageNamed:@"icon_comment"];
    [_btn setImage:image3 forState:UIControlStateNormal];
    
    
    self.comment=[[UILabel alloc]initWithFrame:CGRectMake(25, 10, 25, 13)];
    self.comment.backgroundColor=[UIColor redColor];
    self.comment.layer.cornerRadius=6;
    self.comment.clipsToBounds=YES;
    self.comment.textAlignment=NSTextAlignmentCenter;
    
    self.comment.font=[UIFont systemFontOfSize:10];
    self.comment.textColor=[UIColor whiteColor];
    [self.btn addSubview:self.comment];

    
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
}

- (void)drawRect:(CGRect)rect
{

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.delegate pushCommentViewController];
  
}

- (void)commentTextViewDidFinishWithText:(NSString *)text
{
    [self.textbut setTitle:text forState:UIControlStateNormal];
}

@end
