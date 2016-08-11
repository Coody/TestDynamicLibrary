//
//  ViewToolsConstant.h
//  Prime
//
//  Created by Coody on 2016/1/30.
//  Copyright © 2016年 Coody. All rights reserved.
//

#ifndef ViewToolsConstant_h
#define ViewToolsConstant_h

////////// 預設的畫面顯示設定（如果沒有特別要求的話，會吃的預設值）//////////
///////////////////////////////////////////////////////////////////
// 設定元件標準高度（可自行設定）
#define D_ViewTools_ViewHeight (40.0f)
// 設定元件與左邊畫面的距離
#define D_ViewTools_Label_Left_Margin (12)
#define D_ViewTools_Label_Middle_Margin (12)
#define D_ViewTools_Label_Right_Margin (12)
// 設定文字大小
#define D_ViewTools_Text_Font [UIFont boldSystemFontOfSize:16.0f]
// 設定文字顏色
#define D_ViewTools_Text_Color [UIColor whiteColor]
// 設定 TextField 內文字的顏色
#define D_ViewTools_TextField_Inner_Color [UIColor grayColor]
///////////////////////////////////////////////////////////////////
// 如果不需要設定請直接使用 nil 即可
// 設定 Image 的名稱（不帶 .png ）
#define D_ViewTools_Arrow_Image (@"RWUIControls.bundle/arrow")
// 設定紅色按鈕的 Image
#define D_ViewTools_Button_Red_Normal_Image (@"RWUIControls.bundle/red_btn")
#define D_ViewTools_Button_Red_HightLight_Image (@"")
// 設定一般類型按鈕的 Image 1
#define D_ViewTools_Button_Normal_Image (@"RWUIControls.bundle/gray_btn")
#define D_ViewTools_Button_HightLight_Image (@"")
#define D_ViewTools_Button_Disable_Image (@"")
// 設定輸入框類型的 Image
#define D_ViewTools_TextField_Image (@"RWUIControls.bundle/box_textField")
#define D_ViewTools_TextField_CancelButton_Image (@"")
///////////////////////////////////////////////////////////////////

#endif /* ViewToolsConstant_h */
