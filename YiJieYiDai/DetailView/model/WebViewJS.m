//
//  WebViewJS.m
//  TianLiSenProject
//
//  Created by fyaex001 on 2017/3/1.
//  Copyright © 2017年 fyaex. All rights reserved.
//

#import "WebViewJS.h"

@implementation WebViewJS

-(void)tobibeirenz{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.delegate respondsToSelector:@selector(tobibeirenzJS)]) {
            [self.delegate tobibeirenzJS];
        }
    });
}
-(void)kefu{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.delegate respondsToSelector:@selector(kefuJS)]) {
            [self.delegate kefuJS];
        }
    });
}
-(void)liuyan{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.delegate respondsToSelector:@selector(liuyanJS)]) {
            [self.delegate liuyanJS];
        }
    });

}
-(void)loanapply{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.delegate respondsToSelector:@selector(loanapplyJS)]) {
            [self.delegate loanapplyJS];
        }
    });

}
-(void)userCenter{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.delegate respondsToSelector:@selector(userCenterJS)]) {
            [self.delegate userCenterJS];
        }
    });
 
}
-(void)index{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.delegate respondsToSelector:@selector(indexJS)]) {
            [self.delegate indexJS];
        }
    });

}
@end

