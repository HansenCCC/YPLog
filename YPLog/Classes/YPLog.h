//
//  YPLog.h
//  YPLog
//
//  Created by Hansen on 2022/10/31.
//

#import <Foundation/Foundation.h>
#import <CocoaLumberjack/CocoaLumberjack.h>

NS_ASSUME_NONNULL_BEGIN

#define YPLogError(frmt, ...)   YP_LOG_MAYBE(DDLogLevelError, DDLogFlagError,   frmt, ##__VA_ARGS__)
#define YPLogWarn(frmt, ...)    YP_LOG_MAYBE(DDLogLevelWarning, DDLogFlagWarning, frmt, ##__VA_ARGS__)
#define YPLogInfo(frmt, ...)    YP_LOG_MAYBE(DDLogLevelInfo, DDLogFlagInfo,    frmt, ##__VA_ARGS__)
#define YPLogDebug(frmt, ...)   YP_LOG_MAYBE(DDLogLevelDebug, DDLogFlagDebug,   frmt, ##__VA_ARGS__)

#define YP_LOG_MAYBE(lvl, flg, frmt, ...) \
    if (lvl & flg) { \
        [DDLog log:YES level:lvl flag:flg context:0 file:__FILE__ function:__FUNCTION__ line:__LINE__ tag:0 format:(frmt), ## __VA_ARGS__]; \
    }

@interface YPLog : NSObject

+ (NSString *)defaultLogFilePath;

@end

NS_ASSUME_NONNULL_END
