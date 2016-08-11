//
//  RWViewController_Test.m
//  UIControlDevApp
//
//  Created by Coody on 2016/7/13.
//  Copyright © 2016年 Coody. All rights reserved.
//

#import "RWViewController_Test.h"

#import <RWUIControls/RWUIControls.h>

@interface RWViewController_Test ()

@end

@implementation RWViewController_Test

-(instancetype)init{
    self = [super init];
    if ( self ) {
        [self.view setBackgroundColor:[UIColor lightGrayColor]];
        ViewTools *test = [[ViewTools alloc] init];
        [test setTextButtonColor:[UIColor blackColor]];
        
        UIButton *button = [test createButtonWithTextAndMargin:@"測試"];
        ContainerView *container = [[ContainerView alloc] init];
        [container setTopMargin:40.0f];
        container.isVertical = YES;
        [container addUnits:@[button]];
        [button addTarget:self action:@selector(pressed) forControlEvents:(UIControlEventTouchUpInside)];
        
        [self.view addSubview:container];
    }
    return self;
}

-(void)pressed{
    NSLog(@"test");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
