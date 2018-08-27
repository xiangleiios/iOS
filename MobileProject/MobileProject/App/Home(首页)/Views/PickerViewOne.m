//
//  PickerView.m
//  Hu8huWorker
//
//  Created by xiaopeng on 2017/4/24.
//  Copyright © 2017年 王小朋. All rights reserved.
//

#import "PickerViewOne.h"

#define onePickerH (self.frame.size.height/3.0)
#define midPickerH (self.frame.size.height/3.0)
#define difference ((self.frame.size.height/3.0)/2.0)


@interface PickerViewOne ()<UIScrollViewDelegate>

@property (strong, nonatomic) UIView * select;
@property (strong, nonatomic) UIScrollView * startTime;
@property (strong, nonatomic) UIView  * all;
@property (strong, nonatomic) UILabel * allText;
@property (strong, nonatomic) UISwitch * allSwithch;
@property (assign, nonatomic) NSInteger  num;

@end

@implementation PickerViewOne

- (instancetype)initWithFrame:(CGRect)frame midArry:(NSMutableArray *)midArry{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        /**
         处理数组
         */
        [midArry insertObject:@"数组第一位" atIndex:0];
        [midArry addObject:@"数组最后一位"];
        
        
        _num = midArry.count;
        
        self.select = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:self.select];
        
        self.startTime = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.startTime.delegate = self;
        [self.startTime setShowsVerticalScrollIndicator:NO];
        [self.startTime setShowsHorizontalScrollIndicator:NO];
        [self.select addSubview:self.startTime];
        
        
        [self addStart:frame leftArry:midArry];
        
        
        /*
         UILabel * label1 = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width/2-10, 0, 20, onePickerH)];
         [label1 setText:@"~"];
         [label1 setTextAlignment:NSTextAlignmentCenter];
         [label1 setTextColor:[UIColor blackColor]];
         
         UILabel * label2 = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width/2-10, 40, 20, onePickerH)];
         [label2 setText:@"~"];
         [label2 setTextAlignment:NSTextAlignmentCenter];
         [label2 setTextColor:[UIColor blackColor]];
         
         UILabel * label3 = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width/2-10, 80, 20, onePickerH)];
         [label3 setText:@"~"];
         [label3 setTextAlignment:NSTextAlignmentCenter];
         [label3 setTextColor:[UIColor blackColor]];
         
         [self addSubview:label1];
         [self addSubview:label2];
         [self addSubview:label3];
         */
        
        UIView * seleViewColor = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height/3, frame.size.width-1, frame.size.height/3)];
        [seleViewColor setBackgroundColor:kColor_N(232, 252, 225)];
        seleViewColor.layer.borderWidth = 0.5;
        seleViewColor.layer.borderColor = kColor_N(120, 193, 142).CGColor;
        [self.select addSubview:seleViewColor];
        
        [self.select bringSubviewToFront:self.startTime];

    }
    return self;
}

- (void)addStart:(CGRect)frame leftArry:(NSArray *)leftArry{

    for(NSInteger index = 0; index < leftArry.count; index++){
        
        
        NSString * title = @"";
        if(index != 0 && index != leftArry.count-1){
           
            title = [NSString stringWithFormat:@"%@",leftArry[index]];
        }
        UILabel * startTime = [[UILabel alloc] initWithFrame:CGRectMake(0, index*onePickerH, frame.size.width,onePickerH)];
        [startTime setText:title];
        startTime.tag = 10 + index;
        [startTime setTextAlignment:NSTextAlignmentCenter];
        if (index == 1) {
            
//            [startTime setTextColor:UIColorFromRGB(0xff333333)];
            [startTime setTextColor:appcoloer];
            [startTime setFont:[UIFont systemFontOfSize:15]];
        }else{
            
            [startTime setTextColor:UIColorFromRGB(0xffaaaaaa)];
            [startTime setFont:[UIFont systemFontOfSize:13]];
        }
        
        [self.startTime addSubview:startTime];
        
    }
    
    [self.startTime setContentSize:CGSizeMake(frame.size.width/2,onePickerH*leftArry.count)];
}


//4、已经结束拖拽，手指刚离开view的那一刻
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{


    if(!decelerate){
        CGFloat  pointY=scrollView.contentOffset.y;
        int s = pointY/onePickerH;
        CGFloat f =  pointY - s * onePickerH;
        int s1 = s;
        KKLog(@"%lf    %lf   %lf",f,difference,self.frame.size.height);
        NSString *text;
        if(f>difference){
            s1 = s+1;
//            NSLog(@"%d",s1*(onePickerH));
            [scrollView setContentOffset:CGPointMake(0, s1*onePickerH) animated:YES];
        }else{
            s1 = s;
//            NSLog(@"%d",s1*onePickerH);
            [scrollView setContentOffset:CGPointMake(0, s1*onePickerH) animated:YES];
        }

        for (int i = 0; i < _num; i++) {
            if ( i == s1+1) {

                UILabel * textLabel = [self.startTime viewWithTag:i+10];
                text = textLabel.text;
                NSLog(@"%@",textLabel.text);
//                textLabel.textColor = UIColorFromRGB(0xff333333);
                textLabel.textColor = appcoloer;
                textLabel.font = [UIFont systemFontOfSize:15];
            }else{

                UILabel * textLabel = [self.startTime viewWithTag:i+10];
                textLabel.textColor = UIColorFromRGB(0xffaaaaaa);
                textLabel.font = [UIFont systemFontOfSize:13];
                
            }
        }

        if ([self.delegate respondsToSelector:NSSelectorFromString(@"PickerViewOneDelegateOncleck:Text:")]) {
            [self.delegate  PickerViewOneDelegateOncleck:s1 Text:text];
        }
    }
}

//6、view已经停止滚动
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat pointY=scrollView.contentOffset.y;
//    CGFloat f =  pointY %(int)onePickerH;
    int s = pointY/onePickerH;
    CGFloat f =  pointY - s * onePickerH;
//    int s = pointY/onePickerH;
    int s1;
    NSString *text;
    KKLog(@"%lf    %lf   %lf",f,difference,self.frame.size.height);
    if(f>difference){
        s1 = s+1;
//        NSLog(@"%d",s1*onePickerH);
        [scrollView setContentOffset:CGPointMake(0, s1*onePickerH) animated:YES];

    }else{
        s1 = s;
//        NSLog(@"%d",s1*onePickerH);
        [scrollView setContentOffset:CGPointMake(0, s1*onePickerH) animated:YES];
    }

    for (int i = 0; i < _num; i++) {
        if ( i == s1+1) {

            UILabel * textLabel = [self.startTime viewWithTag:i+10];
            NSLog(@"%@",textLabel.text);
            text = textLabel.text;
//            textLabel.textColor = UIColorFromRGB(0xff333333);
            textLabel.textColor = appcoloer;
            textLabel.font = [UIFont systemFontOfSize:15];
        }else{

            UILabel * textLabel = [self.startTime viewWithTag:i+10];
            textLabel.textColor = UIColorFromRGB(0xffaaaaaa);
            textLabel.font = [UIFont systemFontOfSize:13];
        }
    }
    if ([self.delegate respondsToSelector:NSSelectorFromString(@"PickerViewOneDelegateOncleck:Text:")]) {
        [self.delegate  PickerViewOneDelegateOncleck:s1 Text:text];
        
    }
}

@end
