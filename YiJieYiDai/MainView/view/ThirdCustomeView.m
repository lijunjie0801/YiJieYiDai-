//
//  ThirdCustomeView.m
//  YiJieYiDai
//
//  Created by lijunjie on 2017/6/3.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "ThirdCustomeView.h"

@implementation ThirdCustomeView

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
    
    self.imageview.frame=CGRectMake(40, 20,kScreen_Width/3-80,kScreen_Width/3-80);
    //self.imageview.backgroundColor=[UIColor greenColor];
    [self addSubview:self.imageview];
    
    self.label=[[UILabel alloc]init];
    self.label.textColor=[UIColor grayColor];
    self.label.frame=CGRectMake(0, kScreen_Width/3-40,kScreen_Width/3,20);
    self.label.textAlignment=NSTextAlignmentCenter;
    [self addSubview:self.label];
    
    self.rightTopView=[[UIImageView alloc]init];
    
    self.rightTopView.frame=CGRectMake(kScreen_Width/3-30, 10,20,20);
    [self addSubview:self.rightTopView];

}



@end
