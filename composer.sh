#!/bin/bash

read -p "是否下载安装 Composer？(y/n):" install

echo -e "\033[32m请选择中国镜像源:\033[0m"
echo -e "\033[32m1-阿里云\033[0m"
echo -e "\033[32m2-腾讯云\033[0m"
echo -e "\033[32m3-华为云\033[0m"
echo -e "\033[32m4-cnpkg\033[0m"
echo -e "\033[32m其它-不使用镜像\033[0m"
read -p "请选择:" chineseCDN

read -p "是否安装 Composer 多线程加速下载包？(y/n):" speedUp


if [[ $install = "y" ]] || [[ $install = "" ]]; then
    # 删除已存在文件
    if [[ -f composer.phar ]]; then
        rm composer.phar
    fi

    # 下载
    downloadUrl="https://getcomposer.org/composer-stable.phar"
    if !(type wget >/dev/null 2>&1); then
        echo -e "\033[32m正在使用 wget 下载 Composer...\033[0m"
        wget -O composer.phar $downloadUrl
    if !(type curl >/dev/null 2>&1); then
        echo -e "\033[32m正在使用 curl 下载 Composer...\033[0m"
        curl -o composer.phar $downloadUrl
    else
        echo -e "\033[31mError: 没有找到 wget / curl\033[0m"
        exit 1
    fi

    echo -e "\033[32m安装中...\033[0m"

    # 增加权限
    chmod +x composer.phar

    # 移动到可执行目录
    mv -f composer.phar /usr/local/bin/composer
fi

# 测试
echo -e "\033[32m测试:\033[0m"
composer -V

# 镜像设置
if [[ $chineseCDN = "1" ]]; then
    echo -e "\033[32mComposer 阿里云镜像设置:\033[0m"
    composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/
elif [[ $chineseCDN = "2" ]]; then
    echo -e "\033[32mComposer 腾讯云镜像设置:\033[0m"
    composer config -g repo.packagist composer https://mirrors.cloud.tencent.com/composer/
elif [[ $chineseCDN = "3" ]]; then
    echo -e "\033[32mComposer 华为云镜像设置:\033[0m"
    composer config -g repo.packagist composer https://mirrors.huaweicloud.com/repository/php/
elif [[ $chineseCDN = "4" ]]; then
    echo -e "\033[32mComposer cnpkg镜像设置:\033[0m"
    composer config -g repo.packagist composer https://php.cnpkg.org
fi

# Composer 多线程加速下载包
if [[ $speedUp = "y" ]] || [[ $speedUp = "" ]]; then
    echo -e "\033[32m安装 Composer 多线程加速下载包:\033[0m"
    composer global require hirak/prestissimo
fi

echo -e "\033[32m安装成功！\033[0m"
