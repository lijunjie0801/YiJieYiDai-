//
//  HomeTableViewCell.m
//  YiJieYiDai
//
//  Created by lijunjie on 2017/6/2.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "HomeTableViewCell.h"

@implementation HomeTableViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        [self initTextView:frame];
    }
    return self;
}
-(void)initTextView:(CGRect)frame
{
    CGFloat width=kScreen_Width-20;
    CGFloat heigh=(kScreen_Width-10)/2.7;
    self.backimageView=[[UIImageView alloc]init];
    self.backimageView.frame=CGRectMake(10, 0,width,heigh);
    [self addSubview:self.backimageView];
    
    self.priceLab=[[UILabel alloc]init];
    self.priceLab.textColor=[UIColor grayColor];
    self.priceLab.frame=CGRectMake(width/7, heigh*0.5,width*3/7,heigh/3);
    self.priceLab.font=[UIFont systemFontOfSize:20];
    self.priceLab.textColor=[UIColor redColor];
    self.priceLab.textAlignment=NSTextAlignmentLeft;
    [self addSubview:self.priceLab];
    
    self.rightView=[[UIImageView alloc]init];
    self.rightView.frame=CGRectMake(width-width*9/70+10, 0,width*9/70,width*9/70);
    [self addSubview:self.rightView];
}

@end
