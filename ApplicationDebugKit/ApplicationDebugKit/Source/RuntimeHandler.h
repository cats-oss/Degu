//
//  RuntimeHandler.h
//  ApplicationDebugKit
//
//  Created by marty-suzuki on 2018/04/26.
//  Copyright © 2018年 AbemaTV. All rights reserved.
//

#import <Foundation/Foundation.h>

/// not use directory
///
/// - note: NSObject.load and NSObject.initialize is not called if override objects from Swift.
///         therefore overriding methods via RuntimeHandler extension.
@interface _RuntimeHandler: NSObject

/// Handle NSObject.load
///
/// - seealso: https://developer.apple.com/documentation/objectivec/nsobject/1418815-load?language=objc
+ (void)handleLoad;

/// Handle NSObject.initialize
///
/// - seealso: https://developer.apple.com/documentation/objectivec/nsobject/1418639-initialize?language=objc
+ (void)handleInitialize;

@end

/// Handle NSObject.load and NSObject.initialize method
///
/// - note: override loadHandler and initializeHandler in RuntimeHandler extension
@interface RuntimeHandler : _RuntimeHandler
@end
