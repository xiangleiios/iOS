//
//  UIImage+Adaptation.h
//  MemoryCard
//
//  Created by 王文辉 on 12-9-22.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (Adaptation)

+ (UIImage *) imageNamedByAdaptation:(NSString *)name;

/**
 *  确保图片能够以正方向显示
 *
 *  @param image 源图片
 *
 *  @return 修正的图片
 */
+ (UIImage *) fixRotation:(UIImage *)image;
+ (UIImage*)imageWithImage:(UIImage*)image
              scaledToSize:(CGSize)newSize;


+ (UIImage *)createImageWithColor:(UIColor *)color;

+ (UIImage *)imageWithColor:(UIColor *)color;
@end
