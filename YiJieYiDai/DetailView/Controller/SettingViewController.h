//
//  SettingViewController.h
//  YiJieYiDai
//
//  Created by lijunjie on 2017/6/5.
//  Copyright © 2017年 dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SettingDelegate <NSObject>
-(void)refresh;
@end
@interface SettingViewController : UIViewController
@property(nonatomic, weak) id<SettingDelegate> delegate;
@property(nonatomic,strong)NSString *iconString;
@end
