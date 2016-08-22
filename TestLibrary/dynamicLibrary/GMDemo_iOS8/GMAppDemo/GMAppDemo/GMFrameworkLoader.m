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
#import <objc/runtime.h>
#import <objc/message.h>


#define kSTRGMZip       @"GM.zip"
#define kSTRGMDylibDemoFramework    @"GMDylibDemo.framework"

@interface GMFrameworkLoader()
@property (nonatomic , assign) CFBundleRef libBundle;
@property (nonatomic , assign) BOOL isLoad;
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
    self = [super init];
    if ( self ) {
        _isLoad = NO;
    }
    return self;
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
            NSLog(@" Error: remove file error: %@" , error);
        }
        else{
            NSLog(@" Success: remove file success!! ");
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
        else{
            NSLog(@"Success: File downloaded to \"%@\"", filePath);
        }
        
        [GMFrameworkLoader unzipFramework];
    }];
    [downloadTask resume];
    
    return result;
}

+ (BOOL)zipFramework
{
    BOOL result = YES;
    
    /*
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
    */
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
            NSLog(@"Error: remove file error: %@" , error);
        }
        else{
            NSLog(@"Success: remove files...");
        }
    }
    
    ZipArchive* za = [[ZipArchive alloc] init];
    
    NSString *unzipMsg = @"Error: 解壓縮失敗";
    
    if( [za UnzipOpenFile:zipFilePath] ) {
        if( [za UnzipFileTo:output overWrite:YES] == YES ) {
            //unzip data success
            //do something
            NSLog(@"Success: 解壓縮且覆蓋成功 ");
            unzipMsg = @"Success: 解壓縮且覆蓋成功";
        }
        else{
            unzipMsg = @"Error: 解壓縮但覆蓋檔案失敗";
        }
        
        [za UnzipCloseFile];
    }
}

//- (BOOL)loadFrameworkWithCString:(const char *)libPath
//{
//    BOOL result = YES;
//    
//    void* sdl_library = dlopen(libPath, RTLD_LAZY);
//    result = sdl_library != NULL;
//    
//    if (!result){
//        NSLog(@"Error: Failed to load framework: %s, error: %s", libPath, dlerror());
//    }
//    
//    dlclose(sdl_library);
//    
//    return result;
//}

- (BOOL)loadFramework
{
    return [self loadFrameworkWithBundlePath:kSTRGMDylibDemoFramework];
}

- (BOOL)loadFrameworkWithBundlePath:(NSString *)bundlePath
{
    BOOL result = NO;
    
#define D_Use_NSBundle_Ver
#ifdef D_Use_NSBundle_Ver
    
    if ( _isLoad == NO ) {
        
//        NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
        NSString *documentsPath = [NSString stringWithFormat:@"%@/Documents/%@/%@",NSHomeDirectory() , kSTRGMDylibDemoFramework , kSTRGMDylibDemoFramework];
        
//        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@" , [documentsDirectory stringByAppendingPathComponent:kSTRGMDylibDemoFramework] , kSTRGMDylibDemoFramework]];
        
        if ( [[NSFileManager defaultManager] fileExistsAtPath:documentsPath] ) {
            NSError *error = nil;
            NSBundle *bundle = [NSBundle bundleWithPath:documentsPath];
            if ( [bundle loadAndReturnError:&error] ) {
                if ( error ) {
                    NSLog(@"Fail: NSBundle load framework fail.( %@ )" , error.description);
                }
                else{
                    NSLog(@"Success: NSBundle load framework success!");
                    _isLoad = YES;
                    result = YES;
                }
            }
            else{
                NSLog(@"Fail: NSBundle load framework fail.");
            }
        }
        else{
            NSLog(@"Fail: NSBundle load framework fail.( file not exist )");
        }
    }
    
#else
    if ( _isLoad == NO ) {
        NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@" , [documentsDirectory stringByAppendingPathComponent:kSTRGMDylibDemoFramework] , kSTRGMDylibDemoFramework]];
        _libBundle = CFBundleCreate(kCFAllocatorDefault, (CFURLRef)url);
        _isLoad = YES;
    }
    
    CFErrorRef err;
    //    result = CFBundleLoadExecutable(libBundle);
    result = CFBundleLoadExecutableAndReturnError(_libBundle, &err);
    
    if (!result){
        NSLog(@"Error: Failed to load bundle: %@, error: %@", _libBundle, err);
    }
    
#endif
    
    return result;
}

- (BOOL)unloadFramework{
    BOOL result = NO;
    
#ifdef D_Use_NSBundle_Ver
    
//    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *documentsPath = [NSString stringWithFormat:@"%@/Documents/%@/%@",NSHomeDirectory() , kSTRGMDylibDemoFramework , kSTRGMDylibDemoFramework];
    
//    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@" , [documentsDirectory stringByAppendingPathComponent:kSTRGMDylibDemoFramework] , kSTRGMDylibDemoFramework]];
    NSBundle *bundle = [NSBundle bundleWithPath:documentsPath];
    result = [bundle unload];
    
#else
    
    CFBundleUnloadExecutable(_libBundle);
    CFRelease(_libBundle);
    result = YES;
    
#endif
    
    // 移除檔案
    [self removeBundleAndZip];
    _isLoad = NO;
    
    if ( FlushBundleCache(bundle) ) {
        NSLog(@" ** Success: flush bundle cache SUCCESS ...");
    }
    else{
        NSLog(@" ** Faile: flush bundle cache FAIL! ");
    }
    
    return result;
    
}

-(void)removeBundleAndZip{
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *zipFilePath = [documentsDirectory stringByAppendingPathComponent:kSTRGMZip];
    
    NSString *output = [documentsDirectory stringByAppendingPathComponent:kSTRGMDylibDemoFramework];
    
    if ( [[NSFileManager defaultManager] fileExistsAtPath:output] ) {
        NSError *error = nil;
        [[NSFileManager defaultManager] removeItemAtPath:output error:&error];
        
        if ( error ) {
            NSLog(@"Error: remove framework error: %@" , error);
        }
        else{
            NSLog(@"Success: remove framework...");
        }
    }
    
    if ( [[NSFileManager defaultManager] fileExistsAtPath:zipFilePath] ) {
        NSError *error = nil;
        [[NSFileManager defaultManager] removeItemAtPath:zipFilePath error:&error];
        
        if ( error ) {
            NSLog(@"Error: remove zip error: %@" , error);
        }
        else{
            NSLog(@"Success: remove zip...");
        }
    }
}

+(void)listAllClass{
    int numClasses;
    Class * classes = NULL;
    
    classes = NULL;
    numClasses = objc_getClassList(NULL, 0);
    
    if (numClasses > 0 )
    {
        classes = (__unsafe_unretained Class *)malloc(sizeof(Class) * numClasses);
        numClasses = objc_getClassList(classes, numClasses);
        for (int i = 0; i < numClasses; i++) {
            Class c = classes[i];
            NSLog(@"%s", class_getName(c));
        }
        free(classes);
    }
}

extern void _CFBundleFlushBundleCaches(CFBundleRef bundle) 
__attribute__((weak_import));

BOOL FlushBundleCache(NSBundle *prefBundle) {
    // Before calling the function, we need to check if it exists
    // since it was weak-linked.
    if (_CFBundleFlushBundleCaches != NULL) {
        NSLog(@"Flushing bundle cache with _CFBundleFlushBundleCaches");
        CFBundleRef cfBundle =
        CFBundleCreate(nil, (CFURLRef)[prefBundle bundleURL]);
        _CFBundleFlushBundleCaches(cfBundle);
        CFRelease(cfBundle);
        return YES; // Success
    }
    return NO; // Not available
}

@end
