//
//  ContainerView.h
//  ViewToolsProject
//
//  Created by Coody on 2016/8/5.
//  Copyright © 2016年 Coody. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - 容器 View
@interface ContainerView : UIView

/** 容器最左邊間距（上下排的時候，會忽略） */
@property (readonly , nonatomic) CGFloat leftMargin;
/** 容器最右邊間距（上下排的時候，會忽略） */
@property (readonly , nonatomic) CGFloat rightMargin;
/** 容器中，元件與元件之間的中邊間距（上下排的時候，會忽略） */
@property (readonly , nonatomic) CGFloat middleMargin;
/** 容器最上面、與元件的間距 */
@property (readonly , nonatomic) CGFloat topMargin;
/** 容器最下面、與元件的間距 */
@property (readonly , nonatomic) CGFloat bottomMargin;
/** 容器背景圖片 */
@property (strong , nonatomic) UIImageView *bg;
/** 容器是否為上到下排列？（ YES:上下排列內部元件 NO:左右排列內部元件 ） */
@property (assign , nonatomic) BOOL isVertical;
/** 元件是否要從最右邊開始對齊，最左邊元件會自動伸縮左邊界？（上下排的時候，會忽略） */
@property (assign , nonatomic) BOOL isRevertArrangement;
/** 
 ContainerView 是否需要在寬度不足時，自行增加寬度？
 （ YES:會自行增加寬度（預設為 NO））（上下排、以及從後面排列到前面的時候，會忽略） 
 */
@property (assign , nonatomic) BOOL isAutoFitWidth;
/** 
 ContainerView 在上下排列時，最後一個元件會自動調整高度。
 （ YES:會自行增加高度（預設為 NO） （左右排會忽略））
 */
@property (assign , nonatomic) BOOL isAutoFitHeight;

/**
 ContainerView 預設會依照元件一開始的 Y 值來做初始排列，但如果是第二次加入元件，
 請要把 Frame 的 Y 值設定回原本你想要的距離，如果沒有設定，會依照目前的 Y 值做調整。
 
 所以如果要忽略 Y 值，請設定後，在使用 addUnit: 
 
 @warning - 如果使用 recheckInnerView 的方法，會直接忽略 Y 值來重新排列。
 */
@property (assign , nonatomic) BOOL isIgnoreY;

/**
 ContainerView 回自動將內部元件平均分布寬度
 
 @warning - isVertical 會無效 
 */
@property (assign , nonatomic) BOOL isSeparateAllUnit;

/** 
 * @brief   - 設定容器的高度
 * @details - 
 */
-(void)setContainerViewHight:(CGFloat)tempHight;

/** 
 * @brief   - 設定容器的寬度
 * @details - 
 */
-(void)setContainerViewWidth:(CGFloat)tempWidth;

/**
 * @brief - 設定背景圖片
 */
-(void)setBackgroundImage:(UIImage *)tempBGImage;

/** 
 * @brief   - 設定元件內的左邊間距
 * @details - （可以不設定，則為預設值）
 */
-(void)setLeftMargin:(CGFloat)tempLeftMargin;

/**
 * @brief   - 設定元件內的右邊間距
 * @details -（可以不設定，則為預設值；如果有設定左間距，右間距沒設定，會以左間距為主；如果左右都設定，則各自有各自的值）
 */
-(void)setRightMargin:(CGFloat)tempRightMargin;

/**
 * @brief   - 設定元件內的彼此之間的距離
 * @details -（可以不設定，則為預設值）
 */
-(void)setMiddleMargin:(CGFloat)tempMiddleMargin;

/**
 * @brief - 加入上邊界間距
 */
-(void)setTopMargin:(CGFloat)tempTopMargin;

/**
 * @brief - 加入下邊界間距
 */
-(void)setBottomMargin:(CGFloat)tempBottomMargin;

/**
 * @brief   - 加入隨意的元件
 * @details - 只要是 UIView 都可以加入，但是建議以 ViewTools 的建立元件為主。
 */
-(void)addUnits:(NSArray *)tempViewArray;

-(void)removeAllUnits;

/**
 * @brief - 設定要從左邊往右對齊，還是右邊往左對齊
 */
-(void)setIsRevertArrangement:(BOOL)isRevertArrangement;

/**
 * @brief - 重新確認內部位置（如果內部需要重新排列時）
 */
-(void)recheckInnerView;

@end
