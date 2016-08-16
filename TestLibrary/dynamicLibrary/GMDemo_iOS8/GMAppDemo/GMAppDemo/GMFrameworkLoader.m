//
//  GMFrameworkLoader.m
//  GMAppDemo
//
//  Created by WeiHan on 10/22/14.
//  Copyright (c) 2014 Wei Han. All rights reserved.
//

#import "GMFrameworkLoader.h"
#import <dlfcn.h>
#import "AFURLSessionManager.h"
#import "ZipArchive.h"


#define kSTRGMZip       @"GM.zip"
#define kSTRGMDylibDemoFramework    @"GMDylibDemo.framework"

@interface GMFrameworkLoader()
@end

@implementation GMFrameworkLoader

+(instancetype)sharedInstance{
    static GMFrameworkLoader *instanceObject = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ( instanceObject == nil ) {
            instanceObject = [[self alloc] init];
        }
    });
    return instanceObject;
}

-(instancetype)init{
    
}

+ (BOOL)getFrameworkFromURL:(NSString *)urlString
{
    // 移除 zip
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *zipFilePath = [documentsDirectory stringByAppendingPathComponent:kSTRGMZip];
    
    if ( [[NSFileManager defaultManager] fileExistsAtPath:zipFilePath] ) {
        NSError *error = nil;
        [[NSFileManager defaultManager] removeItemAtPath:zipFilePath error:&error];
        
        if ( error ) {
            NSLog(@" remove file error: %@" , error);
        }
    }
    
    
    __block BOOL result = YES;

    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request 
                                                                     progress:nil 
                                                                  destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory 
                                                                              inDomain:NSUserDomainMask 
                                                                     appropriateForURL:nil 
                                                                                create:NO 
                                                                                 error:nil];
//        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
        return [documentsDirectoryURL URLByAppendingPathComponent:kSTRGMZip];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        if (error) {
            result = NO;
            NSLog(@"Error: %@", error);
        }
        
        NSLog(@"File downloaded to: %@", filePath);
        
        [GMFrameworkLoader unzipFramework];
    }];
    [downloadTask resume];
    
    return result;
}

+ (BOOL)zipFramework
{
    BOOL result = YES;
    
    BOOL isDir = YES;
    
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSArray *subpaths;
    
    NSString *toCompress = @"/Users/hanwei/work/GMDemo/GMDylibDemo/OutFramework/GMDylibDemo.framework";
    NSString *pathToCompress = toCompress;//[documentsDirectory stringByAppendingPathComponent:toCompress];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:pathToCompress isDirectory:&isDir] && isDir){
        subpaths = [fileManager subpathsAtPath:pathToCompress];
    } else if ([fileManager fileExistsAtPath:pathToCompress]) {
        subpaths = [NSArray arrayWithObject:pathToCompress];
    }
    
    NSString *zipFilePath = [documentsDirectory stringByAppendingPathComponent:kSTRGMZip];
    
    ZipArchive *za = [[ZipArchive alloc] init];
    [za CreateZipFile2:zipFilePath];
    if (isDir) {
        for(NSString *path in subpaths){
            NSString *fullPath = [pathToCompress stringByAppendingPathComponent:path];
            if([fileManager fileExistsAtPath:fullPath isDirectory:&isDir] && !isDir){
                [za addFileToZip:fullPath newname:path];
            }
        }
    } else {
        [za addFileToZip:pathToCompress newname:toCompress];
    }
    
    result = [za CloseZipFile2];
    
    // test
    [self unzipFramework];
    
    return result;
}

+ (void)unzipFramework
{
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *zipFilePath = [documentsDirectory stringByAppendingPathComponent:kSTRGMZip];
    
    NSString *output = [documentsDirectory stringByAppendingPathComponent:kSTRGMDylibDemoFramework];
    
    if ( [[NSFileManager defaultManager] fileExistsAtPath:output] ) {
        NSError *error = nil;
        [[NSFileManager defaultManager] removeItemAtPath:output error:&error];
        
        if ( error ) {
            NSLog(@" remove file error: %@" , error);
        }
    }
    
    ZipArchive* za = [[ZipArchive alloc] init];
    
    NSString *unzipMsg = @"解壓縮失敗";
    
    if( [za UnzipOpenFile:zipFilePath] ) {
        if( [za UnzipFileTo:output overWrite:YES] == YES ) {
            //unzip data success
            //do something
            NSLog(@" 解壓縮且覆蓋成功 ");
            unzipMsg = @"解壓縮且覆蓋成功";
        }
        else{
            unzipMsg = @"解壓縮但覆蓋檔案失敗";
        }
        
        [za UnzipCloseFile];
    }
}

+ (BOOL)loadFrameworkWithCString:(const char *)libPath
{
    BOOL result = YES;
    
    void* sdl_library = dlopen(libPath, RTLD_LAZY);
    result = sdl_library != NULL;
    
    if (!result){
        NSLog(@"Failed to load framework: %s, error: %s", libPath, dlerror());
    }
    
    dlclose(sdl_library);
    
    return result;
}

+ (BOOL)loadFramework
{
    return [self loadFrameworkWithBundlePath:kSTRGMDylibDemoFramework];
}

+ (BOOL)loadFrameworkWithBundlePath:(NSString *)bundlePath
{
    BOOL result = YES;
    
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@" , [documentsDirectory stringByAppendingPathComponent:bundlePath] , kSTRGMDylibDemoFramework]];
    CFBundleRef libBundle = CFBundleCreate(kCFAllocatorDefault, (CFURLRef)url);
    
//    result = CFBundleLoadExecutable(libBundle);
    
    CFErrorRef err;
    result = CFBundleLoadExecutableAndReturnError(libBundle, &err);
    
    if (!result){
        NSLog(@"Failed to load bundle: %@, error: %@", libBundle, err);
    }
    
    return result;
}

+ (BOOL)unloadFramework{
    BOOL result = YES;
    
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@" , [documentsDirectory stringByAppendingPathComponent:kSTRGMDylibDemoFramework] , kSTRGMDylibDemoFramework]];
    CFBundleRef libBundle = CFBundleCreate(kCFAllocatorDefault, (CFURLRef)url);
    
    CFBundleUnloadExecutable(libBundle);
    
    return result;
    
}

@end
