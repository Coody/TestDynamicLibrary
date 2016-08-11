//
//  UITextFieldTools.m
//  Prime
//
//  Created by Coody on 2015/9/12.
//  Copyright (c) 2015年 Coody. All rights reserved.
//

#import "UITextFieldTools.h"

#import <UIKit/UIKit.h>

@implementation UITextFieldTools

-(id)init{
    self = [super init];
    if ( self ) {
        // 最大長度截斷
        _substringLength = NSUIntegerMax;
        
        // 確認最小長度
        _minStringLength = NSUIntegerMax;
        _isMinStringLegal = NO;
        
        // 確認正規表達式字串
        _predicateString = @"";
        _isPredicateLegal = NO;
    }
    return self;
}

/**
 * @brief   - 會確認目前 UITextField 的字串的長度，並且截斷成所限制的長度設定回去
 * @warning - 請先設定 _substringLength 你要限制的長度
 */
-(void)checkStringLengthWithSender:(id)sender{
    if ( [sender isMemberOfClass:[UITextField class]] ) {
        if ( _substringLength == NSUIntegerMax ) {
            return;
        }
        UITextField *textField = (UITextField *)sender;
        if ( [textField.text length] > _substringLength ) {
            textField.text = [textField.text substringToIndex:_substringLength];
        }
        
        if ( [_delegate respondsToSelector:@selector(endCheckWithSender:)] ) {
            [_delegate endCheckWithSender:sender];
        }
    }
}

/**
 * @brief   - 會確認目前 UITextField 的字串的最小長度，將結果存入 property: isMinStringLegal
 * @warning - 請先設定 _minStringLength 你要確認的最小長度
 */
-(void)checkStringMinWithSender:(id)sender{
    if ( [sender isMemberOfClass:[UITextField class]] ) {
        if ( _minStringLength == NSUIntegerMax ) {
            return;
        }
        UITextField *textField = (UITextField *)sender;
        if ( [textField.text length] >= _minStringLength ) {
            _isMinStringLegal = YES;
        }
        else{
            _isMinStringLegal = NO;
        }
        
        if ( [_delegate respondsToSelector:@selector(endCheckWithSender:)] ) {
            [_delegate endCheckWithSender:sender];
        }
    }
}

/**
 * @brief - 會依照正規表達式來確認 UITextField 的字串是否符合規則
 * @warning - 請先設定 _predicateString 正規表達式的規則（例：要英文數字以及電話號碼就 @[a-zA-Z0-9] 即可）
 */
-(void)checkWordWithSender:(id)sender{
    if ( [sender isMemberOfClass:[UITextField class]] ) {
        if ( _predicateString == nil || 
            [_predicateString isEqualToString:@""] ) {
            return;
        }
        UITextField *textField = (UITextField *)sender;
        NSPredicate *phonePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@" , _predicateString];
        _isPredicateLegal = [phonePredicate evaluateWithObject:textField.text];
        
        if ( [_delegate respondsToSelector:@selector(endCheckWithSender:)] ) {
            [_delegate endCheckWithSender:sender];
        }
    }
}

/**
 * @brief - 會確認所有曾在 UITextFieldTools 中，設定過的設定值
 *
 */
-(void)checkAllSettingsInTools:(id)sender{
    [self checkStringMinWithSender:sender]; // 最小字串
    [self checkStringLengthWithSender:sender];  // 最大長度截斷
    [self checkWordWithSender:sender];  // 是否符合正規表達式
    
    if ( [_delegate respondsToSelector:@selector(endCheckWithSender:)] ) {
        [_delegate endCheckWithSender:sender];
    }
}

@end
