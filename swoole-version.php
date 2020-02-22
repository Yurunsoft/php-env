#!/usr/bin/env php
<?php
function getReleases()
{
    static $maxRetry = 3;
    $retryCount = 0;
    do {
        if($retryCount > 0)
        {
            echo '请求版本列表失败，重试第 ', $retryCount, ' 次', PHP_EOL;
            sleep(1);
        }
        $content = @file_get_contents('https://api.github.com/repos/swoole/swoole-src/releases', false, stream_context_create([
            'http'=>[
                'method'    =>  'GET',
                'header'    =>  <<<HEADER
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/82.0.4051.0 Safari/537.36
HEADER
            ],
            'ssl'   =>  [
                'verify_peer'       =>  false,
                'verify_peer_name'  =>  false,
            ]
        ]));
        if($content)
        {
            break;
        }
        ++$retryCount;
    } while($retryCount <= $maxRetry);
    return json_decode($content, true);
}
$releases = getReleases();
if($releases)
{
    echo "\033[32mSwoole 最新发布的 5 个版本：\033[0m", PHP_EOL;
    for($i = 0; $i < 5; ++$i)
    {
        if(!isset($releases[$i]))
        {
            break;
        }
        echo $releases[$i]['name'], PHP_EOL;
    }
}
else
{
    echo "\033[31mError: 获取 Swoole 最新版本失败\033[0m", PHP_EOL;
}

// echo PHP_EOL, "\033[32m请输入您想要安装的版本（不用带v开头，如果直接回车，则安装最新的版本）：\033[0m";

// $input = trim(fgets(STDIN));
// if('' === $input)
// {
//     if(!isset($releases[0]))
//     {
//         echo "\033[31mError: 获取 Swoole 最新版本失败\033[0m", PHP_EOL;
//         exit;
//     }
//     $version = $releases[0]['name'];
// }
// else
// {
//     $version = 'v' . $input;
// }

// $downloadUrl = 'https://github.com/swoole/swoole-src/archive/' . $version . '.tar.gz';
// $savePath = __DIR__ . '/swoole.tar.gz';
// $downloadScript = <<<SCRIPT
// if (type wget >/dev/null 2>&1); then
//     echo "\033[32m正在使用 wget 下载 Swoole {$version}...\033[0m"
//     wget -O {$savePath} {$downloadUrl}
// elif (type curl >/dev/null 2>&1); then
//     echo "\033[32m正在使用 curl 下载 Swoole {$version}...\033[0m"
//     curl -o {$savePath} {$downloadUrl}
// else
//     echo "\033[31mError: 没有找到 wget / curl\033[0m"
//     exit 1
// fi
// tar -xzf {$savePath}
// rm {$savePath}
// SCRIPT;

// echo `{$downloadScript}`;

// $compilePath = __DIR__ . '/swoole-src-' . substr($version, 1);
// if(!is_dir($compilePath))
// {
//     echo "\033[31mError: 下载或解压失败\033[0m", PHP_EOL;
//     exit;
// }

// $installScript = <<<SCRIPT
// cd {$compilePath}
// phpize
// ./configure
// SCRIPT;
