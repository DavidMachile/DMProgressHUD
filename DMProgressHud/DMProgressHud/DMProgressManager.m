//
//  DMProgressManager.m
//  DMApp
//
//  Created by DM_dsz on 2019/10/10.
//  Copyright © 2019 www.DM360.com. All rights reserved.
//

#import "DMProgressManager.h"
@interface DMProgressManager()<DMProgressHUDDelegate>
/**
 *自定义的图片名称
 */
@property (nonatomic, strong) NSString *DM_imageStr;

//全都可以使用的参数
@property (nonatomic, strong) UIView *DM_inView;/**<hud加在那个view上*/
@property (nonatomic, assign) BOOL DM_animated;/**<是否动画显示、消失*/
//只有showHandleMessage可以使用的属性
@property (nonatomic, strong) NSString *DM_message;/**<hud上面的文字*/
@property (nonatomic, assign) NSTimeInterval DM_afterDelay;/**<自动消失时间*/
@property (nonatomic, strong) UIColor *DM_HUDColor;/**自定义弹框颜色*/
@property (nonatomic, strong) UIColor *DM_ContentColor;/**自定义内容颜色*/
@property (nonatomic, assign) DMProgressHUDMode DM_hudMode;/**弹窗模式*/

/**
 *设置全局的HUD
 */
@property (nonatomic, assign) DMProgressHUDStateType DM_hudState;
@property (nonatomic, assign) DMProgressHUDPosition DM_position;

@end

@implementation DMProgressManager
/**
 *显示成功并自动消失
 */
+ (void)DM_showHUDWithSuccess:(NSString *)showString{
    [DMProgressManager DM_showHUDWithState:^(DMProgressManager * _Nonnull make) {
        make.hudState(DMProgressHUDStateTypeSuccess).message(showString);
    }];
}
/**
 *显示错误并自动消失
 */
+ (void)DM_showHUDWithError:(NSString *)showString{
    [DMProgressManager DM_showHUDWithState:^(DMProgressManager * _Nonnull make) {
        make.hudState(DMProgressHUDStateTypeError).message(showString);
    }];
}
/**
 *显示警告并自动消失
 */
+ (void)DM_showHUDWithWarning:(NSString *)showString{
    [DMProgressManager DM_showHUDWithState:^(DMProgressManager * _Nonnull make) {
        make.hudState(DMProgressHUDStateTypeWarning).message(showString);
    }];
}

/**
 *显示纯文字并自动消失
 */
+ (void)DM_showHUDWithText:(NSString *)showString{
    [DMProgressManager DM_showHUDWithState:^(DMProgressManager * _Nonnull make) {
        make.message(showString);
    }];
}


/**
 *直接消失
 */
+ (void)dissmissHUDDirect{
    [DMProgressManager dissmissHUD:nil];
}



/**
 *一张图时的图片名字
 */
- (DMProgressManager *(^)(NSString *))imageStr {
    return ^DMProgressManager *(NSString *imageString) {
        _DM_imageStr = imageString;
        return self;
    };
}
+ (void)dissmissHUD:(void (^)(DMProgressManager *make))block {
    DMProgressManager *makeObj = [[DMProgressManager alloc] init];
    if (block) {
        block(makeObj);
    }
    __block DMProgressHUD *hud = [DMProgressHUD HUDForView:makeObj.DM_inView];
    [hud hideAnimated:makeObj.DM_animated];
}


+ (DMProgressHUD *)configHUDWithMakeObj:(DMProgressManager *)makeObj {
    DMProgressHUD *hud = [DMProgressHUD showHUDAddedTo:makeObj.DM_inView animated:makeObj.DM_animated];
    hud.detailsLabel.text=makeObj.DM_message;
    hud.detailsLabel.font = [UIFont systemFontOfSize:16.0];
    hud.bezelView.color = makeObj.DM_HUDColor;
    hud.contentColor = makeObj.DM_ContentColor;
    hud.animationType = DMProgressHUDAnimationZoomOut;
    hud.bezelView.layer.cornerRadius = 12.0f;
    hud.mode = makeObj.DM_hudMode;
    hud.removeFromSuperViewOnHide = YES;
    return hud;
}


#pragma mark - 显示状态自定义（自动消失）
+ (void)DM_showHUDWithState:(void (^)(DMProgressManager *make))block {
    DMProgressManager *makeObj = [[DMProgressManager alloc] init];
    if (block) {
        block(makeObj);
    }
    __block DMProgressHUD *hud = [DMProgressHUD HUDForView:makeObj.DM_inView];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (!hud) {
            hud = [DMProgressManager configHUDWithMakeObj:makeObj];
        }
        hud.mode = DMProgressHUDModeCustomView;
        hud.detailsLabel.text=makeObj.DM_message;
        NSString *imageStr = @"";
        if (makeObj.DM_hudState == DMProgressHUDStateTypeSuccess) {
            imageStr = @"icon_right";
        }else if (makeObj.DM_hudState == DMProgressHUDStateTypeError) {
            imageStr = @"icon_error";
        }else if (makeObj.DM_hudState == DMProgressHUDStateTypeWarning) {
            imageStr = @"icon_warning";
        }else {
            hud.mode = DMProgressHUDModeText;
            hud.minSize=CGSizeMake(37,40);
        }
        if (makeObj.DM_position == DMProgressHUDPositionTop) {
            [hud setOffset:CGPointMake(0, [UIApplication sharedApplication].keyWindow.bounds.size.height*1.0/3.0)];
        }else if(makeObj.DM_position == DMProgressHUDPositionBottom){
            [hud setOffset:CGPointMake(0, -[UIApplication sharedApplication].keyWindow.bounds.size.height*1.0/3.0)];
        }else{
            
        }
        hud.customView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:imageStr] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        [hud hideAnimated:makeObj.DM_animated afterDelay:makeObj.DM_afterDelay];
    });
    
}

- (instancetype)init {
    
    self=[super init];
    if (self) {//这里可以设置一些默认的属性
        _DM_inView=[UIApplication sharedApplication].keyWindow;
        _DM_afterDelay   = 1.5;
        _DM_HUDColor     = [UIColor blackColor];
        _DM_ContentColor = [UIColor whiteColor];
        _DM_hudMode      = DMProgressHUDModeIndeterminate;
    }
    return self;
}

- (DMProgressManager *(^)(UIView *))inView{
    return ^DMProgressManager *(id obj) {
        _DM_inView=obj;
        return self;
    };
}

- (DMProgressManager *(^)(BOOL))animated {
    return ^DMProgressManager *(BOOL animated) {
        _DM_animated=animated;
        return self;
    };
}

- (DMProgressManager *(^)(NSTimeInterval))afterDelay{
    return ^DMProgressManager *(NSTimeInterval afterDelay) {
        _DM_afterDelay=afterDelay;
        return self;
    };
}

/**
 .showMessage(@"需要显示的文字")
 */
- (DMProgressManager *(^)(NSString *))message {
    
    return ^DMProgressManager *(NSString *msg) {
        _DM_message=msg;
        return self;
    };
}

- (DMProgressManager *(^)(UIColor *))hudColor {
    return ^DMProgressManager *(UIColor *hudColor) {
        _DM_HUDColor = hudColor;
        return self;
    };
}

- (DMProgressManager *(^)(DMProgressHUDMode))hudMode {
    return ^DMProgressManager *(DMProgressHUDMode hudMode) {
        _DM_hudMode = hudMode;
        return self;
    };
}

- (DMProgressManager *(^)(DMProgressHUDStateType))hudState{
    return ^DMProgressManager *(DMProgressHUDStateType hudState) {
        _DM_hudState = hudState;
        return self;
    };
}

- (DMProgressManager *(^)(UIColor *))contentColor {
    return ^DMProgressManager *(UIColor *contentColor) {
        _DM_ContentColor = contentColor;
        return self;
    };
}

- (DMProgressManager * _Nonnull (^)(DMProgressHUDPosition))position{
    return ^DMProgressManager *(DMProgressHUDPosition position){
        _DM_position = position;
        return self;
    };
}
@end
