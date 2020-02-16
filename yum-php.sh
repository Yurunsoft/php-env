#!/bin/bash
# 适合 CentOS 等使用 yum 的 Linux 系统

if [[ $EUID -ne 0 ]]; then
    echo -e "\033[31m请使用 sudo 权限运行此脚本\033[0m"
    exit 1
fi

redhatRelease=`cat /etc/redhat-release | awk '{match($0,"release ")
 print substr($0,RSTART+RLENGTH)}' | awk -F '.' '{print $1}'`
if [[ "" == $redhatRelease ]]; then
    echo -e "\033[31m你的系统似乎不是 RedHat 系列\033[0m"
    exit 1
fi

if [[ "" == "$(rpm -qa|grep epel-release)" ]]; then

yum install epel-release -y

echo -e "\033[32m请选择 PHP 版本:\033[0m"
echo -e "\033[32m0-7.0\033[0m"
echo -e "\033[32m1-7.1\033[0m"
echo -e "\033[32m2-7.2\033[0m"
echo -e "\033[32m3-7.3\033[0m"
echo -e "\033[32m4-7.4\033[0m"
read -p "请选择:" PHP_VERSION

if [[ "0" == $PHP_VERSION ]]; then
    cmdPHPVersion="php70-php"
    rpmA
elif [[ "1" == $PHP_VERSION ]]; then
    cmdPHPVersion="php71-php"
    rpmA
elif [[ "2" == $PHP_VERSION ]]; then
    cmdPHPVersion="php72-php"
    rpmA
elif [[ "3" == $PHP_VERSION ]]; then
    cmdPHPVersion="php73-php"
    rpmB
elif [[ "4" == $PHP_VERSION ]]; then
    cmdPHPVersion="php74-php"
    rpmB
else
    echo -e "\033[31m版本选择错误\033[0m"
    exit 1
fi

# 安装源
yum install -y https://mirrors.tuna.tsinghua.edu.cn/remi/enterprise/remi-release-$redhatRelease.rpm # 国内清华源
# 官方源：http://rpms.remirepo.net/enterprise/remi-release-7.rpm

# 安装php
# 基本很全了，如果不够，自己再装
echo -e "\033[32m安装 PHP...\033[0m"
yum install -y $cmdPHPVersion-fpm $cmdPHPVersion-cli $cmdPHPVersion-bcmath $cmdPHPVersion-bz2 $cmdPHPVersion-curl $cmdPHPVersion-devel $cmdPHPVersion-pear $cmdPHPVersion-gd $cmdPHPVersion-mbstring $cmdPHPVersion-mysql $cmdPHPVersion-opcache $cmdPHPVersion-sqlite3 $cmdPHPVersion-xml $cmdPHPVersion-zip

# 快捷方式
update-alternatives --install /usr/bin/php php /opt/remi/php7$PHP_VERSION/root/usr/bin/php $PHP_VERSION
update-alternatives --install /usr/bin/phpize phpize /opt/remi/php7$PHP_VERSION/root/usr/bin/phpize $PHP_VERSION
update-alternatives --install /usr/bin/php-config php-config /opt/remi/php7$PHP_VERSION/root/usr/bin/php-config $PHP_VERSION
