#!/bin/bash
#Set parameter
SOCKET=`netstat -untpa | grep 5050 | grep "Ticket V3 Work" | grep LISTEN|wc -l`
SOCKET_PIDS=`ps -ef | grep "WorkerMan: master process" | grep -v grep | awk '{print $2}'`
log=/www/project/ticket/Log
DATE=$(date "+%Y-%m-%d %H:%M:%S")
USER=`whoami`
NOTICE=`ps -ef | grep -v grep| grep "ticket-message.sh"|wc -l`
NOTICE_PIDS=`ps -ef | grep "ticket-message.sh" | grep -v grep | awk '{print $2}'`
Directory=/www/project/ticket
ACCOUNT_JUDGE_FUN () {

	if [ "$(whoami)" != "root" ];then
			${SETCOLOR_WARNING} && echo "warning:please use root account install cloudroom system!" && ${SETCOLOR_NORMAL}
			exit 1
	fi

}
# 监听SOCKET服务
FEELDESK_SOCKET () {

	if [ ${SOCKET} -ne 1 ];then
	    for pid in ${SOCKET_PIDS}
        do
                kill -9 ${pid}
        done
			sh ${Directory}/Shell/socket-start.sh
			echo "-----------------------------------------------------------------" >> ${log}/listen.log
			echo "时间:  ${DATE} " >> ${log}/listen.log
			echo "监听到WebSocket已断开,正在启动WebSocket...启动成功!" >>  ${log}/listen.log
			echo "                                                                 " >> ${log}/listen.log
else
		echo "SOCKET服务正在运行中"
fi
}

ACCOUNT_JUDGE_FUN
FEELDESK_SOCKET
