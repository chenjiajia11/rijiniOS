//
//  CDVMyPlguin.m
//  test
//
//  Created by 1 on 14-4-9.
//
//

#import "CDVMyPlguin.h"

@implementation CDVMyPlugin

@synthesize callbackID;


-(void)print:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options
{
/*
 //调用IOS方法插件
 var MyIOSPlugin = {
 
 * 调用IOS方法
 * @param method 要调用IOS插件的方法名
 * @param parameter 参数[数组]
 * @param success 成功回调
 * @param fail 失败回调
 * @returns {*}
 
nativeFunction: function(method, parameter, success, fail) {
    return Cordova.exec(success, fail, "MyPlugin", method, parameter);
}
};*/

    // 这是classid,在下面的PluginResult进行数据的返回时,将会用到它
    self.callbackID = [arguments pop];
    NSLog(@"====%@",self.callbackID);
    // 得到Javascript端发送过来的字符串
    NSString *stringObtainedFromJavascript = [arguments objectAtIndex:0];
    
    // 创建我们要返回给js端的字符串
    NSMutableString *stringToReturn = [NSMutableString stringWithString: @"我是返回的:"];
    
    [stringToReturn appendString: stringObtainedFromJavascript];
    
    // Create Plugin Result
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: stringToReturn];
    
    NSLog(@ "%@",stringToReturn);
    
    // 检查发送过来的字符串是否等于"HelloWorld",如果不等,就以PluginResult的Error形式返回
    if ([stringObtainedFromJavascript isEqualToString:@"HelloWorld"] == YES){
        // Call the javascript success function
        [self writeJavascript: [pluginResult toSuccessCallbackString:self.callbackID]];
    } else{
        // Call the javascript error function
        [self writeJavascript: [pluginResult toErrorCallbackString:self.callbackID]];
    }
}
@end
