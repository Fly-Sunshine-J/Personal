//
//  ViewController.m
//  socket服务端
//
//  Created by vcyber on 16/8/18.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "ViewController.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self tcpServer];
}

- (void)tcpServer {
    int error = -1;
    //创建socket套接字
    int serverSocketId = socket(AF_INET, SOCK_STREAM, 0);
    //判断是否创建成功
    BOOL success = (serverSocketId != -1);
    
    //第二步绑定端口号
    if (success) {
        NSLog(@"客户端socket创建成功");
        //socket address
        struct sockaddr_in addr;
        
        //初始化全置为0
        memset(&addr, 0, sizeof(addr));
        
        //指定socket地址长度
        addr.sin_len = sizeof(addr);
        
        //指定协议簇为AF_INET TCP/UDP协议
        addr.sin_family = AF_INET;
        
        //指定端口号
        addr.sin_port = htons(1024);
        
        //监听任何ip地址
        addr.sin_addr.s_addr = INADDR_ANY;
        
        //绑定套接字
        error = bind(serverSocketId, (const struct sockaddr *)&addr, sizeof(addr));
        success = (error == 0);
    }
    
    //第三步: 监听
    if (success) {
        NSLog(@"绑定端口号完成");
        //监听数量
        error = listen(serverSocketId, 5);
        success = (error == 0);
    }
    
    if (success) {
        NSLog(@"监听成功");
        while (YES) {
            struct sockaddr_in peerAddr;
            int peerSocketId;
            socklen_t addrLen = sizeof(peerAddr);
            
            //第四步: 等待客户端连接
            peerSocketId = accept(serverSocketId, (struct sockaddr *)&peerAddr, &addrLen);
            success = (peerSocketId != -1);
            
            if (success) {
                NSLog(@"接入成功, address: %s, port: %d", inet_ntoa(peerAddr.sin_addr), ntohs(peerAddr.sin_port));
                
                char buff[1024];
                size_t len = sizeof(buff);
                
                //第五步: 接收来自客户端的信息
                //当客户端输入exit时退出
                do {
                    recv(peerSocketId, buff, len, 0);
                    NSString *str = [NSString stringWithCString:buff encoding:NSUTF8StringEncoding];
                    if (str.length > 0) {
                        NSLog(@"接收数据: %@", str);
                    }
                } while (strcmp(buff, "exit") != 0);
                
                NSLog(@"退出");
                
                //第六步: 关闭
                close(peerSocketId);
            }
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
