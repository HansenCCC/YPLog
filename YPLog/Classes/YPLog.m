//
//  YPLog.m
//  YPLog
//
//  Created by Hansen on 2022/10/31.
//

#import "YPLog.h"
#import "YPLogFormatter.h"
#import <CocoaLumberjack/CocoaLumberjack.h>

@implementation YPLog

+ (void)load {
    __weak typeof(self) weakSelf = self;
    __block id observer = [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        [weakSelf didFinishLaunchingOnLoad:note];
        [[NSNotificationCenter defaultCenter] removeObserver:observer];
    }];
}

+ (void)didFinishLaunchingOnLoad:(NSNotification *)noti {
    [self initSDK];
}

+ (void)initSDK {
    [DDLog removeAllLoggers];
    
    YPLogFormatter *logFormatter = [[YPLogFormatter alloc] init];

//     add logger for Terminal output or Xcode console output.
    DDOSLogger *ttyLogger = [DDOSLogger sharedInstance];
    ttyLogger.logFormatter = logFormatter;
//    ttyLogger.colorsEnabled = YES;
    [DDLog addLogger:ttyLogger withLevel:DDLogLevelAll];
    
    // add logger for Cached
    DDLogFileManagerDefault *fileManager = [[DDLogFileManagerDefault alloc] initWithLogsDirectory:[self defaultLogFilePath]];
    DDFileLogger *fileLogger = [[DDFileLogger alloc] initWithLogFileManager:fileManager];
    // 刷新频率为一天，超过一天会生成新的log文件
    fileLogger.rollingFrequency = 60 * 60 * 24;
    // 文件大小阈值，超过该大小，也会生成新的log文件
    fileLogger.maximumFileSize = 10 * 1024 * 1024;
    // 为0.则表示不限制文件个数
    fileLogger.logFileManager.maximumNumberOfLogFiles = 0;
    fileLogger.logFormatter = logFormatter;
    // info以上上报日志
    [DDLog addLogger:fileLogger withLevel:DDLogLevelInfo];
}

+ (NSString *)defaultLogFilePath {
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"YPLog"];
    NSFileManager *fileManager = [NSFileManager defaultManager];

    if (![fileManager fileExistsAtPath:filePath]) {
        NSError *error = nil;
        [fileManager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            YPLogDebug(@"日志目录创建失败！！！");
        }
    }
    return filePath;
}

@end
