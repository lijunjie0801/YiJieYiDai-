//
//  IdentifyShenFenZhengViewController.h
//  YiJieYiDai
//
//  Created by lijunjie on 2017/6/6.
//  Copyright © 2017年 dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SFZDelegate <NSObject>
-(void)ThirdRefresh;
@end
@interface IdentifyShenFenZhengViewController : UIViewController
@property(nonatomic,strong)NSString *backType;
@property(nonatomic, weak) id<SFZDelegate> delegate;
@end
