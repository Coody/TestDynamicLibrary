//
//  ViewController.m
//  FrameworkDemo
//
//  Created by Coody on 2016/8/8.
//  Copyright © 2016年 Coody. All rights reserved.
//

#import "ViewController.h"

@class Person;

@interface ViewController ()
@property (nonatomic , strong) NSString *libPath;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    {
        UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 80)];
        [addButton setBackgroundColor:[UIColor grayColor]];
        addButton.center = self.view.center;
        [addButton addTarget:self action:@selector(pressed:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.view addSubview:addButton];
    }
    
    {
        UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 80)];
        [addButton setBackgroundColor:[UIColor grayColor]];
        addButton.center = self.view.center;
        addButton.frame = CGRectMake(addButton.frame.origin.x, addButton.frame.origin.y + 100, addButton.frame.size.width, addButton.frame.size.height);
        [addButton addTarget:self action:@selector(pressed2:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.view addSubview:addButton];
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)pressed:(id)sender{
//    NSString *documentsPath = [NSString stringWithFormat:@"%@/Documents/Dylib.framework/Dylib" , NSHomeDirectory()];
//    [self dlopenLoadDylibWithPath:documentsPath];
    
    
    NSString *documentsPath = [NSString stringWithFormat:@"%@/Documents/Dylib.framework",NSHomeDirectory()];
    [self bundleLoadDylibWithPath:documentsPath];
    
}

- (void)bundleLoadDylibWithPath:(NSString *)path
{
    _libPath = path;
    NSError *err = nil;
    NSBundle *bundle = [NSBundle bundleWithPath:path];
    if ([bundle loadAndReturnError:&err]) {
        NSLog(@"bundle load framework success.");
    } else {
        NSLog(@"bundle load framework err:%@",err);
    }
}



-(void)pressed2:(id)sender{
    Class rootClass = NSClassFromString(@"Person");
    if ( rootClass ) {
        id object = [[rootClass alloc] init];
        [(Person *)object run];
    }
}

@end
