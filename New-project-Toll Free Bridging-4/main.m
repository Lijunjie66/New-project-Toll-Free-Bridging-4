//
//  main.m
//  New-project-Toll Free Bridging-4
//
//  Created by Geraint on 2018/4/3.
//  Copyright © 2018年 kilolumen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        
        // 创建Core Foundation框架直接桥接数据类型的变量
        // CFStringRef 是一种Core Foundation框架数据类型，代表Unicode字符串
        CFStringRef cstr = CFStringCreateWithCString(NULL, "Hello, world!",
                                                     kCFStringEncodingASCII);
        NSArray *data = [NSArray arrayWithObject:(__bridge_transfer NSString *)cstr];
        NSLog(@"Array size = %ld",[data count]);
        
        
        // 将一个Foundation框架对象转换为Core Foundation框架对象
        // 这段代码创建了一个Foundation框架对象的NSString类型实例，并使用__bridge标记将之装换为Core Foundation框架的CFStringRef类型对象。这对代码可以运行，但是有潜在的悬挂指针问题，因为在执行桥接转换时，ARC会立刻向该NSString对象发一条release消息。要解决这个问题，应将转换标记更改为__bridge_retained。这样做可以从ARC接管该对象，从而避免使ARC向该对象发送release消息，此时，必须手动管理这个对象的生命周期，在printf语句之后调用CFRElease方法：
        NSString *greeting = [[NSString alloc] initWithFormat:@"%@",@"Hello world"];
        CFStringRef cstr1 = (__bridge CFStringRef)(greeting);
        printf("String length - %ld",CFStringGetLength(cstr1));
        CFRelease(cstr1);
        
        
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
