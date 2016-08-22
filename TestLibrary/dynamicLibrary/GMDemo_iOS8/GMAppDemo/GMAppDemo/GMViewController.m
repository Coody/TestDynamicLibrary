//
//  GMViewController.m
//  GMAppDemo
//
//  Created by WeiHan on 10/22/14.
//  Copyright (c) 2014 Wei Han. All rights reserved.
//

#import "GMViewController.h"
#import "GMFrameworkLoader.h"
#import <objc/runtime.h>
#import <objc/message.h>

@interface GMViewController ()
{
    Class destGMViewControllerClass;
    UIViewController *destGMViewController;
}

@end

@implementation GMViewController


- (id)initwithVCName:(NSString *)vcName
            delegate:(id)delegate
{
//    if ([GMFrameworkLoader loadFrameworkWithCString:"/Users/hanwei/work/GMDemo/GMDylibDemo/OutFramework/GMDylibDemo.framework/GMDylibDemo"])
//    if ([GMFrameworkLoader loadFrameworkWithBundlePath:@"/Users/hanwei/work/GMDemo/GMDylibDemo/OutFramework/GMDylibDemo.framework"])
    
    // 改成由外面先 loadFramework
    [self loadDestinationClass];
    if (delegate){
        [self setDelegate:delegate];
    }
    return self;
    
//    if ([GMFrameworkLoader loadFramework])
//    {
//        [self loadDestinationClass];
//        if (delegate){
//            [self setDelegate:delegate];
//        }
//        return self;
//    }
//    else{
//        return nil;
//    }
}

- (void)loadDestinationClass
{
//    Class gmViewController = objc_allocateClassPair(Nil, "MyViewController", 0);
    Class gmViewController = objc_getClass("MyViewController");
    
    if (gmViewController) {
        NSLog(@"found MyViewController.");
        destGMViewControllerClass = gmViewController;
        destGMViewController = [[destGMViewControllerClass alloc] init];
    } else {
        NSLog(@"missed MyViewController");
        return;
    }
}

- (void)setDelegate:(id)objDelegate
{

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    SEL delegateSEL = @selector(setGMDelegate:);
#pragma clang diagnostic pop
    
// Both solutionA and solutionB work well.
#if 0   // SolutionA
    Method delegateMethod = class_getInstanceMethod(destGMViewControllerClass, delegateSEL);
    NSLog(@"%@ delegateMethod.", delegateMethod ? @"found" : @"missed");
    
    void (*typed_method)(id, Method, id) = (void *)method_invoke;
    typed_method(destGMViewController, delegateMethod, objDelegate);
#else   // SolutionB
    if ([destGMViewController respondsToSelector:delegateSEL])
    {
        void (*typed_msgSend)(id, SEL, id) = (void *)objc_msgSend;
        typed_msgSend(destGMViewController, delegateSEL, objDelegate);
    }
    else
    {
        NSAssert(false, @"Not found setGMDelegate in %@", NSStringFromClass(destGMViewControllerClass));
    }
#endif
}

-(void)dealloc{
    NSLog(@"dealloc GMViewController");
    objc_disposeClassPair([destGMViewController class]);
}

- (UIViewController *)destinationViewController
{
    return destGMViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
