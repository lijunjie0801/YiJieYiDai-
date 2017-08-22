//
//  CustomeViewCell.m
//  YiJieYiDai
//
//  Created by lijunjie on 2017/6/3.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "CustomeViewCell.h"

@implementation CustomeViewCell

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
    self.imageview=[[UIImageView alloc]init];
   
    self.imageview.frame=CGRectMake(30, 20,kScreen_Width/4-60,kScreen_Width/4-60);
   // self.imageview.backgroundColor=[UIColor greenColor];
    [self addSubview:self.imageview];
    
    self.label=[[UILabel alloc]init];
    self.label.textColor=[UIColor grayColor];
    self.label.frame=CGRectMake(10, kScreen_Width/4-30,kScreen_Width/4-20,20);
    self.label.textAlignment=NSTextAlignmentCenter;
    [self addSubview:self.label];
}


@end
