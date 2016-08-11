//
//  MYObject.m
//  TestDynamicFramework
//
//  Created by Coody on 2016/8/10.
//  Copyright © 2016年 Coody. All rights reserved.
//

#import "MYObject.h"

@implementation MYObject

-(void)show{
    NSLog(@"Show log in MYObject instance!");
}

-(void)test2{
    NSLog(@"Test 2!");
}

-(void)test3{
    NSLog(@"Test 3!");

}

-(void)test4{
    NSLog(@"Test 3!");
    
}

+(void)showUseClassMethod{
    NSLog(@"Show log in MYObject class method!");
}

@end
