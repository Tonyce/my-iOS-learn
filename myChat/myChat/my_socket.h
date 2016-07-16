//
//  my_socket.h
//  myChat
//
//  Created by D_ttang on 15/2/20.
//  Copyright (c) 2015年 D_ttang. All rights reserved.
//

#ifndef __myChat__my_socket__
#define __myChat__my_socket__


#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <arpa/inet.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <sys/socket.h>
#include <sys/stat.h>
#include <dirent.h>
#include <netdb.h>
#include <unistd.h>
#include <fcntl.h>
#include <signal.h>

int tcpsocket_connect(const char *host, int port, int timeout);
int tcpsocket_close(int socketfd);
int tcpsocket_send(int socketfd, const char *data, int len);
int tcpsocket_pull(int socketfd,char *data,int len);

#endif /* defined(__myChat__my_socket__) */
