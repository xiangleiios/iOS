//
//  QFPlayerControlView.h
//
//  QFPlayer
//


#import <UIKit/UIKit.h>

typedef void(^ChangeResolutionBlock)(UIButton *button);
typedef void(^SliderTapBlock)(CGFloat value);

@interface QFPlayerControlView : UIView

/** 开始播放按钮 */
@property (nonatomic, strong, readonly) UIButton                *startBtn;
/** 当前播放时长label */
@property (nonatomic, strong, readonly) UILabel                 *currentTimeLabel;
/** 视频总时长label */
@property (nonatomic, strong, readonly) UILabel                 *totalTimeLabel;
/** 缓冲进度条 */
@property (nonatomic, strong, readonly) UIProgressView          *progressView;
/** 滑杆 */
@property (nonatomic, strong, readonly) UISlider                *videoSlider;
/** 全屏按钮 */
@property (nonatomic, strong, readonly) UIButton                *fullScreenBtn;
/** 锁定屏幕方向按钮 */
@property (nonatomic, strong, readonly) UIButton                *lockBtn;
/** 快进快退label */
@property (nonatomic, strong, readonly) UILabel                 *horizontalLabel;
/** 系统菊花 */
@property (nonatomic, strong, readonly) UIActivityIndicatorView *activity;
/** 返回按钮*/
@property (nonatomic, strong, readonly) UIButton                *backBtn;
/** 抬头*/
@property(nonatomic,strong,readwrite) UILabel                    * titleLabel;
/** 重播按钮 */
@property (nonatomic, strong, readonly) UIButton                *repeatBtn;
/** bottomView*/
@property (nonatomic, strong, readonly) UIImageView             *bottomImageView;
/** topView */
@property (nonatomic, strong, readonly) UIImageView             *topImageView;
/** 缓存按钮 */
@property (nonatomic, strong, readonly) UIButton                *downLoadBtn;
/** 切换分辨率按钮 */
@property (nonatomic, strong, readonly) UIButton                *resolutionBtn;
/** 分辨率的名称 */
@property (nonatomic, strong) NSArray                           *resolutionArray;
/** 切换分辨率的block */
@property (nonatomic, copy  ) ChangeResolutionBlock             resolutionBlock;
/** slidertap事件Block */
@property (nonatomic, copy  ) SliderTapBlock                    tapBlock;

/** 重置ControlView */
- (void)resetControlView;
/** 切换分辨率时候调用此方法*/
- (void)resetControlViewForResolution;
/** 显示top、bottom、lockBtn*/
- (void)showControlView;
/** 隐藏top、bottom、lockBtn*/
- (void)hideControlView;

@end
