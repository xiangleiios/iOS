//
//  PracticeCarDetailsCell.m
//  MobileProject
//
//  Created by 向蕾 on 2018/10/19.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "PracticeCarDetailsCell.h"
#import <MessageUI/MessageUI.h>
#import "CGXPickerView.h"
@interface PracticeCarDetailsCell ()<MFMessageComposeViewControllerDelegate>


@end
@implementation PracticeCarDetailsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self loadSubview];
    }
    return self;
}

- (void)loadSubview{
    UIImageView *img = [[UIImageView alloc] init];
    [self.contentView addSubview:img];
    self.tx = img;
//    [img setImage:[UIImage imageNamed:@"head_nor"]];
    img.layer.cornerRadius = KFit_H6S(30);
    img.layer.masksToBounds = YES;
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(KFit_W6S(30));
        make.centerY.mas_equalTo(self.contentView);
        make.width.height.mas_equalTo(KFit_W6S(60));
    }];
    
    self.name = [[UILabel alloc] init];
    [self.contentView addSubview:self.name];
    self.name.text = @"向蕾";
    self.name.font = [UIFont systemFontOfSize:kFit_Font6(15)];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(img.mas_right).mas_offset(KFit_W6S(20));
        make.centerY.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(150), KFit_H6S(40)));
    }];
    
    self.but = [[UIButton alloc] init];
    [self.contentView addSubview:self.but];
    [_but addTarget:self action:@selector(chooseBut:) forControlEvents:UIControlEventTouchUpInside];
    [self.but setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
    [self.but mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).mas_offset(-KFit_W6S(30));
        make.centerY.mas_equalTo(self.contentView);
        make.width.height.mas_equalTo(KFit_W6S(56));
    }];
    
    UILabel *linetwo = [[UILabel alloc] init];
    [self.contentView addSubview:linetwo];
    linetwo.backgroundColor = kColor_N(240, 240, 240);
    [linetwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self);
        make.height.mas_equalTo(KFit_H6S(1));
    }];
    
}

- (void)setDic:(NSDictionary *)dic{
    _dic = dic;
    self.name.text = dic[@"studentName"];
    [self.tx sd_setImageWithURL:[NSURL URLWithString:dic[@"wxHead"]] placeholderImage:[UIImage imageNamed:@"head_nor"]];
    
//    wxHead
}
- (void)chooseBut:(UIButton *)senter{
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"请选择" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //默认只有标题 没有操作的按钮:添加操作的按钮 UIAlertAction
    
    UIAlertAction *cancelBtn = [UIAlertAction actionWithTitle:@"打电话" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        //        NSLog(@"取消");
        if (_dic[@"studentPhone"]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt:%@",_dic[@"studentPhone"]]]];
        }
        
    }];
    
    UIAlertAction *cancelBtXJ = [UIAlertAction actionWithTitle:@"发短信" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"取消");
        if( [MFMessageComposeViewController canSendText]) {
            MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc] init];
            controller.recipients = @[_dic[@"studentPhone"]];//发送短信的号码，数组形式入参
            controller.navigationBar.tintColor = [UIColor redColor];
            controller.body = [NSString stringWithFormat:@"学员您好，您已成功预约练车，训练场:%@（%@）,时间:%@,地址:%@,请准时练车",_dic[@"trainingName"],_dic[@"schoolName"],_dic[@"trainingTime"],_model.trainingAddress]; //此处的body就是短信将要发生的内容
            controller.messageComposeDelegate = self;
            [self.vc presentViewController:controller animated:YES completion:nil];
            [[[[controller viewControllers] lastObject] navigationItem] setTitle:@"短信"];//修改短信界面标题
            
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"该设备不支持短信功能" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            
        }
            
    }];
    UIAlertAction *cancelBtQX = [UIAlertAction actionWithTitle:@"取消预约" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self cancel];
        NSLog(@"取消");
        
    }];
    //添加确定
    UIAlertAction *sureBtn = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"取消");
        
    }];
    //设置`确定`按钮的颜色
    //    [sureBtn setValue:[UIColor redColor] forKey:@"titleTextColor"];
    //将action添加到控制器
    [alertVc addAction:cancelBtn];
    [alertVc addAction:cancelBtXJ];
    [alertVc addAction:cancelBtQX];
    [alertVc addAction :sureBtn];
    //展示
    [self.vc presentViewController:alertVc animated:YES completion:nil];
}




- (void)cancel{
    [CGXPickerView showStringPickerWithTitle:@"取消预约" DataSource:@[@"临时有事",@"今日休息",@"预约错误",@"其他原因",] DefaultSelValue:nil IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow) {
        NSLog(@"%@",selectValue);
        int i = [selectRow intValue];
        if (i == 3) {
            XLAlertView *alert = [[XLAlertView alloc] initWithInputboxTitle:@"请输入原因(不能超过70个字符)"];
            [alert showXLAlertView];
            alert.inputText = ^(NSString *text) {
                if (text.length < 1) {
                    [MBProgressHUD showMsgHUD:@"请输入原因"];
                    return ;
                }
                if (text.length > 70) {
                    [MBProgressHUD showMsgHUD:@"输入不得超过70个字符"];
                    return ;
                }
                NSDictionary *dic = @{@"memo":text,@"id":_dic[@"id"]};
                [self cancelByDic:dic];
            };
        }else{
            NSDictionary *dic = @{@"memo":selectValue,@"id":_dic[@"id"]};
            [self cancelByDic:dic];
        }
    }];
}


- (void)cancelByDic:(NSDictionary *)dic{
    NSString *url = POSTCancelById;
    [FMNetworkHelper fm_request_postWithUrlString:url isNeedCache:NO parameters:dic successBlock:^(id responseObject) {
        KKLog(@"%@",responseObject);
        if (kResponseObjectStatusCodeIsEqual(200)) {
            [MBProgressHUD showMsgHUD:@"取消预约成功"];
            [self.vc.vc loadDataWithTime:self.vc.vc.selectTime];
//            [self headerRefresh];
        }
    } failureBlock:^(NSError *error) {
        KKLog(@"%@", error);
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}










-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    [self.vc dismissViewControllerAnimated:YES completion:nil];
    switch (result) {
        case MessageComposeResultSent:
            //信息传送成功
            break;
        case MessageComposeResultFailed:
            //信息传送失败
            break;
        case MessageComposeResultCancelled:
            //信息被用户取消传送
        break;
        default:
        break;
            
    }
    
}

@end
