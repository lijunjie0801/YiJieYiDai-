//
//  HomeTableViewCell.h
//  YiJieYiDai
//
//  Created by lijunjie on 2017/6/2.
//  Copyright © 2017年 dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"
@interface HomeTableViewCell : UIView
@property(nonatomic,strong)UIImageView *backimageView;
@property(nonatomic,strong)UIImageView *rightView;
@property(nonatomic,strong)UILabel *priceLab;
//-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
//-(void)updataWithModel:(HomeModel *)model;
@end
