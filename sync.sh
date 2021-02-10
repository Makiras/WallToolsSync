#!/bin/bash

storePATH="/tmp/var/www/files"
debug=0
rmcache=0

mkdir -p $storePATH
cd $storePATH

# Get Download Link

cfwLink=$(curl -q "https://github.com/Fndroid/clash_for_windows_pkg/releases/latest" | grep -Eo "https:\/\/.*[0-9]" | sed 's/tag/download/g')
cfaLink=$(curl -q "https://github.com/Kr328/ClashForAndroid/releases/latest" | grep -Eo "https:\/\/.*[0-9]" | sed 's/tag/download/g')
cfmLink=$(curl -q "https://github.com/yichengchen/clashX/releases/latest" | grep -Eo "https:\/\/.*[0-9]" | sed 's/tag/download/g')
v2nLink=$(curl -q "https://github.com/2dust/v2rayN/releases/latest" | grep -Eo "https:\/\/.*[0-9]" | sed 's/tag/download/g')
v2ngLink=$(curl -q "https://github.com/2dust/v2rayNG/releases/latest" | grep -Eo "https:\/\/.*[0-9]" | sed 's/tag/download/g')
netchLink=$(curl -q "https://github.com/NetchX/Netch/releases/latest" | grep -Eo "https:\/\/.*[0-9]" | sed 's/tag/download/g')
ssaLink=$(curl -q "https://github.com/shadowsocks/shadowsocks-android/releases/latest" | grep -Eo "https:\/\/.*[0-9]" | sed 's/tag/download/g')
sswLink=$(curl -q "https://github.com/shadowsocks/shadowsocks-windows/releases/latest" | grep -Eo "https:\/\/.*[0-9]" | sed 's/tag/download/g')

if [ $debug -eq 1 ]; then
    echo $cfwLink
    echo $cfaLink
    echo $cfmLink
fi

# Clear Histroy Cache
# Warning! It may delete files which you still need

if [ $rmcache -eq 1 ]; then
    rm -rf Clash*
    rm -rf Netch*
    rm -rf shadowsocks*
    rm -rf v2rayN*
fi

# Download Files

function getVersion(){
    echo $(echo $1 | grep -Eo "[0-9|\.]*[0-9]" | tail -1)
}

function loadClashForMac(){
    ver=$(getVersion $cfmLink)
    wget $cfmLink"/ClashX.dmg" -O "ClashX."$ver".dmg"
}

function loadClashForWindows(){
    ver=$(getVersion $cfwLink)
    archArray=("-ia32-win.7z" "-mac.7z" "-win.7z" ".dmg")
    for arch in ${archArray[@]};
    do
        wget $cfwLink"/Clash.for.Windows-"$ver$arch
    done
    wget $cfwLink"/Clash.for.Windows.Setup."$ver".exe"
    wget $cfwLink"/Clash.for.Windows.Setup."$ver".ia32.exe"
}

function loadClashForAndroid(){
    ver=$(getVersion $cfaLink)
    archArray=("arm64-v8a" "armeabi-v7a" "universal" "x86" "x86_64")
    for arch in ${archArray[@]};
    do
        wget $cfaLink"/app-"$arch"-release.apk" -O "Clash."$ver"-"$arch".apk"
    done
}

function loadV2rayN(){
    ver=$(getVersion $v2nLink)
    wget $v2nLink"/v2rayN.zip" -O "v2rayN."$ver".zip"
}

function loadV2rayNG(){
    ver=$(getVersion $v2ngLink)
    archArray=("arm64-v8a" "armeabi-v7a" "x86" "x86_64")
    for arch in ${archArray[@]};
    do
        wget $v2ngLink"/v2rayNG_"$ver"_"$arch".apk"
    done
}

function loadNetch(){
    ver=$(getVersion $netchLink)
    wget $netchLink"/Netch.7z" -O "Netch."$ver".7z"
}

function loadSSAndroid(){
    ver=$(getVersion $ssaLink)
    archArray=("arm64-v8a" "armeabi-v7a" "x86" "x86_64" "-universal")
    for arch in ${archArray[@]};
    do
        wget $ssaLink"/shadowsocks-"$arch"-"$ver".apk"
    done
}

function loadSSWindows(){
    file_name=$(curl -q $(echo $sswLink | sed 's/download/tag/g') | grep -Eo "shadowsocks-win-[0-9|.]*\.zip" | tail -n 1)
    wget $sswLink"/"$file_name
}

loadClashForMac
loadClashForWindows
loadClashForAndroid
loadV2rayN
loadV2rayNG
loadNetch
loadSSAndroid
loadSSWindows