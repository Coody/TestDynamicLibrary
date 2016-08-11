//
//  ViewController.m
//  MyDynamicFrameworkDemo
//
//  Created by Coody on 2016/8/10.
//  Copyright © 2016年 Coody. All rights reserved.
//

#import "ViewController.h"

@import TestDynamicFramework;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    MYObject *testObject = [[MYObject alloc] init];
    [testObject show];
    [MYObject showUseClassMethod];
    [testObject test2];
    [testObject test3];
    [testObject test4];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
