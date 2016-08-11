//
//  ViewController.m
//  TestImportStaticLibrary_1
//
//  Created by Coody on 2016/7/5.
//  Copyright © 2016年 Coody. All rights reserved.
//

#import "ViewController.h"

#import "teatStaticLibrary_01.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    teatStaticLibrary_01 *test = [[teatStaticLibrary_01 alloc] init];
    [test showMsg];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
