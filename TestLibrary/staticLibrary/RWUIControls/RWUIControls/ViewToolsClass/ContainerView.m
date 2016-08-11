//
//  ContainerView.m
//  ViewToolsProject
//
//  Created by Coody on 2016/8/5.
//  Copyright © 2016年 Coody. All rights reserved.
//

#import "ContainerView.h"
#import "ContainerViewConstant.h"

#pragma mark - 裝元件的容器（左->右來安裝）
@interface ContainerView()
@property (assign , nonatomic) CGFloat containerViewHight;
@end

@implementation ContainerView

-(id)init{
    self = [super init];
    if ( self ) {
        _isVertical = NO;
        _isRevertArrangement = NO;
        _isAutoFitWidth = NO;
        _isAutoFitHeight = NO;
        _isIgnoreY = NO;
        _isSeparateAllUnit = NO;
        _leftMargin = 0.0f;
        _rightMargin = 0.0f;
        _middleMargin = 0.0f;
        _topMargin = 0.0f;
        _bottomMargin = 0.0f;
        _containerViewHight = D_ContainerView_ViewHeight;
        _bg = [[UIImageView alloc] init];
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,_containerViewHight);
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    }
    return self;
}

-(void)dealloc{
    for ( UIView *unit in self.subviews ) {
        [unit removeFromSuperview];
    }
}

/** 
 * @brief   - 設定容器的高度
 * @details - 
 */
-(void)setContainerViewHight:(CGFloat)tempHight
{
    if( tempHight < 0 ){
        tempHight = 0;
    }
    _containerViewHight = tempHight;
    self.frame = CGRectMake(self.frame.origin.x,
                            self.frame.origin.y,
                            self.frame.size.width,
                            _containerViewHight);
    [_bg setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}

/** 
 * @brief   - 設定容器的寬度
 * @details - 
 */
-(void)setContainerViewWidth:(CGFloat)tempWidth
{
    if( tempWidth < 0 ){
        tempWidth = 0;
    }
    self.frame = CGRectMake(self.frame.origin.x,
                            self.frame.origin.y,
                            tempWidth ,
                            self.frame.size.height);
    [_bg setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}

-(void)setIsAutoFitWidth:(BOOL)isAutoFitWidth{
    _isAutoFitWidth = isAutoFitWidth;
    
    if ( _isAutoFitWidth == YES && _isVertical == NO && [self.subviews count] > 0) {
        // 重新計算寬度來適配
        CGFloat newWidth = 0;
        UIView *latestView = [self.subviews lastObject];
        newWidth = newWidth + latestView.frame.origin.x + latestView.frame.size.width + _rightMargin;
        if ( self.frame.size.width < newWidth ) {
            [self setContainerViewWidth:newWidth];
        }
    }
}

-(void)setIsIgnoreY:(BOOL)isIgnoreY{
    _isIgnoreY = isIgnoreY;
}

-(void)setIsSeparateAllUnit:(BOOL)isSeparateAllUnit{
    _isSeparateAllUnit = isSeparateAllUnit;
    if ( _isSeparateAllUnit == YES && (_isVertical == NO) ) {
        [self recheckInnerView];
    }
}

-(void)setIsAutoFitHeight:(BOOL)isAutoFitHeight{
    _isAutoFitHeight = isAutoFitHeight;
    
    if ( _isAutoFitHeight == YES && _isVertical == YES && [self.subviews count] > 0 ) {
        [self recheckInnerView];
    }
}

/**
 * @brief - 設定背景圖片
 */
-(void)setBackgroundImage:(UIImage *)tempBGImage{
    if ( tempBGImage != nil ) {
        [_bg setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [_bg setImage:[tempBGImage resizableImageWithCapInsets:UIEdgeInsetsMake(5,5,5,5) 
                                                  resizingMode:UIImageResizingModeStretch]];
    }
}

/** 
 * @brief   - 設定元件內的左邊間距
 * @details - （可以不設定，則為預設值）
 */
-(void)setLeftMargin:(CGFloat)tempLeftMargin{
    _leftMargin = tempLeftMargin;
    if ( _rightMargin == 0.0f ) {
        _rightMargin = _leftMargin;
    }
}

/**
 * @brief   - 設定元件內的右邊間距
 * @details -（可以不設定，則為預設值；如果有設定左間距，右間距沒設定，會以左間距為主；如果左右都設定，則各自有各自的值）
 */
-(void)setRightMargin:(CGFloat)tempRightMargin;{
    _rightMargin = tempRightMargin;
}

/**
 * @brief   - 設定元件內的彼此之間的距離
 * @details -（可以不設定，則為預設值）
 */
-(void)setMiddleMargin:(CGFloat)tempMiddleMargin{
    _middleMargin = tempMiddleMargin;
}

/**
 * @brief - 加入上邊界間距
 */
-(void)setTopMargin:(CGFloat)tempTopMargin{
    _topMargin = tempTopMargin;
}

/**
 * @brief - 加入下邊界間距（暫時想不出比較好的適配方式）
 */
-(void)setBottomMargin:(CGFloat)tempBottomMargin{
    _bottomMargin = tempBottomMargin;
}

-(void)addUnits:(NSArray *)tempViewArray{
    
    if ( _isSeparateAllUnit && (_isVertical == NO) && [tempViewArray count] >= 1) {
        CGFloat separateWidth = (CGFloat)((CGRectGetWidth(self.frame) - _leftMargin - _rightMargin - _middleMargin*([tempViewArray count] - 1))/[tempViewArray count]);
        for ( UIView *unit in tempViewArray ) {
            unit.frame = CGRectMake(unit.frame.origin.x,
                                    unit.frame.origin.y,
                                    separateWidth,
                                    CGRectGetHeight(unit.frame));
        }
    }
    
    /* 反轉陣列的方法 */
    if ( _isRevertArrangement ) {
        NSEnumerator *enumerator = [tempViewArray reverseObjectEnumerator];
        NSMutableArray *reverseArray = [[NSMutableArray alloc] init];
        for ( id unit in enumerator ) {
            [reverseArray addObject:unit];
        }
        tempViewArray = reverseArray;
    }
    
    // 優先加入背景
    [self addSubview:_bg];
    
    // 取得元件內最高的 Height 值，並且設置圍  Container View 的主要 Height
    _containerViewHight = self.frame.size.height;
    CGFloat realHeight = _containerViewHight;
    
    // 計算內部左右元件 x 的位置 
    CGFloat totalX = 0.0f;
    if ( [tempViewArray count] == 0 ) {
        NSLog(@" \n**** WARNING!!!! 沒有加入任何元件!!!! ****");
    }
    else{
        
        // isVertical == YES , 是否是上下加入元件？ 
        // isVertical == NO , 是否是左右加入元件？
        if ( _isVertical ) {
            // 計算內部上下元件 y 的位置 
            // 垂直擺放元件的方法，會利用
            CGFloat totalY = 0.0f;
            
            for ( UIView *unit in tempViewArray ) {
                if ( unit == [tempViewArray firstObject] ) {
                    CGFloat yValue = unit.frame.origin.y;
                    if ( _isIgnoreY ) {
                        yValue = 0.0f;
                    }
                    unit.frame = CGRectMake(unit.frame.origin.x,
                                            yValue + _topMargin,
                                            unit.frame.size.width,
                                            unit.frame.size.height);
                    totalY = unit.frame.origin.y + unit.frame.size.height;
                }
                else{
                    if ( unit == [tempViewArray lastObject] ) {
                        CGFloat yValue = unit.frame.origin.y;
                        if ( _isIgnoreY ) {
                            yValue = 0.0f;
                        }
                        if ( _isAutoFitHeight ) {
                            unit.frame = CGRectMake(unit.frame.origin.x,
                                                    yValue + _middleMargin + totalY,
                                                    unit.frame.size.width,
                                                    self.frame.size.height - (yValue + _middleMargin + totalY) - _bottomMargin );
                        }
                        else{
                            unit.frame = CGRectMake(unit.frame.origin.x,
                                                    yValue + _middleMargin + totalY,
                                                    unit.frame.size.width,
                                                    unit.frame.size.height);
                        }
                        
                        totalY = totalY + unit.frame.size.height + _middleMargin + _bottomMargin;
                    }
                    else{
                        CGFloat yValue = unit.frame.origin.y;
                        if ( _isIgnoreY ) {
                            yValue = 0.0f;
                        }
                        unit.frame = CGRectMake(unit.frame.origin.x,
                                                yValue + _middleMargin + totalY,
                                                unit.frame.size.width,
                                                unit.frame.size.height);
                        totalY = totalY + unit.frame.size.height + _middleMargin;
                    }
                }
                if ( totalY > realHeight ) {
                    realHeight = totalY;
                }
                [self addSubview:unit];
            }
        }
        else{
            
            if ( [tempViewArray count] == 1 ) {
                UIView *unit = [tempViewArray firstObject];
                CGFloat realWidth = self.frame.size.width;
                if ( _isAutoFitWidth ) {
                    if ( realWidth < unit.frame.size.width ) {
                        realWidth = unit.frame.size.width;
                    }
                }
                unit.frame = CGRectMake(_leftMargin ,
                                        unit.frame.origin.y + _topMargin,
                                        realWidth - _rightMargin - _leftMargin,
                                        unit.frame.size.height);
                if ( unit.frame.size.height + _topMargin + _bottomMargin > realHeight ) {
                    realHeight = unit.frame.size.height + _topMargin + _bottomMargin;
                }
                [self addSubview:unit];
            }
            else{
                for ( UIView *unit in tempViewArray ) {
                    if ( unit == [tempViewArray firstObject] ) {
                        if ( _isRevertArrangement ) {
                            CGFloat unitX = self.frame.size.width - unit.frame.origin.x - _rightMargin - unit.frame.size.width;
                            if ( unitX < 0 && (_isAutoFitWidth == NO) ) {
                                NSLog(@" \n!! Warning !!!! Warning !!\n ContainerView's \"WIDTH\" too small!! Please Check it!!!\n\n");
                                return;
                            }
                            unit.frame = CGRectMake(unitX,
                                                    unit.frame.origin.y + _topMargin,
                                                    unit.frame.size.width,
                                                    unit.frame.size.height);
                            totalX = unit.frame.origin.x;
                        }
                        else{
                            unit.frame = CGRectMake(unit.frame.origin.x + _leftMargin ,
                                                    unit.frame.origin.y + _topMargin,
                                                    unit.frame.size.width,
                                                    unit.frame.size.height);
                            totalX = unit.frame.origin.x + unit.frame.size.width;
                        }
                    }
                    else if( unit == [tempViewArray lastObject] ){
                        if ( _isRevertArrangement && (_isAutoFitWidth == NO) ) {
                            unit.frame = CGRectMake(_leftMargin ,
                                                    unit.frame.origin.y + _topMargin,
                                                    totalX - _leftMargin - _middleMargin ,
                                                    unit.frame.size.height);
                        }
                        else{
                            CGFloat checkWidth = self.frame.size.width - totalX - _middleMargin - _rightMargin;
                            if ( checkWidth <= 0 ) {
                                if ( _isAutoFitWidth ) {
                                    checkWidth = unit.frame.size.width; 
                                }
                                else{
                                    checkWidth = 0;
                                }
                            }
                            unit.frame = CGRectMake(unit.frame.origin.x + totalX + _middleMargin ,
                                                    unit.frame.origin.y + _topMargin,
                                                    checkWidth ,
                                                    unit.frame.size.height);
                            totalX = unit.frame.origin.x + unit.frame.size.width + _rightMargin;
                        }
                    }
                    else{
                        if ( _isRevertArrangement && (_isAutoFitWidth == NO) ) {
                            unit.frame = CGRectMake(totalX - _middleMargin - unit.frame.size.width ,
                                                    unit.frame.origin.y + _topMargin,
                                                    unit.frame.size.width,
                                                    unit.frame.size.height);
                            totalX = totalX - _middleMargin - unit.frame.size.width;
                        }
                        else{
                            unit.frame = CGRectMake(unit.frame.origin.x + totalX + _middleMargin ,
                                                    unit.frame.origin.y + _topMargin,
                                                    unit.frame.size.width,
                                                    unit.frame.size.height);
                            totalX = totalX + _middleMargin + unit.frame.size.width;
                        }
                    }
                    
                    // 改變高度
                    if ( unit.frame.size.height + _topMargin + _bottomMargin > realHeight ) {
                        realHeight = unit.frame.size.height + _topMargin + _bottomMargin;
                    }
                    [self addSubview:unit];
                    
                    // 改變寬度
                    if ( _isAutoFitWidth && _isRevertArrangement == NO ) {
                        if ( totalX > self.frame.size.width ) {
                            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, totalX, self.frame.size.height);
                        }
                    }
                }
            }
        }
    }
    [self setContainerViewHight:realHeight];
    self.isAutoFitWidth = _isAutoFitWidth;
}

-(void)removeAllUnits{
    for ( UIView *unit in self.subviews ) {
        if ( unit != _bg ) {
            [unit removeFromSuperview];
        }
    }
}

-(void)setIsRevertArrangement:(BOOL)isRevertArrangement{
    if ( _isRevertArrangement != isRevertArrangement ) {
        _isRevertArrangement = isRevertArrangement;
        if ( [self.subviews count] > 0 ) {
            NSArray *unitArray = self.subviews;
            for ( UIView *unit in unitArray ) {
                [unit removeFromSuperview];
            }
            [self addUnits:unitArray];
        }
    }
}


-(void)recheckInnerView{
    
    if ( _isVertical ) {
        // 計算內部上下元件 y 的位置 
        // 垂直擺放元件的方法，會利用
        CGFloat realHeight = _containerViewHight;
        CGFloat totalY = 0.0f;
        NSArray *totalViewArray = self.subviews;
        NSMutableArray *tempViewArray = [[NSMutableArray alloc] init];
        for ( UIView *unit in totalViewArray ) {
            if ( unit != _bg ) {
                [tempViewArray addObject:unit];
            }
        }
        
        for ( UIView *unit in tempViewArray ) {
            
            if ( unit == [tempViewArray firstObject] ) {
                unit.frame = CGRectMake(unit.frame.origin.x,
                                        _topMargin,
                                        unit.frame.size.width,
                                        unit.frame.size.height);
                totalY = unit.frame.origin.y + unit.frame.size.height;
            }
            else{
                if ( unit == [tempViewArray lastObject] ) {
                    if ( _isAutoFitHeight ) {
                        unit.frame = CGRectMake(unit.frame.origin.x,
                                                _middleMargin + totalY,
                                                unit.frame.size.width,
                                                self.frame.size.height - (unit.frame.origin.y + _middleMargin + totalY) - _bottomMargin );
                    }
                    else{
                        unit.frame = CGRectMake(unit.frame.origin.x,
                                                _middleMargin + totalY,
                                                unit.frame.size.width,
                                                unit.frame.size.height);
                    }
                    
                    totalY = totalY + unit.frame.size.height + _middleMargin + _bottomMargin;
                }
                else{
                    unit.frame = CGRectMake(unit.frame.origin.x,
                                            _middleMargin + totalY,
                                            unit.frame.size.width,
                                            unit.frame.size.height);
                    totalY = totalY + unit.frame.size.height + _middleMargin;
                }
            }
            if ( totalY > realHeight ) {
                realHeight = totalY;
            }
        }
    }
    else{
        
        /* 反轉陣列的方法（目前沒用到，但留著做記錄，未來可能會用到） */
        NSArray *totalViewArray = self.subviews;
        NSMutableArray *tempViewArray = [[NSMutableArray alloc] init];
        for ( UIView *unit in totalViewArray ) {
            if ( unit != _bg ) {
                [tempViewArray addObject:unit];
                unit.frame = CGRectMake(0 ,
                                        0,
                                        unit.frame.size.width,
                                        unit.frame.size.height);
                
            }
        }
        
        CGFloat separateWidth = 0;
        if ( _isSeparateAllUnit ) {
            separateWidth = (CGFloat)((CGRectGetWidth(self.frame) - _leftMargin - _rightMargin - _middleMargin*([tempViewArray count] - 1))/[tempViewArray count]);
        }
        
        if ( _isRevertArrangement ) {
            NSEnumerator *enumerator = [tempViewArray reverseObjectEnumerator];
            NSMutableArray *reverseArray = [[NSMutableArray alloc] init];
            for ( id unit in enumerator ) {
                [reverseArray addObject:unit];
            }
            tempViewArray = reverseArray;
        }
        
        // 取得元件內最高的 Height 值，並且設置圍  Container View 的主要 Height
        _containerViewHight = self.frame.size.height;
        CGFloat realHeight = _containerViewHight;
        
        // 計算內部左右元件 x 的位置 
        CGFloat totalX = 0.0f;
        if ( [tempViewArray count] == 0 ) {
            NSLog(@" \n**** WARNING!!!! 沒有加入任何元件!!!! ****");
        }
        else if ( [tempViewArray count] == 1 ) {
            UIView *unit = [tempViewArray firstObject];
            unit.frame = CGRectMake(_leftMargin ,
                                    unit.frame.origin.y,
                                    self.frame.size.width - _rightMargin - _leftMargin,
                                    unit.frame.size.height);
            if ( unit.frame.size.height + _topMargin + _bottomMargin > realHeight ) {
                realHeight = unit.frame.size.height + _topMargin + _bottomMargin;
            }
        }
        else{
            for ( UIView *unit in tempViewArray ) {
                
                if ( _isSeparateAllUnit ) {
                    unit.frame = CGRectMake(unit.frame.origin.x,
                                            unit.frame.origin.y,
                                            separateWidth,
                                            CGRectGetHeight(unit.frame));
                }
                
                if ( unit == [tempViewArray firstObject] ) {
                    if ( _isRevertArrangement ) {
                        CGFloat unitX = self.frame.size.width - unit.frame.origin.x - _rightMargin - unit.frame.size.width;
                        if ( unitX < 0 && (_isAutoFitWidth == NO) ) {
                            NSLog(@" \n!! Warning !!!! Warning !!\n ContainerView's \"WIDTH\" too small!! Please Check it!!!\n\n");
                            return;
                        }
                        unit.frame = CGRectMake(unitX,
                                                unit.frame.origin.y + _topMargin,
                                                unit.frame.size.width,
                                                unit.frame.size.height);
                        totalX = unit.frame.origin.x;
                    }
                    else{
                        unit.frame = CGRectMake(unit.frame.origin.x + _leftMargin ,
                                                unit.frame.origin.y + _topMargin,
                                                unit.frame.size.width,
                                                unit.frame.size.height);
                        totalX = unit.frame.origin.x + unit.frame.size.width;
                    }
                }
                else if( unit == [tempViewArray lastObject] ){
                    if ( _isRevertArrangement && (_isAutoFitWidth == NO) ) {
                        unit.frame = CGRectMake(_leftMargin ,
                                                unit.frame.origin.y + _topMargin,
                                                totalX - _leftMargin - _middleMargin ,
                                                unit.frame.size.height);
                    }
                    else{
                        CGFloat checkWidth = self.frame.size.width - totalX - _middleMargin - _rightMargin;
                        if ( checkWidth <= 0 ) {
                            if ( _isAutoFitWidth ) {
                                checkWidth = unit.frame.size.width; 
                            }
                            else{
                                checkWidth = 0;
                            }
                        }
                        unit.frame = CGRectMake(unit.frame.origin.x + totalX + _middleMargin ,
                                                unit.frame.origin.y + _topMargin,
                                                checkWidth ,
                                                unit.frame.size.height);
                        totalX = unit.frame.origin.x + unit.frame.size.width + _rightMargin;
                    }
                }
                else{
                    if ( _isRevertArrangement && (_isAutoFitWidth == NO) ) {
                        unit.frame = CGRectMake(totalX - _middleMargin - unit.frame.size.width ,
                                                unit.frame.origin.y + _topMargin,
                                                unit.frame.size.width,
                                                unit.frame.size.height);
                        totalX = totalX - _middleMargin - unit.frame.size.width;
                    }
                    else{
                        unit.frame = CGRectMake(unit.frame.origin.x + totalX + _middleMargin ,
                                                unit.frame.origin.y + _topMargin,
                                                unit.frame.size.width,
                                                unit.frame.size.height);
                        totalX = totalX + _middleMargin + unit.frame.size.width;
                    }
                }
                
                // 改變高度
                if ( unit.frame.size.height + _topMargin + _bottomMargin > realHeight ) {
                    realHeight = unit.frame.size.height + _topMargin + _bottomMargin;
                }
                // 改變寬度
                if ( _isAutoFitWidth && _isRevertArrangement == NO ) {
                    if ( totalX > self.frame.size.width ) {
                        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, totalX, self.frame.size.height);
                    }
                }
            }
        }
        [self setContainerViewHight:realHeight];
        self.isAutoFitWidth = _isAutoFitWidth;
    }
}

@end
