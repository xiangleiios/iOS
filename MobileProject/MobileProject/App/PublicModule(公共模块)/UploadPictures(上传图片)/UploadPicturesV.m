//
//  UploadPicturesV.m
//  MobileProject
//
//  Created by 向蕾 on 2018/10/31.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "UploadPicturesV.h"
#import "TZImagePickerController.h"
#define BUT_W KFit_W6S(150)

@interface UploadPicturesV ()<UIImagePickerControllerDelegate>

@end
@implementation UploadPicturesV

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
 */


- (NSMutableArray *)dataArr{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (NSMutableArray *)butArr{
    if (_butArr == nil) {
        _butArr = [NSMutableArray array];
    }
    return _butArr;
}
- (NSMutableArray *)imageviewArr{
    if (_imageviewArr == nil) {
        _imageviewArr = [NSMutableArray array];
    }
    return _imageviewArr;
}


- (instancetype)init{
    self = [super init];
    if (self) {
        [self laodsubview];
    }
    return self;
}

- (void)laodsubview{
    self.backgroundColor = [UIColor whiteColor];
    self.addBut = [[UIButton alloc]initWithFrame:CGRectMake(KFit_W6S(30), KFit_W6S(30), BUT_W, BUT_W)];
    [self addSubview:self.addBut];
    [self.addBut setImage:[UIImage imageNamed:@"add_photo"] forState:UIControlStateNormal];
    [self.addBut addTarget:self action:@selector(changeUp) forControlEvents:UIControlEventTouchUpInside];
    
    
}


#pragma mark - 要上传的图片显示；
- (void)loadimgview{
    if (self.imageviewArr.count > 0) {
        for (UIImageView *imgv in self.imageviewArr) {
            [imgv removeFromSuperview];
        }
    }
    KKLog(@"%lu",(unsigned long)self.butArr.count);
    if (self.butArr.count > 0) {
        for (UIButton *but in self.butArr) {
            [but removeFromSuperview];
        }
    }
    int j=0;
    for (int i=0; i<self.dataArr.count; i++) {
        UIImageView *imgv= [[UIImageView alloc] init];
        [imgv sd_setImageWithURL:[NSURL URLWithString:KURLIma(self.dataArr[i])]];
        imgv.frame=CGRectMake(i%3*(KFit_W6S(20)+BUT_W)+ KFit_W6S(30),i/3*(KFit_W6S(20)+BUT_W)+ KFit_W6S(30), BUT_W, BUT_W);;
        [self addSubview:imgv];
        /*删除按钮 */
        UIButton *but=[[UIButton alloc]init];
        [self addSubview:but];
        [but mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(imgv).mas_offset(-KFit_H6S(35));
            make.left.mas_equalTo(imgv.mas_right).mas_offset(-KFit_H6S(35));
            make.width.height.mas_equalTo(KFit_H6S(80));
        }];
        [but setImage:[UIImage imageNamed:@"delete_red_icon"] forState:UIControlStateNormal];
        but.tag=i;
        [but addTarget:self action:@selector(deleteimgdata:) forControlEvents:UIControlEventTouchUpInside];
        [self.imageviewArr addObject:imgv];
        [self.butArr addObject:but];
        j++;
    }
    
    if (j >= self.num) {
        self.addBut.hidden = YES;
    }else{
        self.addBut.hidden = NO;
        self.addBut.frame=CGRectMake(j%3*(KFit_W6S(20)+BUT_W) + KFit_W6S(30),j/3*(KFit_W6S(20)+BUT_W)+ KFit_W6S(30), BUT_W, BUT_W);
    }
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo([self getLayoutCellHeightWithFlex:KFit_H6S(30)]);
    }];
    
    
}
#pragma mark -删除图片和数据
- (void)deleteimgdata:(UIButton *)sender{
    [self.dataArr removeObjectAtIndex:sender.tag];
    [self loadimgview];
}

- (void)relodData{
    [self loadimgview];
}

- (void)changeUp{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"请选择添加途径" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //默认只有标题 没有操作的按钮:添加操作的按钮 UIAlertAction
    
    UIAlertAction *cancelBtn = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self PhotoLibrary];
    }];
    
    UIAlertAction *cancelBtXJ = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self xiangji];
        NSLog(@"取消");
        
    }];
    //添加确定
    UIAlertAction *sureBtn = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"确定");
        
    }];
    //设置`确定`按钮的颜色
    //    [sureBtn setValue:[UIColor redColor] forKey:@"titleTextColor"];
    //将action添加到控制器
    [alertVc addAction:cancelBtn];
    [alertVc addAction:cancelBtXJ];
    [alertVc addAction :sureBtn];
    //展示
    [self.vc presentViewController:alertVc animated:YES completion:nil];
}



- (void)xiangji{
    UIImagePickerController * imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.mediaTypes = [NSArray arrayWithObject:(__bridge NSString *)kUTTypeImage];
    imagePickerController.delegate = self;
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIAlertView * alerr = [[UIAlertView alloc]initWithTitle:@"警告!" message:@"未找到该硬件设备或设备已损坏" delegate:self cancelButtonTitle:nil otherButtonTitles:@"我知道了", nil];
        [alerr show];
    }else{
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        if (self.type == 1) {
            imagePickerController.allowsEditing = YES;
        }
    }
    //利用模态进行调用系统框架
    [self.vc.navigationController presentViewController:imagePickerController animated:YES completion:nil];
    
}
//照片库
- (void)PhotoLibrary{
//    UIImagePickerController * imagePickerController = [[UIImagePickerController alloc]init];
//    imagePickerController.mediaTypes = [NSArray arrayWithObject:(__bridge NSString *)kUTTypeImage];
//    imagePickerController.delegate = self;
//    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    [self.vc.navigationController presentViewController:imagePickerController animated:YES completion:nil];;
    int i = self.num - self.dataArr.count;
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:i delegate:self];
    imagePickerVc.allowPickingVideo =  NO;
    if (self.type == 1) {
        imagePickerVc.allowCrop = YES;
    }
    
    imagePickerVc.cropRect = CGRectMake(0, (SCREEN_HEIGHT - SCREEN_WIDTH)/2.0, SCREEN_WIDTH, SCREEN_WIDTH);
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        for (UIImage *img in photos) {
            [self uploadPictures:img];
        }
    }];
    
    [self.vc presentViewController:imagePickerVc animated:YES completion:nil];
    
}

#pragma mark -相册代理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    KKLog(@"%@    ----- %@",picker,info);
    [self uploadPictures:info[UIImagePickerControllerEditedImage]];
    [picker dismissViewControllerAnimated:YES completion:NULL];
}


- (void)uploadPictures:(UIImage *)image{
    [MBProgressHUD showLoadingHUD:@"正在上传图片"];
    NSString *url = POSTUpLoadFile;
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:[User UserOb].token forHTTPHeaderField:@"token"];
    [manager.requestSerializer setValue:@"Mobile" forHTTPHeaderField:@"loginType"];
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 0.1) name:@"file" fileName:@"tupian.png" mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"成功返货=============%@",responseObject);
        [MBProgressHUD hideLoadingHUD];
        if (kResponseObjectStatusCodeIsEqual(200)) {
            NSDictionary *dic =responseObject[@"data"][@"data"];
            [self.dataArr addObject:dic[@"url"]];
            [self loadimgview];
        }else{
            [MBProgressHUD showAutoMessage:responseObject[@"message"]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideLoadingHUD];
    }];
}

@end
