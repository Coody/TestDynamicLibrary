//
//  ViewController.m
//  GMAppDemo
//
//  Created by WeiHan on 10/21/14.
//  Copyright (c) 2014 Wei Han. All rights reserved.
//

#import "ViewController.h"
#import "GMViewController.h"
#import "GMFrameworkLoader.h"

@interface ViewController ()
{
    NSMutableArray *dataSource;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *downloadButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [downloadButton setTitle:@"Download" forState:(UIControlStateNormal)];
    [downloadButton setFrame:CGRectMake(0, 0, 200, 100)];
    [downloadButton setCenter:CGPointMake(self.view.center.x, self.view.center.y - 200)];
    [downloadButton addTarget:self action:@selector(downloadButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:downloadButton];
    
    UIButton *presentVCButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [presentVCButton setTitle:@"Enter new view controller..." forState:UIControlStateNormal];
    [presentVCButton setFrame:CGRectMake(0, 0, 200, 100)];
    [presentVCButton setCenter:CGPointMake(downloadButton.center.x, downloadButton.center.y +100)];
    [presentVCButton addTarget:self action:@selector(presentVCButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:presentVCButton];
    
    UIButton *unloadBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [unloadBtn setTitle:@"Unload framework" forState:(UIControlStateNormal)];
    [unloadBtn setFrame:CGRectMake(0, 0, 200, 100)];
    [unloadBtn setCenter:CGPointMake(presentVCButton.center.x, presentVCButton.center.y + 100)];
    [unloadBtn addTarget:self action:@selector(unloadBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:unloadBtn];
    
    UIButton *listBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [listBtn setTitle:@"list classes" forState:(UIControlStateNormal)];
    [listBtn setFrame:CGRectMake(0, 0, 200, 100)];
    [listBtn setCenter:CGPointMake(unloadBtn.center.x, unloadBtn.center.y + 100)];
    [listBtn addTarget:self action:@selector(listBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:listBtn];
    
    dataSource = [[NSMutableArray alloc] init];
    for (int i = 0; i <= 10; i++) {
        [dataSource addObject:[NSString stringWithFormat:@"%d", i]];
    }
}

-(void)downloadButtonClick:(id)sender{
    
    NSString *strUrl = @"https://dl.dropbox.com/s/rnsq62emc5i24gq/GM.zip";
    //@"http://t1.qpic.cn/mblogpic/904bb91df74a345c3f2c/2000";
    //@"https://www.dropbox.com/s/5ptqnr0cyu70csw/git_history.txt";
    NSLog(@"Start to download file '%@'", strUrl);
    
    if ( [GMFrameworkLoader getFrameworkFromURL:strUrl] ){
        NSLog(@"Finished downloading file '%@'.", strUrl);
    }
    else{
        NSLog(@"Failed to download file '%@'", strUrl);
    }
}

- (void)presentVCButtonClick:(id)sender
{
    if ( [[GMFrameworkLoader sharedInstance] loadFramework] ) {
        
        GMViewController *gmVC = [[GMViewController alloc] initwithVCName:@"MyViewController" delegate:self];
        
        UINavigationController *navigationVC = [[UINavigationController alloc] initWithRootViewController:gmVC.destinationViewController];
        [self presentViewController:navigationVC animated:YES completion:nil];
    }
    else{
        NSLog(@"\n\n 載入 framework 失敗！！\n\n");
    }
}

-(void)unloadBtnClick:(id)sender{
    if ( [[GMFrameworkLoader sharedInstance] unloadFramework] ) {
        NSLog(@"Success: unload Success.....");
    }
    else{
        NSLog(@"Fail: unload fail!");
    }
}

-(void)listBtnClick:(id)sender{
    [GMFrameworkLoader listAllClass];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - GMDelegate

- (NSArray *)loadData:(NSError **)error
{
    return dataSource;
}

- (void)addNewObject:(NSObject *)newObj
{
    [dataSource addObject:newObj];
}



@end
