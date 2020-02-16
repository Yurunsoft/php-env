#!/bin/bash
# 安装 PHP Redis 扩展

phpIniPath=$(php -r "echo php_ini_loaded_file();")

if [ "" == "$(php -m | grep igbinary)" ]; then
    # 安装 igbinary
    version="3.1.2"
    downloadUrl="https://github.com/igbinary/igbinary/archive/$version.tar.gz"
    if !(type wget >/dev/null 2>&1); then
        echo -e "\033[32m正在使用 wget 下载 igbinary...\033[0m"
        wget -O igbinary.tar.gz $downloadUrl
    if !(type curl >/dev/null 2>&1); then
        echo -e "\033[32m正在使用 curl 下载 igbinary...\033[0m"
        curl -o igbinary.tar.gz $downloadUrl
    else
        echo -e "\033[31mError: 没有找到 wget / curl\033[0m"
        exit 1
    fi

    tar -xzf igbinary.tar.gz
    rm igbinary.tar.gz

    cd igbinary-$version

    phpize

    ./configure

    make -j

    make install

    if [ "" == "$(php -m | grep igbinary)" ]; then
        echo "extension=igbinary.so" >> $phpIniPath
    fi
    cd ../
    rm -rf igbinary-$version
fi

version="5.1.1"
downloadUrl="https://github.com/phpredis/phpredis/archive/$version.tar.gz"

if !(type wget >/dev/null 2>&1); then
    echo -e "\033[32m正在使用 wget 下载 redis...\033[0m"
    wget -O redis.tar.gz $downloadUrl
if !(type curl >/dev/null 2>&1); then
    echo -e "\033[32m正在使用 curl 下载 redis...\033[0m"
    curl -o redis.tar.gz $downloadUrl
else
    echo -e "\033[31mError: 没有找到 wget / curl\033[0m"
    exit 1
fi

tar -xzf redis.tar.gz
rm redis.tar.gz

cd phpredis-$version

phpize

./configure --enable-redis-igbinary

make -j

make install

if [ "" == "$(php -m | grep redis)" ]; then
    echo "extension=redis.so" >> $phpIniPath
fi

cd ../

rm -rf phpredis-$version