//
//  MySandboxPath.m
//  TickeTemplate
//
//  Created by Jon on 2017/11/21.
//  Copyright © 2017年 droi. All rights reserved.
//

#import "MySandboxPath.h"

@implementation MySandboxPath

+ (NSString *)documentsPath:(NSString *)option{
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    if (option) {
        documentsPath = [documentsPath stringByAppendingFormat:@"/%@",option];
    }
    return documentsPath;
}

+ (NSString *)inboxPath:(NSString *)option{
    NSString *inboxPath = [self documentsPath:@"Inbox"];
    if (option) {
        inboxPath = [inboxPath stringByAppendingFormat:@"/%@",option];
    }
    return inboxPath;
}

+ (NSString *)libraryPath:(NSString *)option{
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    if (option) {
        libraryPath = [libraryPath stringByAppendingFormat:@"/%@",option];
    }
    return libraryPath;
}

+ (NSString *)cachesPath:(NSString *)option{
    NSString *cachesPath =[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    if (option) {
        cachesPath = [cachesPath stringByAppendingFormat:@"/%@",option];
    }
    return cachesPath;
}

+ (NSString *)preferencesPath:(NSString *)option{
    NSString *preferencesPath = [self libraryPath:@"Preferences"];
    if (option) {
        preferencesPath = [preferencesPath stringByAppendingFormat:@"/%@",option];
    }
    return preferencesPath;
}

+ (NSString *)temPath:(NSString *)option{
    NSString*tmp = NSTemporaryDirectory();
    if (option) {
        tmp = [tmp stringByAppendingFormat:@"/%@",option];
    }
    return tmp;
}
@end
