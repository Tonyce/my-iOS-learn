//
//  socket-Client.c
//  useCSocket
//
//  Created by D_ttang on 15/7/3.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

#include <arpa/inet.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>

#include "socket-Client.h"

#define MYPORT  30000
#define BUFFER_SIZE 1024

///定义sockfd

int sock;

int connectServer(){
    sock = socket(AF_INET,SOCK_STREAM, 0);
    
    if (sock < 0) {
        return -2; //ERROR opening socket
    }
    
    struct sockaddr_in servaddr;
    memset(&servaddr, 0, sizeof(servaddr));
    servaddr.sin_family = AF_INET;
    servaddr.sin_port = htons(MYPORT);  ///服务器端口
    servaddr.sin_addr.s_addr = inet_addr("127.0.0.1");
    ///连接服务器，成功返回0，错误返回-1
    
    int connectResult = connect(sock, (struct sockaddr *)&servaddr, sizeof(servaddr));
    return connectResult;
    
//    if (connect(sock_cli, (struct sockaddr *)&servaddr, sizeof(servaddr)) < 0){
//        perror("connect");
//        exit(1);
//    }
    
    /*
    // Construct the server address structure
    struct sockaddr_in servAddr;            // Server address
    memset(&servAddr, 0, sizeof(servAddr)); // Zero out structure
    servAddr.sin_family = AF_INET;          // IPv4 address family
    // Convert address
    int rtnVal = inet_pton(AF_INET, servIP, &servAddr.sin_addr.s_addr);
    if (rtnVal == 0){
        return rtnVal
    }
//        DieWithUserMessage("inet_pton() failed", "invalid address string");
    else if (rtnVal < 0) {
        return rtnVal
    }
//        DieWithSystemMessage("inet_pton() failed");
    servAddr.sin_port = htons(servPort);    // Server port
    
    // Establish the connection to the echo server
    if (connect(sock, (struct sockaddr *) &servAddr, sizeof(servAddr)) < 0)
        DieWithSystemMessage("connect() failed");
    */
}

void connectStatus(){
    
}

long writeToServer(){
    
    char *echoString = "hello server i am from c";
    size_t echoStringLen = strlen(echoString); // Determine input length
    
    // Send the string to the server
    ssize_t numBytes = send(sock, echoString, echoStringLen, 0);
//    if (numBytes < 0){
//        return numBytes;
//    }else
//        DieWithSystemMessage("send() failed");
    if (numBytes != echoStringLen){
        return 0; //"sent unexpected number of bytes"
    }
//        DieWithUserMessage("send()", "sent unexpected number of bytes");
    return numBytes;
}

void monitorServer(){
    unsigned int totalBytesRcvd = 0;
    char recvbuf[BUFFER_SIZE];
    ssize_t numBytes;
    while (1) {
        numBytes = recv(sock, recvbuf, BUFFER_SIZE - 1, 0);
        if (numBytes <= 0) {
             printf("failed");
            closeConnect();
            break;
        }
//            DieWithSystemMessage("recv() failed");
//        else if (numBytes == 0)
//            DieWithUserMessage("recv()", "connection closed prematurely");
        totalBytesRcvd += numBytes; // Keep tally of total bytes
        recvbuf[numBytes] = '\0';
        printf("%s\n",recvbuf);
//        return &recvbuf;
    }
//    recv(sock, recvbuf, sizeof(recvbuf),0);
}

void closeConnect(){
    close(sock);
}

