//
//  WebViewJS.h
//  TianLiSenProject
//
//  Created by fyaex001 on 2017/3/1.
//  Copyright © 2017年 fyaex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>


@protocol WebViewJSObjectProtocol <JSExport>


-(void)tobibeirenz;

-(void)liuyan;

-(void)loanapply;

-(void)userCenter;

-(void)kefu;

-(void)index;
@end



@protocol WebViewJSDelegate <NSObject>



-(void)tobibeirenzJS;

-(void)liuyanJS;

-(void)fenxiangJS:(NSString *)url;

-(void)loanapplyJS;

-(void)userCenterJS;
-(void)kefuJS;
-(void)indexJS;
@end


    

@interface WebViewJS : NSObject<WebViewJSObjectProtocol>

@property(nonatomic, weak) id<WebViewJSDelegate> delegate;


@end
