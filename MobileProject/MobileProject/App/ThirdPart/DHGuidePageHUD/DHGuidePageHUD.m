//
//  DHGuidePageHUD.m
//  DHGuidePageHUD
//
//  Created by Apple on 16/7/14.
//  Copyright © 2016年 dingding3w. All rights reserved.
//

#import "DHGuidePageHUD.h"
#import "DHGifImageOperation.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVKit/AVKit.h>
#import "UIImageView+WebCache.h"
#import "FMSingle.h"
#import "ModelGuaideIma.h"

#define DDHidden_TIME   3.0
#define DDScreenW   [UIScreen mainScreen].bounds.size.width
#define DDScreenH   [UIScreen mainScreen].bounds.size.height

@interface DHGuidePageHUD ()<UIScrollViewDelegate>
@property (nonatomic, strong) NSArray                 *imageArray;
@property (nonatomic, strong) UIPageControl           *imagePageControl;
@property (nonatomic, assign) NSInteger               slideIntoNumber;
@property (nonatomic, strong) MPMoviePlayerController *playerController;
@property (nonatomic, assign) NSInteger skipTime;
@property (nonatomic, assign) NSInteger skipTimeGo;

@property (nonatomic, strong) UIButton *skipButton;
@property (nonatomic, strong) NSTimer *skipTimer;
@end

@implementation DHGuidePageHUD

- (instancetype)dh_initWithFrame:(CGRect)frame imageNameArray:(NSArray<ModelGuaideIma *> *)imageNameArray buttonIsHidden:(BOOL)isHidden {
   
    if ([super initWithFrame:frame]) {
        self.slideInto = NO;
        if (isHidden == YES) {
            self.imageArray = imageNameArray;
        }
        
        // 设置引导视图的scrollview
        UIScrollView *guidePageView = [[UIScrollView alloc]initWithFrame:frame];
        [guidePageView setBackgroundColor:[UIColor lightGrayColor]];
        [guidePageView setContentSize:CGSizeMake(DDScreenW, DDScreenH)];
        [guidePageView setBounces:NO];
        [guidePageView setUserInteractionEnabled:YES];
        [guidePageView setPagingEnabled:YES];
        [guidePageView setShowsHorizontalScrollIndicator:NO];
        [guidePageView setDelegate:self];
        [self addSubview:guidePageView];
        
         _skipTime = 3.0 * imageNameArray.count;
        _skipTimeGo = 0;
        
        // 设置引导页上的跳过按钮
        _skipButton = [[UIButton alloc]initWithFrame:CGRectMake(DDScreenW*0.8, DDScreenW*0.05, DDScreenW*0.15, 18)];
        [_skipButton setTitle:[NSString stringWithFormat:@"跳过:%ld秒",(long)_skipTime] forState:UIControlStateNormal];
        [_skipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_skipButton setBackgroundColor:[UIColor grayColor]];
        [_skipButton.titleLabel setFont:[UIFont systemFontOfSize:11]];
        [_skipButton setAlpha:0.3];
        [_skipButton.layer setCornerRadius:9.0];
        [_skipButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_skipButton];
    
        
        // 添加在引导视图上的多张引导图片
        for (int i=0; i<imageNameArray.count; i++) {
            self.hidden = YES;
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(DDScreenW*i, 0, DDScreenW, DDScreenH)];
            imageView.userInteractionEnabled = YES;
 
            UIButton *guaideImaClick = [[UIButton alloc] init];
            guaideImaClick.tag = i;
            [guaideImaClick setFrame:CGRectMake(DDScreenW*i, 0, DDScreenW, DDScreenH)];
            [guaideImaClick addTarget:self action:@selector(yfGuaideImaClick:) forControlEvents:UIControlEventTouchUpInside];
            
            
            if ([[DHGifImageOperation dh_contentTypeForImageData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageNameArray[i].imageUrl ofType:nil]]] isEqualToString:@"gif"]) {
                NSData *localData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageNameArray[i].imageUrl ofType:nil]];
                imageView = (UIImageView *)[[DHGifImageOperation alloc] initWithFrame:imageView.frame gifImageData:localData];
                [guidePageView addSubview:imageView];
            } else {
                
                if ([FMSingle shareSingle].is1ShowNilGuaideIma == 1) {
                 
                    imageView.image = [UIImage imageNamed:imageNameArray[i].imageUrl];
                    self.hidden = NO;
                    
                    if (i == 0) {
                        [self startTimeWithGuidePageView:guidePageView];
                    }
                    
                }else{
                    [imageView sd_setImageWithURL:[NSURL URLWithString:imageNameArray[i].imageUrl] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                       
                        if (i == 0) {
                            [self startTimeWithGuidePageView:guidePageView];
                        }
                        self.hidden = NO;
                    }];
                }
                
                [guidePageView addSubview:imageView];
                [guidePageView addSubview:guaideImaClick];
            }
        }
        
        // 设置引导页上的页面控制器
        self.imagePageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(DDScreenW*0.0, DDScreenH*0.9, DDScreenW*1.0, DDScreenH*0.1)];
        self.imagePageControl.currentPage = 0;
        self.imagePageControl.numberOfPages = imageNameArray.count;
        self.imagePageControl.pageIndicatorTintColor = [UIColor grayColor];
        self.imagePageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    }
    return self;
}

//60s倒计时时间
- (void)startTimeWithGuidePageView:(UIScrollView *)guidePageView {
    
    
    NSMutableDictionary *myDictionary = [[NSMutableDictionary alloc] init];
    [myDictionary setObject:guidePageView forKey:@"guidePageView"];
    
    self.skipTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(yfChangeSkipTimebtt:) userInfo:myDictionary repeats:YES];
    
}

- (void)yfChangeSkipTimebtt:(NSTimer *)timer {
    _skipTimeGo += 1;
    
    NSInteger timeout = _skipTime - _skipTimeGo;
    [_skipButton setTitle:[NSString stringWithFormat:@"跳过:%ld秒",(long)timeout] forState:UIControlStateNormal];
    
    if (timeout <= 0) {  //倒计时结束,关闭
        
        [_skipTimer invalidate];
        _skipTimer = nil;
  
            //设置界面的按钮显示,根据自己的要求设置
            [_skipButton setTitle:@"" forState:UIControlStateNormal];
            
            _skipButton.userInteractionEnabled = YES;
            [UIApplication sharedApplication].statusBarHidden = NO;
            [UIView animateWithDuration:3 animations:^{
                self.alpha = 0.0;
                
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
            }];
   
    }else{
        
        if ((timeout%3 == 0)  && (_skipTime != timeout) && (timeout != 0)) {
            [_skipButton setTitle:[NSString stringWithFormat:@"跳过:%ld秒",(long)timeout] forState:UIControlStateNormal];
            NSInteger page = _skipTime/timeout -1;
            
            [self.imagePageControl setCurrentPage:page];
            [[[timer userInfo] objectForKey:@"guidePageView"] setContentOffset:CGPointMake(DDScreenW*page, 0) animated:YES];
        }
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollview {
    int page = scrollview.contentOffset.x / scrollview.frame.size.width;
    [self.imagePageControl setCurrentPage:page];
    if (self.imageArray && page == self.imageArray.count-1 && self.slideInto == NO) {
        [self buttonClick:nil];
    }
    if (self.imageArray && page < self.imageArray.count-1 && self.slideInto == YES) {
        self.slideIntoNumber = 1;
    }
    if (self.imageArray && page == self.imageArray.count-1 && self.slideInto == YES) {
        UISwipeGestureRecognizer *swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:nil action:nil];
        if (swipeGestureRecognizer.direction == UISwipeGestureRecognizerDirectionRight){
            self.slideIntoNumber++;
            if (self.slideIntoNumber == 3) {
                [self buttonClick:nil];
            }
        }
    }
}

- (void)buttonClick:(UIButton *)button {
    [UIView animateWithDuration:DDHidden_TIME animations:^{
        self.alpha = 0;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(DDHidden_TIME * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self performSelector:@selector(removeGuidePageHUD) withObject:nil afterDelay:1];
        });
    }];
}

- (void)removeGuidePageHUD {
    [self removeFromSuperview];
}

/**< APP视频新特性页面(新增测试模块内容) */
- (instancetype)dh_initWithFrame:(CGRect)frame videoURL:(NSURL *)videoURL {
    if ([super initWithFrame:frame]) {
        self.playerController = [[MPMoviePlayerController alloc] initWithContentURL:videoURL];
        [self.playerController.view setFrame:frame];
        [self.playerController.view setAlpha:1.0];
        [self.playerController setControlStyle:MPMovieControlStyleNone];
        [self.playerController setRepeatMode:MPMovieRepeatModeOne];
        [self.playerController setShouldAutoplay:YES];
        [self.playerController prepareToPlay];
        [self addSubview:self.playerController.view];
        
        // 视频引导页进入按钮
        UIButton *movieStartButton = [[UIButton alloc] initWithFrame:CGRectMake(20, DDScreenH-30-40, DDScreenW-40, 40)];
        [movieStartButton.layer setBorderWidth:1.0];
        [movieStartButton.layer setCornerRadius:20.0];
        [movieStartButton.layer setBorderColor:[UIColor whiteColor].CGColor];
        [movieStartButton setTitle:@"开始体验" forState:UIControlStateNormal];
        [movieStartButton setAlpha:0.0];
        [self.playerController.view addSubview:movieStartButton];
        [movieStartButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [UIView animateWithDuration:DDHidden_TIME animations:^{
            [movieStartButton setAlpha:1.0];
        }];
    }
    return self;
}

#pragma mark - 引导页图片点击
- (void)yfGuaideImaClick:(UIButton *)sender {
    
    ModelGuaideIma *model = self.imageArray[sender.tag];

    if (model.linkType == 1 && model.link.length > 4) {
        
        [_skipTimer invalidate];
        _skipTimer = nil;
        
    }
}

@end
