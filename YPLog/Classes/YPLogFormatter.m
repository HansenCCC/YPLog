//
//  YPLogFormatter.m
//  YPLog
//
//  Created by Hansen on 2022/10/31.
//

#import "YPLogFormatter.h"

@implementation YPLogFormatter

- (NSString *)formatLogMessage:(DDLogMessage *)logMessage {
    NSString *logLevel;
    switch (logMessage.flag) {
        case DDLogFlagDebug:
            logLevel = @"DEBUG";
            break;
        case DDLogFlagInfo:
            logLevel = @"INFO";
            break;
        case DDLogFlagWarning:
            logLevel = @"WARN";
            break;
        case DDLogFlagError:
            logLevel = @"ERROR";
            break;
        case DDLogFlagVerbose:
            logLevel = @"VERBOSE";
            break;
        default:
            logLevel = @"VERBOSE";
            break;
    }
    
    static dispatch_once_t onceToken;
    static NSDateFormatter *logDateFormatter;
    dispatch_once(&onceToken, ^{
        logDateFormatter = [[NSDateFormatter alloc] init];
        logDateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss:SSS";
    });
    
    return [NSString stringWithFormat:@"\n%@ *** [%@] %@ (line: %lu)\n*** %@\n",
            [logDateFormatter stringFromDate:logMessage.timestamp],
            logLevel,
            logMessage.function,
            logMessage.line,
            logMessage.message];
}

@end
