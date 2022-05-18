#!/bin/bash
# 适合 Ubuntu、Debian 等使用 apt 的 Linux 系统

if [[ $EUID -ne 0 ]]; then
    echo -e "\033[31m请使用 sudo 权限运行此脚本\033[0m"
    exit 1
fi

echo -e "\033[32m请选择 PHP 版本:\033[0m"
echo -e "\033[32m0-7.0\033[0m"
echo -e "\033[32m1-7.1\033[0m"
echo -e "\033[32m2-7.2\033[0m"
echo -e "\033[32m3-7.3\033[0m"
echo -e "\033[32m4-7.4\033[0m"
read -p "请选择:" PHP_VERSION

if [[ "0" == $PHP_VERSION ]]; then
    cmdPHPVersion="php7.0"
elif [[ "1" == $PHP_VERSION ]]; then
    cmdPHPVersion="php7.1"
elif [[ "2" == $PHP_VERSION ]]; then
    cmdPHPVersion="php7.2"
elif [[ "3" == $PHP_VERSION ]]; then
    cmdPHPVersion="php7.3"
elif [[ "4" == $PHP_VERSION ]]; then
    cmdPHPVersion="php7.4"
else
    echo -e "\033[31m版本选择错误\033[0m"
    exit 1
fi

if !(type add-apt-repository >/dev/null 2>&1); then
    # 安装 add-apt-repository
    echo -e "\033[32m安装 add-apt-repository...\033[0m"
    apt update
    apt install -y software-properties-common
fi

# 第三方源
echo -e "\033[32m安装第三方源...\033[0m"
add-apt-repository "https://launchpad.proxy.ustclug.org/ondrej/php/ubuntu" -y -u > /dev/null 2> /tmp/apt_add_key.txt    
key=`cat /tmp/apt_add_key.txt | awk -F ":" '{print $6}'  | awk '{print $2}'`
if [[ "" != $key ]]; then
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv $key
    apt update
fi
rm /tmp/apt_add_key.txt

# 安装php
# 基本很全了，如果不够，自己再装
echo -e "\033[32m安装 PHP...\033[0m"
apt install -y --allow-unauthenticated $cmdPHPVersion-fpm $cmdPHPVersion-cli $cmdPHPVersion-bcmath $cmdPHPVersion-bz2 $cmdPHPVersion-curl $cmdPHPVersion-dev $cmdPHPVersion-gd $cmdPHPVersion-mbstring $cmdPHPVersion-mysql $cmdPHPVersion-opcache $cmdPHPVersion-sqlite3 $cmdPHPVersion-xml $cmdPHPVersion-zip
