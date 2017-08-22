//
//  MustIdentifyViewCell.h
//  YiJieYiDai
//
//  Created by lijunjie on 2017/6/6.
//  Copyright © 2017年 dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MustModel.h"
@protocol MustDelegate<NSObject>
-(void)toIdentyfy:(NSString *)indexrow;
@end
@interface MustIdentifyViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIImageView *iconView;
@property(nonatomic,strong)UIButton *identifyBtn;
@property(nonatomic, strong) NSString *indexRow;
@property(nonatomic, weak)id<MustDelegate>delegate;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
-(void)updataWithModel:(MustModel *)model;
@end
