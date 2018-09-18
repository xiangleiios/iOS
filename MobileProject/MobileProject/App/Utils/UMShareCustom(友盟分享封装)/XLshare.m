//
//  XLshare.m
//  MobileProject
//
//  Created by zsgy on 17/3/2.
//  Copyright © 2017年 Mingoy. All rights reserved.
//

#import "XLshare.h"


@interface XLshare ()

@end

@implementation XLshare
{
    MBProgressHUD * hub;
}


- (void)umengShare:(UIView*)view{
    [UMSocialShareUIConfig shareInstance].sharePageGroupViewConfig.sharePageGroupViewPostionType = UMSocialSharePageGroupViewPositionType_Middle;
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine)]];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        [self shareWebPageToPlatformType:platformType];
    }];

}

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
//    if ([self.image_url isEqual:@""]) {
//        self.image_url=@"http://tdb.asia-cloud.com/uploads/images/2018/0702/20180702105337108.png";
//    }
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建网页内容对象
    UIImageView * img = [[UIImageView alloc] init];
    [img setImage:[UIImage imageNamed:@"shareimg"]];
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:self.title descr:self.subTitle thumImage:UIImageJPEGRepresentation(img.image, 0.1)];
    //设置网页地址
    shareObject.webpageUrl = self.url;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:nil completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
    
    
//    一下是分享网络图片
    
    
//    [img sd_setImageWithURL:[NSURL URLWithString:self.image_url] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//
//        if (error == nil && image) {
//            NSLog(@"这是分享图片的大小------>%lu  这是链接-----%@",[UIImageJPEGRepresentation(image, 0.1) length]/1024, self.image_url
//                  );
//            UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:self.title descr:self.subTitle thumImage:UIImageJPEGRepresentation(img.image, 0.1)];
//            //设置网页地址
//            shareObject.webpageUrl = self.url;
//
//            //分享消息对象设置分享内容对象
//            messageObject.shareObject = shareObject;
//
//            //调用分享接口
//            [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:nil completion:^(id data, NSError *error) {
//                if (error) {
//                    NSLog(@"************Share fail with error %@*********",error);
//                }else{
//                    NSLog(@"response data is %@",data);
//                }
//            }];
//        }else{
//            NSLog(@"************Share fail with error %@*********",error);
//            [MBProgressHUD showAutoMessage:@"分享失败"];
//        }
//    }];

}


/// 分享微信小程序
- (void)shareMiniProgramToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    UMShareMiniProgramObject *shareObject = [UMShareMiniProgramObject shareObjectWithTitle:self.title descr:self.subTitle thumImage:[UIImage imageNamed:@"shareimg"]];
//    shareObject.webpageUrl = @"兼容微信低版本网页地址";
    shareObject.webpageUrl = self.url;
//    shareObject.userName = @"小程序username，如 gh_3ac2059ac66f";
    shareObject.userName = @"gh_b63eb5f5c4e3";
//    shareObject.path = @"pages/index/index";
    shareObject.path = self.xcxurl;
    messageObject.shareObject = shareObject;
    UIImage *img = [UIImage imageNamed:@"weixin_photo"];
    shareObject.hdImageData = UIImagePNGRepresentation(img);
//    shareObject.hdImageData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"shareimg" ofType:@"png"]];
    shareObject.miniProgramType = UShareWXMiniProgramTypeRelease; // 可选体验版和开发板
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:nil completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        KKLog(@" error :   %@",error);
//        [self alertWithError:error];
    }];
    
//    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:nil completion:^(id data, NSError *error) {
//        if (error) {
//            NSLog(@"************Share fail with error %@*********",error);
//        }else{
//            NSLog(@"response data is %@",data);
//        }
//    }];
}
@end
