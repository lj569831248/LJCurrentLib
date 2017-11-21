//
//  MySandboxPath.h
//  TickeTemplate
//
//  Created by Jon on 2017/11/21.
//  Copyright © 2017年 droi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MySandboxPath : NSObject

/**
 包含用户生成的数据。可读写。会被iTunes备份
 @return Documents
 */
+ (NSString *)documentsPath:(NSString *)option;

/**
 可被外部程序访问的文件。APP可读、可删除，但不能创建和修改。会被iTunes备份。
 @return Documents/Inbox
 */
+ (NSString *)inboxPath:(NSString *)option;

/**
 所有非用户数据文件的根目录。会被iTunes备份。
 @return Library/
 */
+ (NSString *)libraryPath:(NSString *)option;

/**
 缓存数据
 @return Library/Caches
 */
+ (NSString *)cachesPath:(NSString *)option;

/**
 包含应用程序的偏好设置文件。您不应该直接创建偏好设置文件，而是应该使用NSUserDefaults类来取得和设置应用程序的偏好
 @return Library/Preferences
 */
+ (NSString *)preferencesPath:(NSString *)option;

/**
 存储零时数据。你的APP应当在不需要的时候，清除这些零时数据。系统也可能在你的APP没有运行的时候，清除这些零时数据。不被iTunes备份
 @return tmp/
 */
+ (NSString *)temPath:(NSString *)option;

@end
