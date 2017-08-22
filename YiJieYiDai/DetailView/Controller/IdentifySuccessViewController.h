//
//  IdentifySuccessViewController.h
//  YiJieYiDai
//
//  Created by lijunjie on 2017/6/6.
//  Copyright © 2017年 dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol successDelegate <NSObject>
-(void)backMe;
@end
@interface IdentifySuccessViewController : UIViewController
@property(nonatomic,weak)id<successDelegate>delegate;
@property(nonatomic,strong)NSString *type;
@end
