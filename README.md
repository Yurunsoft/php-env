# PHP 环境安装工具

## 介绍

宇润日常开发中，整理的一些常见的 PHP 环境相关的一键安装工具脚本。Composer 一键安装脚本。

宇润 php 全家桶交流群：17916227 [![点击加群](https://pub.idqqimg.com/wpa/images/group.png "点击加群")](https://jq.qq.com/?_wv=1027&k=5wXf4Zq)

## 文件说明

### `apt-php.sh`

一键使用 `apt` 工具安装 `php`，适合 Ubuntu、Debian 等使用 apt 的 Linux 系统。

支持安装：`PHP 7.0/7.1/7.2/7.3/7.4`。

自动安装了一些非常常用的 PHP 扩展。

快速安装：`wget https://github.com/yurunsoft/php-env/raw/master/apt-php.sh && bash apt-php.sh`

视频教程：<https://www.bilibili.com/video/av89346440>

### `yum-php.sh`

一键使用 `yum` 工具安装 `php`，适合 CentOS 等 RedHat 系，使用 yum 的 Linux 系统。

支持安装：`PHP 7.0/7.1/7.2/7.3/7.4`。

自动安装了一些非常常用的 PHP 扩展。

快速安装：`wget https://github.com/yurunsoft/php-env/raw/master/yum-php.sh && bash yum-php.sh`

视频教程：<https://www.bilibili.com/video/av90657235>

### `switch.sh`

切换系统内已安装的 PHP 版本

快速安装：`wget https://github.com/yurunsoft/php-env/raw/master/switch.sh && bash switch.sh`

### `php-redis.sh`

一键安装 `Redis` 扩展，自动启用 `igbinary`，支持序列化。

快速安装：`wget https://github.com/yurunsoft/php-env/raw/master/php-redis.sh && bash php-redis.sh`

### `composer.sh`

* 一键安装 Composer
* 一键配置国内镜像（阿里云、腾讯云、华为云、cnpkg）
* 一键安装 Composer 多线程加速下载包

快速安装：`wget https://github.com/yurunsoft/php-env/raw/master/composer.sh && bash composer.sh`

### `install-swoole.sh`

一键安装 `Swoole` 扩展，兼容 Ubuntu、Debian、CentOS 等系统，全能一把梭。

快速安装：`wget https://github.com/yurunsoft/php-env/raw/master/install-swoole.sh && bash install-swoole.sh`

视频教程：<https://www.bilibili.com/video/av90802466>

> 更多脚本持续更新中……
