//
//  ViewController.m
//  ImageViewer
//
//  Created by Coody on 2016/8/3.
//  Copyright © 2016年 Coody. All rights reserved.
//

#import "ViewController.h"

#import <RWUIControls/RWUIControls.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    ContainerView *containerView = [[ContainerView alloc] init];
    [containerView setTopMargin:30.0f];
    [containerView setMiddleMargin:10.0f];
    containerView.isVertical = YES;
    
    ViewTools *viewTool = [[ViewTools alloc] init];
    [viewTool setLabelTextColor:[UIColor blackColor]];
    [viewTool setButtonTextColor:[UIColor blackColor]];
    UILabel *testLabel = [viewTool createLabelWithText:@"How to Use a Framework\nOkay, you have a framework, you have libraries and they’re elegant solutions for problems you’ve not yet encountered. But what’s the point of all this?\nOne of the primary advantages in using a framework is its simplicity in use. Now you’re going to create a simple iOS app that uses the RWUIControls.framework that you’ve just built.\nStart by creating a new project in Xcode. Choose File/New/Project and select iOS/Application/Single View Application. Call your new app ImageViewer; set it for iPhone only and save it in the same directory you’ve used for the previous two projects. This app will display an image and allow the user to change its rotation using a RWKnobControl." 
                                     withTextAlignment:(NSTextAlignmentLeft) 
                                         withIsTemplet:YES];
    UIButton *button = [viewTool createButtonWithTextAndMargin:@"YES"];
    
    [containerView addUnits:@[testLabel , button]];
    
    [self.view addSubview:containerView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
