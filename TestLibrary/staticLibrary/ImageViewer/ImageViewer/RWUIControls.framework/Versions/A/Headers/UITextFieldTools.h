//
//  UITextFieldTools.h
//  Prime
//
//  Created by Coody on 2015/9/12.
//  Copyright (c) 2015年 Coody. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UITextFieldTools_Protocol <NSObject>

-(void)endCheckWithSender:(id)sender;

@end

/**
 * @brief - 擴充 UITextField 的辨識字元、截斷字元功能
 */
@interface UITextFieldTools : NSObject

/** 非必要的 Delegate */
@property (nonatomic , weak) id < UITextFieldTools_Protocol > delegate;

/** 所需要限制的長度 */
@property (nonatomic , assign) NSUInteger substringLength;

/** 所需要比對的「正規表達式(Regular Expression)」字串 */
@property (nonatomic , assign) NSUInteger minStringLength;

/** 比對最小長度後的結果 */
@property (nonatomic , readonly) BOOL isMinStringLegal;

/** 所需要比對的「正規表達式」字串 */
@property (nonatomic , strong) NSString *predicateString;
/** 正規表達式確認後的結果 */
@property (nonatomic , readonly) BOOL isPredicateLegal;

/**
 * @brief   - 會確認目前 UITextField 的字串的長度，並且截斷成所限制的長度設定回去
 * @warning - 請先設定 _substringLength 你要限制的長度
 */
-(void)checkStringLengthWithSender:(id)sender;

/**
 * @brief   - 會確認目前 UITextField 的字串的最小長度，將結果存入 property: isMinStringLegal
 * @warning - 請先設定 _minStringLength 你要確認的最小長度
 */
-(void)checkStringMinWithSender:(id)sender;

/**
 * @brief - 會依照正規表達式來確認 UITextField 的字串是否符合規則
 * @warning - 請先設定 _predicateString 正規表達式的規則（例：要英文數字以及電話號碼就 @[a-zA-Z0-9] 即可）
 */
-(void)checkWordWithSender:(id)sender;

/**
 * @brief - 會確認所有曾在 UITextFieldTools 中，設定過的設定值
 *
 */
-(void)checkAllSettingsInTools:(id)sender;

@end
