//
//  Generated file. Do not edit.
//

// clang-format off

#import "GeneratedPluginRegistrant.h"

#if __has_include(<umeng_apm_sdk/UmengApmSdkPlugin.h>)
#import <umeng_apm_sdk/UmengApmSdkPlugin.h>
#else
@import umeng_apm_sdk;
#endif

#if __has_include(<umeng_common_sdk/UmengCommonSdkPlugin.h>)
#import <umeng_common_sdk/UmengCommonSdkPlugin.h>
#else
@import umeng_common_sdk;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [UmengApmSdkPlugin registerWithRegistrar:[registry registrarForPlugin:@"UmengApmSdkPlugin"]];
  [UmengCommonSdkPlugin registerWithRegistrar:[registry registrarForPlugin:@"UmengCommonSdkPlugin"]];
}

@end
