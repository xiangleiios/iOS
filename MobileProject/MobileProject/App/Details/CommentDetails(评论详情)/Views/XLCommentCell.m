//
//  XLCommentCell.m
//  NNTT
//
//  Created by zsgy on 16/8/9.
//  Copyright © 2016年 王文辉. All rights reserved.
//

#import "XLCommentCell.h"

@implementation XLCommentCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        self.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.imgview=[[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 40, 40)];
        [self addSubview:self.imgview];
        self.imgview.layer.cornerRadius=20;
        self.imgview.layer.masksToBounds=YES;
        
        self.nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(60, 10, 180, 30)];
        [self addSubview:self.nameLabel];
        self.nameLabel.font=[UIFont systemFontOfSize:18];
        self.nameLabel.textColor=[UIColor colorWithRed:80/255.0 green:138/255.0 blue:206/255.0 alpha:1];
        
        self.timeLabel=[[UILabel alloc]initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width-140, 20, 120, 20)];
        self.timeLabel.textColor=[UIColor lightGrayColor];
        [self addSubview:self.timeLabel];
        self.timeLabel.textAlignment=NSTextAlignmentRight;
        self.timeLabel.font=[UIFont systemFontOfSize:16];
        self.timeLabel.textAlignment=NSTextAlignmentRight;
        
        
        self.contentLabel=[[UILabel alloc]initWithFrame:CGRectMake(60, 50, [[UIScreen mainScreen] bounds].size.width-70, 40)];
        self.contentLabel.textColor=[UIColor lightGrayColor];
        [self addSubview:self.contentLabel];
        self.contentLabel.numberOfLines=0;
        
        self.blab=[[UILabel alloc]initWithFrame:CGRectMake(0, 89, [[UIScreen mainScreen] bounds].size.width, 1)];
        self.blab.backgroundColor=[UIColor colorWithWhite:240/255.0 alpha:1];
        [self addSubview:self.blab];
        
    }
    return self;

}

@end
