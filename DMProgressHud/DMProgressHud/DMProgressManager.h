//
//  DMProgressManager.h
//  DMApp
//
//  Created by DM_dsz on 2019/10/10.
//  Copyright © 2019 www.DM360.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DMProgressHUD.h"
NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSInteger,DMProgressHUDStateType){
    DMProgressHUDStateTypeSuccess = 1, //成功
    DMProgressHUDStateTypeError,       //错误
    DMProgressHUDStateTypeWarning      //警告
};

typedef NS_ENUM(NSInteger,DMProgressHUDPosition) {
    DMProgressHUDPositionTop =1,
    DMProgressHUDPositionCenter,
    DMProgressHUDPositionBottom
};

@interface DMProgressManager : NSObject


/**
 *设置显示模式
 */
- (DMProgressManager *(^)(DMProgressHUDMode))hudMode;


/**
 *显示状态(失败，成功，警告)
 */
- (DMProgressManager *(^)(DMProgressHUDStateType))hudState;

//- (DMProgressManager *(^)(DMProgressHUDPosition))position;

/**
 *显示成功并自动消失
 */
+ (void)DM_showHUDWithSuccess:(NSString *)showString;

/**
 *显示错误并自动消失
 */
+ (void)DM_showHUDWithError:(NSString *)showString;

/**
 *显示警告并自动消失
 */
+ (void)DM_showHUDWithWarning:(NSString *)showString;

/**
 *显示纯文字并自动消失
 */
+ (void)DM_showHUDWithText:(NSString *)showString;


/**
 *显示状态自定义（自动消失）
 */
+ (void)DM_showHUDWithState:(void (^)(DMProgressManager *make))block;

/**
 *直接消失
 */
+ (void)dissmissHUDDirect;

/**
 .showMessage(@"需要显示的文字")
 */
- (DMProgressManager *(^)(NSString *))message;


/**
 *一张图时的图片名字
 */
- (DMProgressManager *(^)(NSString *))imageStr;

@end

NS_ASSUME_NONNULL_END
