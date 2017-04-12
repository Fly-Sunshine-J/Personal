//
//  ViewController.m
//  socket客户端
//
//  Created by vcyber on 16/8/18.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "ViewController.h"
#import <Foundation/Foundation.h>
#include <sys/socket.h>
#include <netinet/in.h>
#import <arpa/inet.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self tcpClient];
}


- (void)tcpClient {
    
    //第一步: 创建socket
    int error = -1;
    int clientSocketId = socket(AF_INET, SOCK_STREAM, 0);
    BOOL success = (clientSocketId != -1);
    
     struct sockaddr_in addr;
    //第二步: 绑定端口号
    if (success) {
        NSLog(@"客户端socket创建成功");
        
       
        memset(&addr, 0, sizeof(addr));
        addr.sin_len = sizeof(addr);
        
        //指定协议簇
        addr.sin_family = AF_INET;
        
        //监听任何ip
        addr.sin_addr.s_addr = INADDR_ANY;
        error = bind(clientSocketId, (const struct sockaddr *)&addr, sizeof(addr));
        success = (error == 0);
    }
    
    if (success) {
        NSLog(@"监听成功");
        struct sockaddr_in peerAddr;
        memset(&peerAddr, 0, sizeof(peerAddr));
        peerAddr.sin_len = sizeof(peerAddr);
        peerAddr.sin_family = AF_INET;
        peerAddr.sin_port = htons(1024);
        
        peerAddr.sin_addr.s_addr = inet_addr("192.168.6.5");
        
        socklen_t addrLen;
        addrLen = sizeof(peerAddr);

        
        // 第三步：连接服务器
        error = connect(clientSocketId, (struct sockaddr *)&peerAddr, addrLen);
        success = (error == 0);
        
        if (success) {
            // 第四步：获取套接字信息
            error = getsockname(clientSocketId, (struct sockaddr *)&addr, &addrLen);
            success = (error == 0);
            
            if (success) {
                NSLog(@"连接成功, local address:%s,port:%d",
                      inet_ntoa(addr.sin_addr),
                      ntohs(addr.sin_port));
                
                // 这里只发送10次
                int count = 10;
                do {
                    // 第五步：发送消息到服务端
                    send(clientSocketId, "哈哈，server您好！", 1024, 0);
                    count--;
                    
                    // 告诉server，客户端退出了
                    if (count == 0) {
                        send(clientSocketId, "exit", 1024, 0);
                    }
                } while (count >= 1);
                
                // 第六步：关闭套接字
                close(clientSocketId);
            }
        } else {
            NSLog(@"连接失败");
            
            // 第六步：关闭套接字
            close(clientSocketId);
        }
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
