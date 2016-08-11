//
//  ViewTools.m
//  Prime
//
//  Created by Coody on 2015/8/21.
//  Copyright (c) 2015年 Coody. All rights reserved.
//

#import "ViewTools.h"

// for Tools
#import <CoreText/CoreText.h>

NSInteger const kArrowImage_Tag = 6481;


#pragma mark - Create UI 元件
@interface ViewTools()
// 一般設定
@property (nonatomic) CGFloat viewHeight;
@property (nonatomic , strong) UIColor *allTextDefaultColor;
@property (nonatomic , strong) UIColor *btnTextColor;
@property (nonatomic , strong) UIColor *btnLeftTextColor;
@property (nonatomic , strong) UIColor *btnRightTextColor;
@property (nonatomic , strong) UIColor *labelTextColor;
@property (nonatomic , strong) UIColor *textFieldTextColor;
@property (nonatomic , strong) UIColor *textFieldInnerColor;
@property (nonatomic , strong) UIColor *textButtonColor;
@property (nonatomic , assign) CGFloat customButtonLeftMargin;
@property (nonatomic , assign) CGFloat customButtonRightMargin;
// 按鈕
@property (nonatomic , strong) UIImage *buttonImage_Normal;
@property (nonatomic , strong) UIImage *buttonImage_HightLight;
@property (nonatomic , strong) UIImage *buttonImage_Disable;
@property (nonatomic , strong) UIImage *buttonImage_Red_Normal;
@property (nonatomic , strong) UIImage *buttonImage_Red_HightLight;
@property (nonatomic , strong) UIImage *arrowImage;
// TextField
@property (nonatomic , strong) UIImage *textFieldImage;

@property (nonatomic , strong) NSArray *recentObjects;

@end

@implementation ViewTools

-(id)init{
    self = [super init];
    if (self) {
        // 目前建立好的 View 是哪種？
        _recentObjects = nil;
        
        // 初始化設定
        _viewHeight = D_ViewTools_ViewHeight;
        _textFont = D_ViewTools_Text_Font;
        _allTextDefaultColor = D_ViewTools_Text_Color;
        
        // Label Text Color
        _labelTextColor = _allTextDefaultColor;
        
        // button Text Color
        _btnTextColor = _allTextDefaultColor;
        _btnLeftTextColor = _btnRightTextColor = _allTextDefaultColor;
        _textButtonColor = _allTextDefaultColor;
        
        // TextField Text Color
        _textFieldTextColor = _allTextDefaultColor;
        _textFieldInnerColor = _allTextDefaultColor;
        
        // 左右有文字、右邊有箭頭的左右間距
        self.customButtonLeftMargin = self.customButtonRightMargin = 6.0f;
        
        // 輸入框中，游標的顏色
        [[UITextField appearance] setTintColor:[UIColor whiteColor]];
        
        // 按鈕
        _buttonImage_Normal = [UIImage imageNamed:D_ViewTools_Button_Normal_Image];
        _buttonImage_HightLight = [UIImage imageNamed:D_ViewTools_Button_HightLight_Image];
        _buttonImage_Disable = [UIImage imageNamed:D_ViewTools_Button_Disable_Image];
        _buttonImage_Red_Normal = [UIImage imageNamed:D_ViewTools_Button_Red_Normal_Image];
        _buttonImage_Red_HightLight = [UIImage imageNamed:D_ViewTools_Button_Red_HightLight_Image];
        _arrowImage = [UIImage imageNamed:D_ViewTools_Arrow_Image];
        
        _textFieldImage = [UIImage imageNamed:D_ViewTools_TextField_Image];
    }
    return self;
}

-(void)dealloc{
    _buttonImage_Normal = nil;
    _buttonImage_HightLight = nil;
    _buttonImage_Disable = nil;
    _buttonImage_Red_Normal = nil;
    _buttonImage_Red_HightLight = nil;
    _arrowImage = nil;
    _textFieldImage = nil;
}

#pragma mark ：取得目前主要元件
/////////////////////////////////////
/** 取得目前主要元件 */
-(NSArray *)getRecentObjects{
    return _recentObjects;
}

#pragma mark - 設定 View
-(void)setViewHeight:(CGFloat)tempViewHeight{
    if ( tempViewHeight >= 0 ) {
        _viewHeight = tempViewHeight;
    }
    else{
        _viewHeight = 0;
    }
}

-(CGFloat)getViewHeight{
    return _viewHeight;
}

// private
-(void)setAllTextColor:(UIColor *)tempColor{
    _allTextDefaultColor = tempColor;
    
    // Label Text Color
    _labelTextColor = _allTextDefaultColor;
    
    // button Text Color
    _btnTextColor = _allTextDefaultColor;
    _btnLeftTextColor = _btnRightTextColor = _allTextDefaultColor;
    
    // TextField Text Color
    _textFieldTextColor = _allTextDefaultColor;
    _textFieldInnerColor = _allTextDefaultColor;
}

-(void)setButtonImage:(UIImage *)tempButtonImage 
andButtonHightLightImage:(UIImage *)tempButtonHightLightImage 
andButtonDisableImage:(UIImage *)tempDisableImage
{
    _buttonImage_Normal = tempButtonImage;
    _buttonImage_HightLight = tempButtonHightLightImage;
    _buttonImage_Disable = tempDisableImage;
}

-(void)setButtonTextColor:(UIColor *)tempColor{
    _btnTextColor = tempColor;
}

-(void)setButtonLeftTextColor:(UIColor *)tempColor{
    _btnLeftTextColor = tempColor;
}

-(void)setButtonRightTextColor:(UIColor *)tempColor{
    _btnRightTextColor = tempColor;
}

-(void)setLabelTextColor:(UIColor *)tempColor{
    _labelTextColor = tempColor;
}

-(void)setTextButtonColor:(UIColor *)tempColor{
    _textButtonColor = tempColor;
}

-(void)setArrowImage:(UIImage *)arrowImage
{
    _arrowImage = arrowImage;
}

-(void)setTextFieldImage:(UIImage *)textFieldImage{
    _textFieldImage = textFieldImage;
}

-(void)setTextFieldTextColor:(UIColor *)textFieldTextColor{
    _textFieldTextColor = textFieldTextColor;
}

-(void)setTextFieldInnerColor:(UIColor *)textFieldInnerColor{
    _textFieldInnerColor = textFieldInnerColor;
}

-(void)setTextFont:(UIFont *)textFont{
    _textFont = textFont;
}

-(void)setTextFieldTintColor:(UIColor *)tempColor{
    [[UITextField appearance] setTintColor:tempColor];
}

-(void)setCustomButtonLeftMargin:(CGFloat)customButtonLeftMargin{
    if ( customButtonLeftMargin >= 0 ) {
        _customButtonLeftMargin = customButtonLeftMargin;
    }
    else{
        _customButtonLeftMargin = 0;
    }
}

-(void)setCustomButtonRightMargin:(CGFloat)customButtonRightMargin{
    if ( customButtonRightMargin >= 0 ) {
        _customButtonRightMargin = customButtonRightMargin;
    }
    else{
        _customButtonRightMargin = 0;
    }
}

#pragma mark - 建立按鈕（左邊、右邊都有文字、還有右邊箭頭）

// 2.1.1 建立特殊按鈕（左邊、右邊都有文字、還有右邊箭頭）
-(UIButton *)createButtonWithLeftText:(NSString *)tempLeftText 
                        withRightText:(NSString *)tempRightText 
                        withNeedArrow:(BOOL)tempIsNeedArrow
{
    return [self createButtonWithLeftText:tempLeftText
                            withRightText:tempRightText 
                            withNeedArrow:tempIsNeedArrow 
                          withCustomFrame:CGRectMake(_customButtonLeftMargin,
                                                     0,
                                                     [UIScreen mainScreen].bounds.size.width - _customButtonLeftMargin - _customButtonRightMargin ,
                                                     _viewHeight )  
                          withLabelStatic:EnumLabelStaticType_None 
                     withIsNeedAutoResize:YES];
}

// 2.1.2 建立 Attribute 字串的特殊按鈕
-(UIButton *)createButtonWithLeftAttributedText:(NSMutableAttributedString *)tempLeftText 
                        withRightAttributedText:(NSMutableAttributedString *)tempRightText 
                                  withNeedArrow:(BOOL)tempIsNeedArrow
{
    return [self createButtonWithLeftAttributedText:tempLeftText 
                                     withLineHeight:1.0f 
                            withRightAttributedText:tempRightText 
                                     withLineHeight:1.0f 
                                      withNeedArrow:tempIsNeedArrow
                                    withCustomWidth:[UIScreen mainScreen].bounds.size.width 
                               withIsNeedAutoResize:YES];
}

// 2.1.3 建立 Attribute 字串的特殊按鈕
-(UIButton *)createButtonWithLeftAttributedText:(NSMutableAttributedString *)tempLeftText 
                                 withLineHeight:(CGFloat)tempLeftLineHeight  
                        withRightAttributedText:(NSMutableAttributedString *)tempRightText 
                                 withLineHeight:(CGFloat)tempRightLineHeight 
                                  withNeedArrow:(BOOL)tempIsNeedArrow
{
    return [self createButtonWithLeftAttributedText:tempLeftText 
                                     withLineHeight:tempLeftLineHeight 
                            withRightAttributedText:tempRightText 
                                     withLineHeight:tempRightLineHeight 
                                      withNeedArrow:tempIsNeedArrow 
                                    withCustomWidth:[UIScreen mainScreen].bounds.size.width 
                               withIsNeedAutoResize:YES];
}

// 2.2.1 建立特殊按鈕（給設定的寬度）（左邊、右邊都有文字、還有右邊箭頭）
-(UIButton *)createButtonWithLeftText:(NSString *)tempLeftText 
                        withRightText:(NSString *)tempRightText 
                        withNeedArrow:(BOOL)tempIsNeedArrow 
                      withCustomWidth:(float)tempCustomWidth
{    
    return [self createButtonWithLeftText:tempLeftText
                            withRightText:tempRightText 
                            withNeedArrow:tempIsNeedArrow 
                          withCustomFrame:CGRectMake(0 , 0, tempCustomWidth, _viewHeight )  
                          withLabelStatic:EnumLabelStaticType_None 
                     withIsNeedAutoResize:NO];
}

// 2.2.2 建立Attributed 字串的特殊按鈕（給設定的寬度）（左邊、右邊都有文字、還有右邊箭頭）
-(UIButton *)createButtonWithLeftAttributeText:(NSMutableAttributedString *)tempLeftText 
                        withRightAttributeText:(NSMutableAttributedString *)tempRightText 
                                 withNeedArrow:(BOOL)tempIsNeedArrow 
                               withCustomWidth:(float)tempCustomWidth
{
    return [self createButtonWithLeftAttributedText:tempLeftText 
                                     withLineHeight:1.0f 
                            withRightAttributedText:tempRightText 
                                     withLineHeight:1.0f 
                                      withNeedArrow:tempIsNeedArrow
                                    withCustomWidth:tempCustomWidth 
                               withIsNeedAutoResize:NO];
}

// 2.2.3
-(UIButton *)createButtonWithLeftAttributedText:(NSMutableAttributedString *)tempLeftText 
                                 withLineHeight:(CGFloat)tempLeftLineHeight  
                        withRightAttributedText:(NSMutableAttributedString *)tempRightText 
                                 withLineHeight:(CGFloat)tempRightLineHeight 
                                  withNeedArrow:(BOOL)tempIsNeedArrow 
                                withCustomWidth:(float)tempCustomWidth
{
    return [self createButtonWithLeftAttributedText:tempLeftText 
                                     withLineHeight:tempLeftLineHeight  
                            withRightAttributedText:tempRightText 
                                     withLineHeight:tempRightLineHeight 
                                      withNeedArrow:tempIsNeedArrow 
                                    withCustomWidth:tempCustomWidth 
                               withIsNeedAutoResize:NO];
}

-(UIButton *)createButtonWithLeftAttributedText:(NSMutableAttributedString *)tempLeftText 
                                 withLineHeight:(CGFloat)tempLeftLineHeight  
                        withRightAttributedText:(NSMutableAttributedString *)tempRightText 
                                 withLineHeight:(CGFloat)tempRightLineHeight 
                                  withNeedArrow:(BOOL)tempIsNeedArrow 
                                withCustomWidth:(float)tempCustomWidth 
                           withIsNeedAutoResize:(BOOL)isNeedAutoResize
{
    UIButton *button = [self getBasicButtonWithFrame:CGRectMake(0, 
                                                                0, 
                                                                tempCustomWidth,
                                                                _viewHeight)];
    if ( isNeedAutoResize ) {
        button.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    }
    else{
        button.autoresizingMask = UIViewAutoresizingNone;
    }
    
    // 建立箭頭
    UIImageView *arrowImageView = [[UIImageView alloc] initWithImage:_arrowImage];
    CGFloat arrowWidth = 0.0f;
    [arrowImageView setFrame:CGRectMake(tempCustomWidth - arrowImageView.frame.size.width - D_ViewTools_Label_Left_Margin,
                                        (_viewHeight - arrowImageView.frame.size.height)*0.5 ,
                                        arrowImageView.frame.size.width,
                                        arrowImageView.frame.size.height)];
    [button addSubview:arrowImageView];
    arrowImageView.tag = kArrowImage_Tag;
    arrowImageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    
    if ( tempIsNeedArrow ) 
    {
        [arrowImageView setAlpha:1.0f];
        arrowWidth = arrowImageView.frame.size.width + D_ViewTools_Label_Right_Margin;
    }
    else
    {
        [arrowImageView setAlpha:0.0f];
        arrowWidth = 0.0f;
    }
    
    
    
    // 將內部元進整理成陣列回傳（多個元件時）
    NSMutableArray *tempReturnObjects = [[NSMutableArray alloc] init];
    
    ViewTools *privateViewTools = [[ViewTools alloc] init];
    [privateViewTools setTextFont:_textFont];
    
    // 建立左邊文字
    if ( tempLeftText != nil )
    {
        UILabel *firstLabel = [privateViewTools createLabelWithAttributeText:tempLeftText 
                                                              withLineHeight:tempLeftLineHeight
                                                           withTextAlignment:(NSTextAlignmentLeft)];
        firstLabel.frame = CGRectMake(D_ViewTools_Label_Left_Margin ,
                                      0,
                                      firstLabel.frame.size.width,
                                      _viewHeight);
        [firstLabel setTag:1];
        [firstLabel setNumberOfLines:0];
        firstLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
        [button addSubview:firstLabel];
        
#ifdef D_DEBUG
        [firstLabel setBackgroundColor:[UIColor greenColor]];
#endif
        
        // 將元件加入陣列（等等會暫時存入 recentObject）
        [tempReturnObjects addObject:firstLabel];
    }
    
    // 建立右邊文字
    if ( tempRightText != nil )
    {
        UILabel *secondLabel = [privateViewTools createLabelWithAttributeText:tempRightText 
                                                               withLineHeight:tempRightLineHeight 
                                                            withTextAlignment:(NSTextAlignmentRight)];
        secondLabel.frame = CGRectMake(button.frame.size.width - arrowWidth - secondLabel.frame.size.width - D_ViewTools_Label_Right_Margin ,
                                       0,
                                       secondLabel.frame.size.width,
                                       _viewHeight);
        [secondLabel setTag:2];
        secondLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        [button addSubview:secondLabel];
        
#ifdef D_DEBUG
        [secondLabel setBackgroundColor:[UIColor greenColor]];
#endif
        
        // 將元件加入陣列（等等會暫時存入 recentObject）
        [tempReturnObjects addObject:secondLabel];
    }
    
    // 將元件陣列暫時存入 recentObjects
    _recentObjects = nil;
    _recentObjects = tempReturnObjects;
    
    return button;
}

// 2.2.4 建立特殊按鈕（預設畫面寬度 - 12）（左邊、右邊都有文字、還有右邊箭頭，固定某一邊的 Label ，另一邊的寬會延長至某一邊的 Label）
-(UIButton *)createButtonWithLeftText:(NSString *)tempLeftText
                        withRightText:(NSString *)tempRightText 
                        withNeedArrow:(BOOL)tempIsNeedArrow 
                      withLabelStatic:(EnumLabelStaticType)tempEnumLabelStaticType
{
    return [self createButtonWithLeftText:tempLeftText
                            withRightText:tempRightText 
                            withNeedArrow:tempIsNeedArrow 
                          withCustomFrame:CGRectMake(_customButtonLeftMargin, 0, [UIScreen mainScreen].bounds.size.width - _customButtonLeftMargin - _customButtonRightMargin, _viewHeight )  
                          withLabelStatic:tempEnumLabelStaticType 
                     withIsNeedAutoResize:YES];
}

// 2.2.5 建立特殊按鈕（給設定的寬度）（左邊、右邊都有文字、還有右邊箭頭，固定某一邊的 Label ，另一邊的寬會延長至某一邊的 Label）
-(UIButton *)createButtonWithLeftText:(NSString *)tempLeftText
                        withRightText:(NSString *)tempRightText 
                        withNeedArrow:(BOOL)tempIsNeedArrow 
                      withCustomWidth:(float)tempCustomWidth 
                      withLabelStatic:(EnumLabelStaticType)tempEnumLabelStaticType
{
    return [self createButtonWithLeftText:tempLeftText
                            withRightText:tempRightText 
                            withNeedArrow:tempIsNeedArrow 
                          withCustomFrame:CGRectMake(0, 0, tempCustomWidth, _viewHeight ) 
                          withLabelStatic:tempEnumLabelStaticType 
                     withIsNeedAutoResize:NO];
}

// 2.2.6 建立特殊按鈕（給設定的 frame ）（左邊、右邊都有文字、還有右邊箭頭，固定某一邊的 Label ，另一邊的寬會延長至某一邊的 Label）
-(UIButton *)createButtonWithLeftText:(NSString *)tempLeftText
                        withRightText:(NSString *)tempRightText 
                        withNeedArrow:(BOOL)tempIsNeedArrow 
                      withCustomFrame:(CGRect)tempCustomFrame 
                      withLabelStatic:(EnumLabelStaticType)tempEnumLabelStaticType 
                 withIsNeedAutoResize:(BOOL)needAutoResize
{
    UIButton *button = [self getBasicButtonWithFrame:tempCustomFrame];
    
    if ( needAutoResize ) {
        button.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    }
    else{
        button.autoresizingMask = UIViewAutoresizingNone;
    }
    
    // 建立箭頭
    UIImageView *arrowImageView;
    
    // 設定「箭頭 + 左邊固定間距」
    CGFloat arrowWidth = 0.0f;
    arrowImageView = [[UIImageView alloc] initWithImage:_arrowImage];
    [arrowImageView setFrame:CGRectMake(tempCustomFrame.size.width - arrowImageView.frame.size.width - D_ViewTools_Label_Right_Margin,
                                        (_viewHeight - arrowImageView.frame.size.height)*0.5,
                                        arrowImageView.frame.size.width,
                                        arrowImageView.frame.size.height)];
    [button addSubview:arrowImageView];
    arrowImageView.tag = kArrowImage_Tag;
    arrowImageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    
    if ( tempIsNeedArrow ) 
    {
        [arrowImageView setAlpha:1.0f];
        // 左邊間距 + 箭頭的寬度
        arrowWidth = arrowImageView.frame.size.width + D_ViewTools_Label_Middle_Margin;
    }
    else
    {
        [arrowImageView setAlpha:0.0f];
        arrowWidth = 0.0f;
    }
    
    // 將內部元進整理成陣列回傳（多個元件時）
    NSMutableArray *tempReturnObjects = [[NSMutableArray alloc] init];
    
    ViewTools *privateViewTools = [[ViewTools alloc] init];
    [privateViewTools setViewHeight:tempCustomFrame.size.height];
    
#define D_Reconstruction
#ifdef D_Reconstruction
    /////////////// 建立內部文字區塊 ///////////////
    
    // 建立左邊、右邊文字
    UILabel *firstLabel;
    UILabel *secondLebal;
    if ( tempLeftText != nil ) {
        firstLabel = [privateViewTools createLabelWithText:tempLeftText withTextAlignment:NSTextAlignmentLeft];
        firstLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
        [firstLabel setTag:1];
        [firstLabel setNumberOfLines:0];
        [button addSubview:firstLabel];
        
#ifdef D_DEBUG
        [firstLabel setBackgroundColor:[UIColor greenColor]];
#endif
        
        [tempReturnObjects addObject:firstLabel];
    }
    if ( tempRightText != nil ) {
        secondLebal = [privateViewTools createLabelWithText:tempRightText withTextAlignment:NSTextAlignmentRight];
        secondLebal.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        [secondLebal setTag:2];
        [secondLebal setNumberOfLines:0];
        [button addSubview:secondLebal];
        
#ifdef D_DEBUG
        [secondLebal setBackgroundColor:[UIColor greenColor]];
#endif
        
        [tempReturnObjects addObject:secondLebal];
    }
    
    // 處理 frame
    switch ( tempEnumLabelStaticType ) {
        case EnumLabelStaticType_LeftStatic:
        {
            // 左邊固定、右邊改變 frame 拉到最大
            [firstLabel setFrame:CGRectMake(D_ViewTools_Label_Left_Margin,
                                            0,
                                            firstLabel.frame.size.width,
                                            firstLabel.frame.size.height)];
            [secondLebal setFrame:CGRectMake(firstLabel.frame.origin.x + firstLabel.frame.size.width + D_ViewTools_Label_Middle_Margin,
                                             0,
                                             button.frame.size.width - firstLabel.frame.size.width - D_ViewTools_Label_Left_Margin - D_ViewTools_Label_Middle_Margin - D_ViewTools_Label_Right_Margin - arrowWidth ,
                                             secondLebal.frame.size.height )];
            secondLebal.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        }
            break;
        case EnumLabelStaticType_RightStatic:
        {
            // 右邊固定、左邊改變 frame 拉到最大
            [firstLabel setFrame:CGRectMake(D_ViewTools_Label_Left_Margin,
                                            0,
                                            button.frame.size.width - secondLebal.frame.origin.x - secondLebal.frame.size.width - D_ViewTools_Label_Left_Margin - D_ViewTools_Label_Middle_Margin - D_ViewTools_Label_Right_Margin - arrowWidth ,
                                            firstLabel.frame.size.height)];
            firstLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            [secondLebal setFrame:CGRectMake(firstLabel.frame.origin.x + firstLabel.frame.size.width + D_ViewTools_Label_Middle_Margin,
                                             0,
                                             secondLebal.frame.size.width,
                                             secondLebal.frame.size.height)];
        }
            break;
        case EnumLabelStaticType_None:
        default:
        {
            // 不處理，維持現狀。
            [firstLabel setFrame:CGRectMake(D_ViewTools_Label_Left_Margin,
                                            0,
                                            firstLabel.frame.size.width,
                                            firstLabel.frame.size.height)];
            [secondLebal setFrame:CGRectMake(button.frame.size.width - D_ViewTools_Label_Right_Margin - arrowWidth - secondLebal.frame.size.width,
                                             0,
                                             secondLebal.frame.size.width,
                                             secondLebal.frame.size.height)];
        }
            break;
    }
    
    
    
#else
    
    
    // 建立左邊文字
    UILabel *firstLabel;
    if ( tempLeftText != nil )
    {
        firstLabel = [privateViewTools createLabelWithText:tempLeftText 
                                         withTextAlignment:(NSTextAlignmentLeft)];
        
        // 右邊為固定的長度（左邊文字寬度會依照右邊來計算到最大寬度）
        if ( tempEnumLabelStaticType == EnumLabelStaticType_RightStatic ) {
            CGSize tempSize = CGSizeMake(0,0);
            
            // 計算右邊寬度
            if ( tempRightText != nil ) {
                tempSize = [ViewTools getTextSizeWithWidth:CGFLOAT_MAX 
                                                  withText:tempRightText 
                                                  withFont:_textFont];
            }
            
            firstLabel.frame = CGRectMake(D_ViewTools_Label_Left_Margin,
                                          0,
                                          button.frame.size.width - D_ViewTools_Label_Left_Margin - arrowWidth - tempSize.width,
                                          _viewHeight);
        }
        else{
            firstLabel.frame = CGRectMake(D_ViewTools_Label_Left_Margin,
                                          0,
                                          firstLabel.frame.size.width,
                                          _viewHeight);
        }
        
        [firstLabel setTag:1];
        [firstLabel setNumberOfLines:0];
        firstLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
        [button addSubview:firstLabel];
        
        // 將元件加入陣列（等等會暫時存入 recentObject）
        [tempReturnObjects addObject:firstLabel];
    }
    
    // 建立右邊文字
    UILabel *secondLabel;
    if ( tempRightText != nil )
    {
        secondLabel = [privateViewTools createLabelWithText:tempRightText 
                                          withTextAlignment:(NSTextAlignmentRight)];
        secondLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        if ( tempEnumLabelStaticType == EnumLabelStaticType_LeftStatic ) {
            secondLabel.frame = CGRectMake(firstLabel.frame.origin.x + firstLabel.frame.size.width + D_ViewTools_Label_Middle_Margin ,
                                           0,
                                           button.frame.size.width - D_ViewTools_Label_Left_Margin*2 - arrowWidth - firstLabel.frame.size.width - D_ViewTools_Label_Middle_Margin ,
                                           _viewHeight);
        }
        else{
            secondLabel.frame = CGRectMake(button.frame.size.width - D_ViewTools_Label_Left_Margin - arrowWidth - D_ViewTools_Label_Middle_Margin - secondLabel.frame.size.width ,
                                           0,
                                           secondLabel.frame.size.width,
                                           _viewHeight);
        }
        [secondLabel setTag:2];
        secondLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        [button addSubview:secondLabel];
        
        // 將元件加入陣列（等等會暫時存入 recentObject）
        [tempReturnObjects addObject:secondLabel];
    }
    
#endif
    
    // 將元件陣列暫時存入 recentObjects
    _recentObjects = nil;
    _recentObjects = tempReturnObjects;
    
    return button;
}


// 2.3.1 建立一般按鈕（左右沒有留空）
-(UIButton *)createButtonWithText:(NSString *)tempText
{
    return [self createButtonWithText:tempText 
                      withCustomFrame:CGRectMake(0, 
                                                 0, 
                                                 [UIScreen mainScreen].bounds.size.width,
                                                 _viewHeight)
                      withIsRedButton:NO 
                 withIsNeedAutoResize:YES];
}

/** 
 * @brief - 2.3.2 建立一般按鈕（中間有置中的文字、左右有留 6 pixel 的空）
 */
-(UIButton *)createButtonWithTextAndMargin:(NSString *)tempText{
    return [self createButtonWithText:tempText 
                      withCustomFrame:CGRectMake(6, 
                                                 0, 
                                                 [UIScreen mainScreen].bounds.size.width - 12,
                                                 _viewHeight) 
                      withIsRedButton:NO 
                 withIsNeedAutoResize:YES];
}

// 2.4.1 建立一般按鈕（給設定的寬度）
-(UIButton *)createButtonWithText:(NSString *)tempText
                  withCustomWidth:(float)tempCustomWidth
{
    return [self createButtonWithText:tempText 
                      withCustomFrame:CGRectMake(0, 
                                                 0, 
                                                 tempCustomWidth,
                                                 _viewHeight)
                      withIsRedButton:NO 
                 withIsNeedAutoResize:NO];
}

// 2.5 建立一般紅色按鈕
-(UIButton *)createRedButtonWithText:(NSString *)tempText
{
    return [self createButtonWithText:tempText 
                      withCustomFrame:CGRectMake(0, 
                                                 0, 
                                                 [UIScreen mainScreen].bounds.size.width,
                                                 _viewHeight)
                      withIsRedButton:YES 
                 withIsNeedAutoResize:YES];
}
// 2.6 建立一般紅色按鈕（給設定的寬度）
-(UIButton *)createRedButtonWithText:(NSString *)tempText 
                     withCustomWidth:(float)tempCustomWidth
{
    return [self createButtonWithText:tempText 
                      withCustomFrame:CGRectMake(0, 
                                                 0, 
                                                 tempCustomWidth,
                                                 _viewHeight)
                      withIsRedButton:YES 
                 withIsNeedAutoResize:NO];
}

// 2.7 建立一般按鈕共用方法（給定 Text , CustomWidth , 是否為 Red Button ）
-(UIButton *)createButtonWithText:(NSString *)tempText 
                  withCustomWidth:(float)tempCustomWidth 
                  withIsRedButton:(BOOL)tempIsRedButton
{
    return [self createButtonWithText:tempText 
                      withCustomFrame:CGRectMake(0, 
                                                 0, 
                                                 tempCustomWidth,
                                                 _viewHeight)
                      withIsRedButton:tempIsRedButton 
                 withIsNeedAutoResize:NO];
}

// 2.8 建立一般按鈕共用方法（給定 Text , CustomFrame , 是否為 Red Button ）
-(UIButton *)createButtonWithText:(NSString *)tempText 
                  withCustomFrame:(CGRect)tempCustomFrame 
                  withIsRedButton:(BOOL)tempIsRedButton
{
    return [self createButtonWithText:tempText 
                      withCustomFrame:tempCustomFrame 
                      withIsRedButton:tempIsRedButton 
                 withIsNeedAutoResize:NO];
}

-(UIButton *)createButtonWithText:(NSString *)tempText 
                  withCustomFrame:(CGRect)tempCustomFrame 
                  withIsRedButton:(BOOL)tempIsRedButton 
             withIsNeedAutoResize:(BOOL)isNeedAutoResize
{
    UIButton *button = [[UIButton alloc] initWithFrame:tempCustomFrame];
    
    [button setImageEdgeInsets:UIEdgeInsetsMake(2, 5, 2, 5)];
    if ( tempIsRedButton ) {
        [button setBackgroundImage:[_buttonImage_Red_Normal 
                                    resizableImageWithCapInsets:UIEdgeInsetsMake( 10, 10, 10, 10) 
                                    resizingMode:UIImageResizingModeStretch] 
                          forState:(UIControlStateNormal)];
        [button setBackgroundImage:[_buttonImage_Red_HightLight  
                                    resizableImageWithCapInsets:UIEdgeInsetsMake( 10, 10, 10, 10) 
                                    resizingMode:UIImageResizingModeStretch] 
                          forState:(UIControlStateHighlighted)];
        [button setBackgroundImage:[_buttonImage_Red_HightLight 
                                    resizableImageWithCapInsets:UIEdgeInsetsMake( 10, 10, 10, 10) 
                                    resizingMode:UIImageResizingModeStretch] 
                          forState:(UIControlStateDisabled)];
    }
    else{
        [button setBackgroundImage:[_buttonImage_Normal
                                    resizableImageWithCapInsets:UIEdgeInsetsMake( 10, 10, 10, 10) 
                                    resizingMode:UIImageResizingModeStretch] 
                          forState:(UIControlStateNormal)];
        [button setBackgroundImage:[_buttonImage_HightLight
                                    resizableImageWithCapInsets:UIEdgeInsetsMake( 10, 10, 10, 10) 
                                    resizingMode:UIImageResizingModeStretch] 
                          forState:(UIControlStateHighlighted)];
        //        [button setBackgroundImage:[_buttonImage_Disable
        //                                    resizableImageWithCapInsets:UIEdgeInsetsMake( 10, 10, 10, 10) 
        //                                    resizingMode:UIImageResizingModeStretch] 
        //                          forState:(UIControlStateDisabled)];
    }
    
    if ( isNeedAutoResize ) {
        button.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    }
    else{
        button.autoresizingMask = UIViewAutoresizingNone;
    }
    
    [button setTitle:tempText forState:UIControlStateNormal];
    [button setTitleColor:_btnTextColor forState:UIControlStateNormal];
    [button.titleLabel setFont:_textFont];
    
    // 將元件陣列暫時存入 recentObjects
    _recentObjects = nil;
    _recentObjects = @[button];
    
    return button;
}

/**
 * @brief - 2.9 建立只有文字的 button （基本型：紅色字體、底下有線）
 */
-(UIButton *)createTextButtonWithText:(NSString *)tempText
{
    return [self createTextButtonWithText:tempText 
                            withTextColor:[UIColor redColor] 
                                 withLine:YES];
}

/**
 * @brief - 2.10 建立只有文字的 button （可設定顏色、底線是否需要）
 */
-(UIButton *)createTextButtonWithText:(NSString *)tempText 
                        withTextColor:(UIColor *)tempColor 
                             withLine:(BOOL)isNeedLine
{
    return [self createTextButtonWithText:tempText 
                            withTextColor:tempColor 
                                 withLine:isNeedLine 
                             withTextFont:_textFont];
}

/**
 * @brief - 2.11 建立只有文字的 button （可設定顏色、底線是否需要、字體大小）
 */
-(UIButton *)createTextButtonWithText:(NSString *)tempText 
                        withTextColor:(UIColor *)tempColor 
                             withLine:(BOOL)isNeedLine 
                         withTextFont:(UIFont *)tempFont
{
    return [self createTextButtonWithText:tempText 
                            withTextColor:tempColor 
                                 withLine:isNeedLine 
                             withTextFont:tempFont 
                 withIsNeedAutoResizeMask:NO];
}

/**
 * @brief - 2.12 建立只有文字的 button （可設定顏色、底線是否需要、字體大小）
 */
-(UIButton *)createTextButtonWithText:(NSString *)tempText 
                        withTextColor:(UIColor *)tempColor 
                             withLine:(BOOL)isNeedLine 
                         withTextFont:(UIFont *)tempFont 
             withIsNeedAutoResizeMask:(BOOL)isNeedAutoResizeMask
{
    CGSize tempSize = [ViewTools getTextSizeWithWidth:CGFLOAT_MAX withText:tempText withFont:tempFont];
    if ( tempSize.width > [UIScreen mainScreen].bounds.size.width ) {
        tempSize = [ViewTools getTextSizeWithWidth:[UIScreen mainScreen].bounds.size.width 
                                          withText:tempText 
                                          withFont:tempFont];
    }
    if ( tempSize.height <= _viewHeight ) {
        tempSize.height = _viewHeight;
    }
    
    UIButton *textButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [textButton setFrame:CGRectMake(0, 0, tempSize.width, tempSize.height)];
    if ( isNeedLine ) {
        ///////
        NSDictionary *attrDict = @{NSFontAttributeName:tempFont,
                                   NSForegroundColorAttributeName:tempColor};
        NSMutableAttributedString *title =[[NSMutableAttributedString alloc] initWithString:tempText 
                                                                                 attributes:attrDict];
        [title addAttribute:NSUnderlineStyleAttributeName 
                      value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] 
                      range:NSMakeRange(0,[tempText length])];
        [textButton setAttributedTitle:title forState:UIControlStateNormal];
    }
    else{
        [textButton setTitle:tempText forState:UIControlStateNormal];
    }
    [textButton titleLabel].lineBreakMode = YES;
    [[textButton titleLabel] setFont:tempFont];
    [textButton setTitleColor:tempColor forState:UIControlStateNormal];
    
    if ( isNeedAutoResizeMask ) {
        textButton.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    }
    else{
        textButton.autoresizingMask = UIViewAutoresizingNone;
    }
    
    return textButton;
}

#pragma mark 左右有 Text 的按鈕擴充
// 2.13 額外設定左右有 Text 按鈕的 Arrow 是否顯示？
+(void)isNeedArrow:(BOOL)isNeedArrow withButton:(UIButton *)tempButton
{
    for ( UIView *unit in tempButton.subviews ) {
        if ( unit.tag == kArrowImage_Tag ) {
            if ( isNeedArrow == YES ) {
                [unit setAlpha:1.0f];
            }
            else{
                [unit setAlpha:0.0f];
            }
            break;
        }
    }
}

#pragma mark - 建立 Label
// 3.1.1
-(UILabel *)createLabelWithText:(NSString *)tempText 
              withTextAlignment:(NSTextAlignment)tempTextAlignment
{
    return [self createLabelWithText:tempText 
                   withTextAlignment:tempTextAlignment 
                       withTextColor:_labelTextColor];
}

// 3.1.1-2
-(UILabel *)createLabelWithText:(NSString *)tempText 
              withTextAlignment:(NSTextAlignment)tempTextAlignment 
           withIsNeedAutoResize:(BOOL)isNeedAutoResize
{
    CGSize tempSize = [ViewTools getTextSizeWithWidth:CGFLOAT_MAX withText:tempText withFont:_textFont];
    CGFloat tempHeight = _viewHeight;
    if ( tempSize.width > [UIScreen mainScreen].bounds.size.width ) {
        tempSize = [ViewTools getTextSizeWithWidth:[UIScreen mainScreen].bounds.size.width withText:tempText withFont:_textFont];
        tempHeight = tempSize.height;
    }
    return [self createLabelWithText:tempText 
                   withTextAlignment:tempTextAlignment
                     withCustomFrame:CGRectMake(0,0,tempSize.width,tempHeight) 
                       withTextColor:_labelTextColor 
                withIsNeedAutoResize:isNeedAutoResize];
}

// 3.1.2
-(UILabel *)createLabelWithAttributeText:(NSMutableAttributedString *)tempText 
                       withTextAlignment:(NSTextAlignment)tempTextAlignment
{
    return [self createLabelWithAttributeText:tempText 
                            withTextAlignment:tempTextAlignment 
                                withTextColor:_labelTextColor];
}

// 3.1.3
-(UILabel *)createLabelWithAttributeText:(NSMutableAttributedString *)tempText 
                          withLineHeight:(CGFloat)tempLineHeight
                       withTextAlignment:(NSTextAlignment)tempTextAlignment
{
    return [self createLabelWithAttributeText:tempText
                            withTextAlignment:tempTextAlignment 
                               withLineHeight:tempLineHeight 
                                withTextColor:_labelTextColor];
}

// 3.2.1
-(UILabel *)createLabelWithText:(NSString *)tempText 
              withTextAlignment:(NSTextAlignment)tempTextAlignment  
                  withTextColor:(UIColor *)tempTextColor
{
    CGSize tempSize = [ViewTools getTextSizeWithWidth:CGFLOAT_MAX withText:tempText withFont:_textFont];
    CGFloat tempHeight = _viewHeight;
    if ( tempSize.width > [UIScreen mainScreen].bounds.size.width ) {
        tempSize = [ViewTools getTextSizeWithWidth:[UIScreen mainScreen].bounds.size.width withText:tempText withFont:_textFont];
        tempHeight = tempSize.height;
    }
    
    return [self createLabelWithText:tempText 
                   withTextAlignment:tempTextAlignment
                     withCustomFrame:CGRectMake(0,0,tempSize.width,tempHeight) 
                       withTextColor:tempTextColor 
                withIsNeedAutoResize:NO];
}

// 3.2.1-2
-(UILabel *)createLabelWithText:(NSString *)tempText 
              withTextAlignment:(NSTextAlignment)tempTextAlignment  
                  withTextColor:(UIColor *)tempTextColor 
           withIsNeedAutoResize:(BOOL)isNeedAutoResize
{
    CGSize tempSize = [ViewTools getTextSizeWithWidth:CGFLOAT_MAX withText:tempText withFont:_textFont];
    CGFloat tempHeight = _viewHeight;
    if ( tempSize.width > [UIScreen mainScreen].bounds.size.width ) {
        tempSize = [ViewTools getTextSizeWithWidth:[UIScreen mainScreen].bounds.size.width withText:tempText withFont:_textFont];
        tempHeight = tempSize.height;
    }
    return [self createLabelWithText:tempText 
                   withTextAlignment:tempTextAlignment
                     withCustomFrame:CGRectMake(0,0,tempSize.width,tempHeight) 
                       withTextColor:tempTextColor 
                withIsNeedAutoResize:isNeedAutoResize];
}

// 3.2.2
-(UILabel *)createLabelWithAttributeText:(NSMutableAttributedString *)tempText 
                       withTextAlignment:(NSTextAlignment)tempTextAlignment 
                           withTextColor:(UIColor *)tempTextColor
{
    return [self createLabelWithAttributeText:tempText
                            withTextAlignment:tempTextAlignment 
                              withCustomFrame:CGRectMake(0,0,CGFLOAT_MAX,_viewHeight) 
                                withTextColor:tempTextColor];
}

// 3.2.3
-(UILabel *)createLabelWithAttributeText:(NSMutableAttributedString *)tempText 
                       withTextAlignment:(NSTextAlignment)tempTextAlignment 
                          withLineHeight:(CGFloat)tempLineHeight  
                           withTextColor:(UIColor *)tempTextColor
{
    return [self createLabelWithAttributeText:tempText 
                            withTextAlignment:tempTextAlignment 
                               withLineHeight:tempLineHeight 
                              withCustomFrame:CGRectMake(0,0,CGFLOAT_MAX,_viewHeight) 
                                withTextColor:tempTextColor];
}

// 3.3.1
-(UILabel *)createLabelWithText:(NSString *)tempText 
              withTextAlignment:(NSTextAlignment)tempTextAlignment 
                  withIsTemplet:(BOOL)tempIsTemplet
{
    return [self createLabelWithText:tempText 
                   withTextAlignment:tempTextAlignment 
                       withTextColor:_labelTextColor
                       withIsTemplet:tempIsTemplet];
}

// 3.3.1
-(UILabel *)createLabelWithText:(NSString *)tempText 
              withTextAlignment:(NSTextAlignment)tempTextAlignment 
                  withIsTemplet:(BOOL)tempIsTemplet 
           withIsNeedAutoResize:(BOOL)isNeedAutoResize
{
    return [self createLabelWithText:tempText 
                   withTextAlignment:tempTextAlignment 
                       withTextColor:_labelTextColor
                       withIsTemplet:tempIsTemplet];
}

// 3.3.2
-(UILabel *)createLabelWithAttributeText:(NSMutableAttributedString *)tempText 
                       withTextAlignment:(NSTextAlignment)tempTextAlignment 
                           withIsTemplet:(BOOL)tempIsTemplet
{
    return [self createLabelWithAttributeText:tempText 
                            withTextAlignment:tempTextAlignment 
                                withTextColor:_labelTextColor 
                                withIsTemplet:tempIsTemplet];
}

// 3.3.3
-(UILabel *)createLabelWithAttributeText:(NSMutableAttributedString *)tempText 
                       withTextAlignment:(NSTextAlignment)tempTextAlignment 
                          withLineHeight:(CGFloat)tempLineHeight 
                           withIsTemplet:(BOOL)tempIsTemplet
{
    return [self createLabelWithAttributeText:tempText 
                            withTextAlignment:tempTextAlignment 
                               withLineHeight:tempLineHeight 
                                withTextColor:_labelTextColor 
                                withIsTemplet:tempIsTemplet];
}

// 3.4.1
-(UILabel *)createLabelWithText:(NSString *)tempText 
              withTextAlignment:(NSTextAlignment)tempTextAlignment 
                  withTextColor:(UIColor *)tempTextColor 
                  withIsTemplet:(BOOL)tempIsTemplet
{
    if ( tempIsTemplet == YES ) {
        CGSize tempSize = [ViewTools getTextSizeWithWidth:CGFLOAT_MAX 
                                                 withText:tempText 
                                                 withFont:_textFont];
        CGFloat tempHeight = _viewHeight;
        if ( tempSize.width > [UIScreen mainScreen].bounds.size.width - D_ViewTools_Label_Left_Margin*2 ) {
            // 改成限制寬度來計算高度
            tempSize = [ViewTools getTextSizeWithWidth:([UIScreen mainScreen].bounds.size.width - D_ViewTools_Label_Left_Margin*2) 
                                              withText:tempText 
                                              withFont:_textFont];
            tempHeight = tempSize.height;
        }
        return [self createLabelWithText:tempText 
                       withTextAlignment:tempTextAlignment 
                         withCustomFrame:CGRectMake(D_ViewTools_Label_Left_Margin, 
                                                    0, 
                                                    [UIScreen mainScreen].bounds.size.width - D_ViewTools_Label_Left_Margin*2,
                                                    tempHeight) 
                           withTextColor:tempTextColor 
                    withIsNeedAutoResize:NO];
    }
    else{
        return [self createLabelWithText:tempText
                       withTextAlignment:tempTextAlignment];
    }
}

// 3.4.2
-(UILabel *)createLabelWithAttributeText:(NSMutableAttributedString *)tempText 
                       withTextAlignment:(NSTextAlignment)tempTextAlignment 
                           withTextColor:(UIColor *)tempTextColor 
                           withIsTemplet:(BOOL)tempIsTemplet
{
    if ( tempIsTemplet == YES ) {
        return [self createLabelWithAttributeText:tempText 
                                withTextAlignment:tempTextAlignment 
                                  withCustomFrame:CGRectMake(D_ViewTools_Label_Left_Margin,
                                                             0,
                                                             [UIScreen mainScreen].bounds.size.width - D_ViewTools_Label_Left_Margin*2,
                                                             CGFLOAT_MAX) 
                                    withTextColor:tempTextColor];
    }
    else{
        return [self createLabelWithAttributeText:tempText 
                                withTextAlignment:tempTextAlignment];
    }
}

// 3.4.3
-(UILabel *)createLabelWithAttributeText:(NSMutableAttributedString *)tempText 
                       withTextAlignment:(NSTextAlignment)tempTextAlignment 
                          withLineHeight:(CGFloat)tempLineHeight 
                           withTextColor:(UIColor *)tempTextColor 
                           withIsTemplet:(BOOL)tempIsTemplet
{
    if ( tempIsTemplet == YES ) {
        return [self createLabelWithAttributeText:tempText 
                                withTextAlignment:tempTextAlignment 
                                   withLineHeight:tempLineHeight 
                            withStaticCustomFrame:CGRectMake(D_ViewTools_Label_Left_Margin,
                                                             0,
                                                             [UIScreen mainScreen].bounds.size.width - D_ViewTools_Label_Left_Margin*2,
                                                             CGFLOAT_MAX) 
                                    withTextColor:tempTextColor];
    }
    else{
        return [self createLabelWithAttributeText:tempText 
                                   withLineHeight:tempLineHeight 
                                withTextAlignment:tempTextAlignment];
    }
}

// 3.5.1
-(UILabel *)createLabelWithText:(NSString *)tempText 
              withTextAlignment:(NSTextAlignment)tempTextAlignment 
                withCustomWidth:(float)tempCustomWidth
{
    return [self createLabelWithText:tempText 
                   withTextAlignment:tempTextAlignment  
                       withTextColor:_labelTextColor
                     withCustomWidth:tempCustomWidth];
}

// 3.5.2
-(UILabel *)createLabelWithAttributeText:(NSMutableAttributedString *)tempText 
                       withTextAlignment:(NSTextAlignment)tempTextAlignment 
                         withCustomWidth:(float)tempCustomWidth
{
    return [self createLabelWithAttributeText:tempText 
                            withTextAlignment:tempTextAlignment 
                                withTextColor:_labelTextColor 
                              withCustomWidth:tempCustomWidth];
}

/**
 * @brief - 3.5.3 設定 UILabel 文字元件（給設定的寬度）
 */
-(UILabel *)createLabelWithAttributeText:(NSMutableAttributedString *)tempText 
                       withTextAlignment:(NSTextAlignment)tempTextAlignment 
                          withLineHeight:(CGFloat)tempLineHeight 
                         withCustomWidth:(float)tempCustomWidth
{
    return [self createLabelWithAttributeText:tempText 
                            withTextAlignment:tempTextAlignment 
                               withLineHeight:tempLineHeight 
                                withTextColor:_labelTextColor 
                              withCustomWidth:tempCustomWidth];
}

// 3.6.1
-(UILabel *)createLabelWithText:(NSString *)tempText 
              withTextAlignment:(NSTextAlignment)tempTextAlignment  
                  withTextColor:(UIColor *)tempTextColor
                withCustomWidth:(float)tempCustomWidth
{
    CGSize tempSize = [ViewTools getTextSizeWithWidth:tempCustomWidth 
                                             withText:tempText 
                                             withFont:_textFont];
    if ( tempSize.height > _viewHeight ) {
        return [self createLabelWithText:tempText 
                       withTextAlignment:tempTextAlignment 
                         withCustomFrame:CGRectMake(0, 0, tempCustomWidth, tempSize.height)
                           withTextColor:tempTextColor];
    }
    else{
        return [self createLabelWithText:tempText 
                       withTextAlignment:tempTextAlignment 
                         withCustomFrame:CGRectMake(0, 0, tempCustomWidth, _viewHeight)
                           withTextColor:tempTextColor];
    }
}

// 3.6.2
-(UILabel *)createLabelWithAttributeText:(NSMutableAttributedString *)tempText 
                       withTextAlignment:(NSTextAlignment)tempTextAlignment 
                           withTextColor:(UIColor *)tempTextColor 
                         withCustomWidth:(float)tempCustomWidth
{
    return [self createLabelWithAttributeText:tempText 
                            withTextAlignment:tempTextAlignment 
                              withCustomFrame:CGRectMake(0, 0, tempCustomWidth, CGFLOAT_MAX) 
                                withTextColor:tempTextColor];
}

//3.6.3 設定 UILabel 文字元件（給設定的寬度）
-(UILabel *)createLabelWithAttributeText:(NSMutableAttributedString *)tempText 
                       withTextAlignment:(NSTextAlignment)tempTextAlignment 
                          withLineHeight:(CGFloat)tempLineHeight  
                           withTextColor:(UIColor *)tempTextColor 
                         withCustomWidth:(float)tempCustomWidth
{
    return [self createLabelWithAttributeText:tempText 
                            withTextAlignment:tempTextAlignment 
                               withLineHeight:tempLineHeight 
                              withCustomFrame:CGRectMake(0, 0, tempCustomWidth, CGFLOAT_MAX)  
                                withTextColor:tempTextColor];
}

// 3.7.1 給定設定的 Frame
-(UILabel *)createLabelWithText:(NSString *)tempText 
              withTextAlignment:(NSTextAlignment)tempTextAlignment 
                withCustomFrame:(CGRect)tempFrame
                  withTextColor:(UIColor *)tempTextColor
{
    return [self createLabelWithText:tempText 
                   withTextAlignment:tempTextAlignment 
                     withCustomFrame:tempFrame
                       withTextColor:tempTextColor 
                withIsNeedAutoResize:YES];
}

// 3.7.2 給定設定的 Frame
-(UILabel *)createLabelWithAttributeText:(NSMutableAttributedString *)tempText 
                       withTextAlignment:(NSTextAlignment)tempTextAlignment 
                         withCustomFrame:(CGRect)tempFrame 
                           withTextColor:(UIColor *)tempTextColor
{
    return [self createLabelWithAttributeText:tempText 
                            withTextAlignment:tempTextAlignment 
                               withLineHeight:1.0f 
                              withCustomFrame:tempFrame 
                                withTextColor:tempTextColor];
}

// 3.7.3 給定設定的 Frame
-(UILabel *)createLabelWithAttributeText:(NSMutableAttributedString *)tempText 
                       withTextAlignment:(NSTextAlignment)tempTextAlignment 
                          withLineHeight:(CGFloat)tempLineHeight
                         withCustomFrame:(CGRect)tempFrame 
                           withTextColor:(UIColor *)tempTextColor
{
    UILabel *label = [[UILabel alloc] initWithFrame:tempFrame];
    // 加入 Center
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineHeightMultiple:tempLineHeight];
    [paragraphStyle setAlignment:tempTextAlignment];
    [tempText addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [tempText.string length])];
    [tempText addAttribute:NSFontAttributeName value:_textFont range:NSMakeRange(0, tempText.length)];
    [label setTextColor:tempTextColor];
    label.numberOfLines = 0;
    [label setAttributedText:tempText];
    CGSize tempSize = [label sizeThatFits:CGSizeMake(tempFrame.size.width, tempFrame.size.height)];
    [label setFrame:CGRectMake(label.frame.origin.x, label.frame.origin.y, tempSize.width, tempSize.height)];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    // 將元件陣列暫時存入 recentObjects
    _recentObjects = nil;
    _recentObjects = @[label];
    
    return label;
}

// 3.7.4 不理會重算大小，給固定設定的 Frame（待修正，如果 frame 的寬高設定太小有可能字不夠放進來）
-(UILabel *)createLabelWithAttributeText:(NSMutableAttributedString *)tempText 
                       withTextAlignment:(NSTextAlignment)tempTextAlignment 
                          withLineHeight:(CGFloat)tempLineHeight 
                   withStaticCustomFrame:(CGRect)tempFrame 
                           withTextColor:(UIColor *)tempTextColor
{
    UILabel *label = [[UILabel alloc] initWithFrame:tempFrame];
    // 加入 Center
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setAlignment:tempTextAlignment];
    [paragraphStyle setLineHeightMultiple:tempLineHeight];
    [tempText addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [tempText.string length])];
    [label setFont:_textFont];
    [label setTextColor:tempTextColor];
    label.numberOfLines = 0;
    [label setAttributedText:tempText];
    CGSize tempSize = [label sizeThatFits:CGSizeMake(tempFrame.size.width, tempFrame.size.height)];
    [label setFrame:CGRectMake(label.frame.origin.x, label.frame.origin.y, tempFrame.size.width , tempSize.height)];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    // 將元件陣列暫時存入 recentObjects
    _recentObjects = nil;
    _recentObjects = @[label];
    
    return label;
}

// 3.8.1 給定設定的 Frame
-(UILabel *)createLabelWithText:(NSString *)tempText 
              withTextAlignment:(NSTextAlignment)tempTextAlignment 
                withCustomFrame:(CGRect)tempFrame
                  withTextColor:(UIColor *)tempTextColor 
           withIsNeedAutoResize:(BOOL)needAutoResize
{
    UILabel *label = [[UILabel alloc] initWithFrame:tempFrame];
    [label setTextAlignment:tempTextAlignment];
    [label setText:tempText];
    [label setFont:_textFont];
    [label setTextColor:tempTextColor];
    [label setNumberOfLines:0];
    if ( needAutoResize ) {
        label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
    }
    else{
        label.autoresizingMask = UIViewAutoresizingNone;
    }
    
    // 將元件陣列暫時存入 recentObjects
    _recentObjects = nil;
    _recentObjects = @[label];
    
#ifdef D_DEBUG
    [label setBackgroundColor:[UIColor lightGrayColor]];
#endif
    
    return label;
}

#pragma mark - 建立 TextField
/**
 * @brief - 4.1 設定 UITextField 文字輸入元件
 */
-(UIView *)createTextFieldWithText:(NSString *)tempText 
                     withInnerText:(NSString *)tempInnerText 
                 withTextAlignment:(NSTextAlignment)tempTextAlignment
{
    return [self createTextFieldWithText:tempText 
                           withInnerText:tempInnerText 
                       withTextAlignment:tempTextAlignment 
                         withCustomWidth:[UIScreen mainScreen].bounds.size.width 
                    withIsNeedAutoResize:YES];
}

/**
 * @brief - 4.2 設定 UITextField 文字輸入元件（給設定的寬度）
 */
-(UIView *)createTextFieldWithText:(NSString *)tempText 
                     withInnerText:(NSString *)tempInnerText 
                 withTextAlignment:(NSTextAlignment)tempTextAlignment 
                   withCustomWidth:(float)tempCustomWidth
{
    return [self createTextFieldWithText:tempText 
                           withInnerText:tempInnerText 
                       withTextAlignment:tempTextAlignment 
                         withCustomWidth:tempCustomWidth 
                    withIsNeedAutoResize:NO];
}

/**
 * @brief - 4.3 設定 UITextField 文字輸入元件（給設定的寬度）
 */
-(UIView *)createTextFieldWithText:(NSString *)tempText 
                     withInnerText:(NSString *)tempInnerText 
                 withTextAlignment:(NSTextAlignment)tempTextAlignment 
                   withCustomWidth:(float)tempCustomWidth 
              withIsNeedAutoResize:(BOOL)isNeedAutoResize
{
    // 回傳的總 View 容器
    UIView *allView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tempCustomWidth, _viewHeight)];
    if ( isNeedAutoResize ) {
        allView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    }
    else{
        allView.autoresizingMask = UIViewAutoresizingNone;
    }
    
    // 底圖
    UIImageView *inputView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 
                                                                           tempCustomWidth,
                                                                           _viewHeight)];
    inputView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [inputView setImage:[_textFieldImage 
                         resizableImageWithCapInsets:UIEdgeInsetsMake( 10, 10, 10, 10) 
                         resizingMode:UIImageResizingModeStretch]];
    [allView addSubview:inputView];
    
    // TextField
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(10,
                                                                           0,
                                                                           tempCustomWidth - 20,
                                                                           _viewHeight)];
    textField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [textField setTextAlignment:tempTextAlignment];
    [textField setFont:_textFont];
    [textField setTextColor:_textFieldTextColor];
    
    if ( tempText ) {
        [textField setText:tempText];
    }
    
    if ( tempInnerText ) {
        textField.attributedPlaceholder = [[NSAttributedString alloc] 
                                           initWithString:tempInnerText
                                           attributes:@{NSForegroundColorAttributeName:_textFieldInnerColor}];
    }
    else{
        [textField setPlaceholder:@""];
    }
    [allView addSubview:textField];
    
    // 將元件陣列暫時存入 recentObjects
    _recentObjects = nil;
    _recentObjects = @[textField];
    
    return allView;
}

#pragma mark - 其他工具
// 求一般 NSString 的 frame
+(CGSize)getTextSizeWithWidth:(float)tempWidth 
                     withText:(NSString *)tempText 
                     withFont:(UIFont *)tempFont
{
    return ([tempText boundingRectWithSize:CGSizeMake(tempWidth, CGFLOAT_MAX) 
                                   options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                attributes:@{NSFontAttributeName:tempFont} 
                                   context:nil].size);
}

+(CGSize)getTextSizeWithWidth:(float)tempWidth 
            withAttributeText:(NSAttributedString *)tempText 
                     withFont:(UIFont *)tempFont
{
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)tempText);
    CGSize targetSize = CGSizeMake(tempWidth, CGFLOAT_MAX);
    CGSize fitSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, [tempText length]), NULL, targetSize, NULL);
    CFRelease(framesetter);
    return fitSize;
}


#if 1
+(UIImage *)getImageFromeBundleByPath:(NSString *)tempPath{
    return [ViewTools getImageFromeFullPath:[NSString stringWithFormat: @"%@/%@", [NSBundle mainBundle].bundlePath, tempPath] 
                                   withType:EnumImageType_Png];
}

+(UIImage *)getImageFromeFullPath:(NSString *)tempFullPath withType:(EnumImageType)tempImageType{
    NSString *fullPath;
    switch (tempImageType)
    {
        case EnumImageType_None:
        {
            fullPath = [tempFullPath stringByAppendingString:@""];
        }
            break;
        case EnumImageType_Png:
        {
            fullPath = [tempFullPath stringByAppendingString:@".png"];
        }
            break;
        case EnumImageType_Gif:
        {
            fullPath = [tempFullPath stringByAppendingString:@".gif"];
        }
            break;
        case EnumImageType_Jpg:
        {
            fullPath = [tempFullPath stringByAppendingString:@".jpg"];
        }
            break;
        default:
            break;
    }
    
    
    
    UIImage *cachedImage;
    
#ifdef D_AFNetworking
    NSURL *localUrl = [NSURL URLWithString:fullPath];
    
    // 是否已存在 AFNetworking 的 cache 中
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: localUrl];
    
    [request addValue: @"image/*" forHTTPHeaderField: @"Accept"];
    
    cachedImage = [[UIImageView sharedImageCache] cachedImageForRequest: request];
#endif
    
    if (nil == cachedImage)
    {
        cachedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
        
#ifdef D_AFNetworking
        [[UIImageView sharedImageCache] cacheImage:cachedImage forRequest:request];
#endif
        if(nil == cachedImage)
        {
            NSLog(@"\n\n*****\n Class: %@ , File \"%@\" not exist!!\n*****\n\n", self, fullPath);
        }
    }
    
    return cachedImage;
}
#endif

+ (NSInteger)numberOfCharactersThatFitLabelWithText:(NSString *)tempText withFont:(UIFont *)tempFont withSize:(CGSize)tempSize{
    
    // Create an 'CTFramesetterRef' from an attributed string
    CTFontRef fontRef = CTFontCreateWithName((CFStringRef)tempFont.fontName, tempFont.pointSize, NULL);
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:(__bridge id)fontRef forKey:(id)kCTFontAttributeName];
    CFRelease(fontRef);
    NSAttributedString *attributedString  = [[NSAttributedString alloc] initWithString:tempText attributes:attributes];
    CTFramesetterRef frameSetterRef = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attributedString);
    
    // Get a suggested character count that would fit the attributed string
    CFRange characterFitRange;
    CGSize tempSize2 = CGSizeMake(tempSize.width + 3, tempSize.height + 3);
    CTFramesetterSuggestFrameSizeWithConstraints(frameSetterRef, CFRangeMake(0,0), NULL, tempSize2 , &characterFitRange);
    CFRelease(frameSetterRef);
    return (NSInteger)characterFitRange.length;
}

//+ (NSString *)actuallyRenderedText:(NSString *)tempText withFrame:(CGRect)tempFrame{
//    CTFontRef fontRef = CTFontCreateWithName((CFStringRef)[UIFont systemFontOfSize:13.0f].fontName, [UIFont systemFontOfSize:13.0f].pointSize, NULL);
//    NSDictionary *attributes = [NSDictionary dictionaryWithObject:(__bridge id)fontRef forKey:(id)kCTFontAttributeName];
//    CFRelease(fontRef);
//
//    NSAttributedString *attributedString  = [[NSAttributedString alloc] initWithString:tempText attributes:attributes];
//    CTFramesetterRef frameSetterRef = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attributedString);
//    CFRange actuallyRenderedRange = CTFrameGetVisibleStringRange(tempFrame);
//    NSString *actuallyRenderedText = [attributedString.string substringWithRange:NSMakeRange(actuallyRenderedRange.location, actuallyRenderedRange.length)];
//}

+ (NSArray *)revertArray:(NSArray *)tempOriginalArray{
    NSMutableArray *newArray = [[NSMutableArray alloc] init];
    /* 反轉陣列的方法（目前沒用到，但留著做記錄，未來可能會用到） */
    NSEnumerator *enumerator = [tempOriginalArray reverseObjectEnumerator];
    for ( id unit in enumerator ) {
        [newArray addObject:unit];
    }
    return newArray;
}

#pragma mark - Private Methods
-(UIButton *)getBasicButtonWithFrame:(CGRect)tempCustomFrame{
    UIButton *button = [[UIButton alloc] initWithFrame:tempCustomFrame];
    [button setImageEdgeInsets:UIEdgeInsetsMake(2, 5, 2, 5)];
    [button setBackgroundImage:[_buttonImage_Normal 
                                resizableImageWithCapInsets:UIEdgeInsetsMake( 10, 10, 10, 10) 
                                resizingMode:UIImageResizingModeStretch] 
                      forState:(UIControlStateNormal)];
    [button setBackgroundImage:[_buttonImage_HightLight  
                                resizableImageWithCapInsets:UIEdgeInsetsMake( 10, 10, 10, 10) 
                                resizingMode:UIImageResizingModeStretch] 
                      forState:(UIControlStateHighlighted)];
    [button setBackgroundImage:[_buttonImage_Disable  
                                resizableImageWithCapInsets:UIEdgeInsetsMake( 10, 10, 10, 10) 
                                resizingMode:UIImageResizingModeStretch] 
                      forState:(UIControlStateDisabled)];
    return button;
}

@end
