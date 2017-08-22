//
//  MustIdentifyViewCell.m
//  YiJieYiDai
//
//  Created by lijunjie on 2017/6/6.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "MustIdentifyViewCell.h"

@implementation MustIdentifyViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        self.contentView.backgroundColor=[UIColor colorWithHexString:@"0xf0eff4"];
        UIImageView *iconView=[[UIImageView alloc]init];
        self.iconView=iconView;
        //imageView.backgroundColor=RandColor;
        [self.contentView addSubview:iconView];
        [iconView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30];
        [iconView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
        [iconView autoSetDimensionsToSize:CGSizeMake(30, 30)];
        
        UILabel *titleLab=[[UILabel alloc]init];
        titleLab.textColor=[UIColor grayColor];
        self.titleLab=titleLab;
        [self.contentView addSubview:titleLab];
        [titleLab autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:iconView withOffset:30];
        [titleLab autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
        [titleLab autoSetDimensionsToSize:CGSizeMake(130, 30)];
        
        UIButton *identifyBtn=[[UIButton alloc]init];
        [identifyBtn addTarget:self action:@selector(toIdentify) forControlEvents:UIControlEventTouchUpInside];
        self.identifyBtn=identifyBtn;
        [self.contentView addSubview:identifyBtn];
        [identifyBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:30];
        [identifyBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:15];
        [identifyBtn autoSetDimensionsToSize:CGSizeMake(90, 22.5)];

        UIView *sepView=[[UIView alloc]init];
        sepView.backgroundColor=[UIColor colorWithHexString:@"0xf0eff4"];
        [self.contentView addSubview:sepView];
        [sepView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30];
        [sepView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:30];
        [sepView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:iconView withOffset:5];
        [sepView autoSetDimension:ALDimensionHeight toSize:1];
        
    }
    return self;
    
}
-(void)toIdentify{
    [self.delegate toIdentyfy:self.indexRow];
}
-(void)updataWithModel:(MustModel *)model{
    self.iconView.image=[UIImage imageNamed:model.imageIcon];
    self.titleLab.text=model.title;
    if ([model.isIdentify integerValue]==1) {
        [self.identifyBtn setBackgroundImage:[UIImage imageNamed:@"haveIdentify"] forState:UIControlStateNormal];
    }else{
        [self.identifyBtn setBackgroundImage:[UIImage imageNamed:@"toIdentify"] forState:UIControlStateNormal];
    }
}

@end
