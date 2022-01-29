#!/data/data/com.termux/files/usr/bin/bash

cd ~ && cd ~ && cd ~ && cd ~ && cd ~ && cd ~

#安装依赖
apt update
apt install wget proot pulseaudio tar -y
apt install wget proot pulseaudio tar -y
apt install wget proot pulseaudio tar -y
apt install wget proot pulseaudio tar -y

#检测是否已安装
folder=ubuntu-fs
if [ -d "$folder" ]; then
        first=1
        echo "FUCK your ubuntu-fs"                              
fi

#检测是否获取SD卡权限
if [ -n "storage" ]; then
        echo "FUCK YOU STORAGE"
        echo "FUCK YOU STORAGE"
        echo "FUCK YOU STORAGE"
        echo "termux-setup-storage"
fi

#检测是否使用的是F-droid的termux

if [ -n "storage" ]; then
     echo "FUCK your play store TERMUX"
     echo "FUCK your play store TERMUX"
fi

tarball="ubuntu.tar.xz"
if [ "$first" != 1 ]; then
        if [ ! -f $tarball ]; then
                echo "开始安装ubuntu21.10" 
#确认架构
archurl=arm64
echo "你手机的架构为:"
read $archurl
if [ "$archurl" = arm64 ]; then
        echo "正式开始安装"
	echo "check archurl...done"
else
	echo "FUCK your archurl"
	echo "FUCK your phone"
	exit 1
	exit 1
	exit 1
fi          
wget "https://mirrors.tuna.tsinghua.edu.cn/ubuntu-cdimage/ubuntu-base/releases/21.10/release/ubuntu-base-21.10-base-arm64.tar.gz" -O $tarball
        fi
        cur=`pwd`
        mkdir -p "$folder"
        cd "$folder"
        echo "正在解压."
        proot --link2symlink tar -zxvf ${cur}/${tarball}||:
        cd "$cur"
fi
mkdir -p ubuntu-binds
touch start-ubuntu.sh                               
cat > start-ubuntu.sh <<- EOM
cd \$(dirname \$0)
## unset LD_PRELOAD in case termux-exec is installed
unset LD_PRELOAD
command="proot"
command+=" --link2symlink"
command+=" -0"
command+=" -r $folder"
if [ -n "\$(ls -A ubuntu-binds)" ]; then                                                                                                         for f in ubuntu-binds/* ;do
      . \$f
    done
fi
command+=" -b /dev"                       
command+=" -b /proc"
command+=" -b ubuntu-fs/root:/dev/shm"
## uncomment the following line to have access to the home directory of termux
#command+=" -b /data/data/com.termux/files/home:/root"
## uncomment the following line to mount /sdcard directly to /
#command+=" -b /sdcard"
command+=" -w /root"
command+=" /usr/bin/env -i"
command+=" HOME=/root"
command+=" PATH=/usr/local/sbin:/usr/local/bin:/bin:/usr/bin:/sbin:/usr/sbin:/usr/games:/usr/local/games"
command+=" TERM=\$TERM"
command+=" LANG=zh_CN.UTF-8"
command+=" /bin/bash --login"
com="\$@"
if [ -z "\$1" ];then
    exec \$command
else
    \$command -c "\$com"
fi
EOM

echo "正在设置…"
termux-fix-shebang start-ubuntu.sh
echo "写入ubuntu启动脚本"
chmod +x start-ubuntu.sh
echo "删除镜像文件中..."
rm $tarball
echo "你现在可以用 ./start-ubuntu.sh 来启动Ubuntu系统了!如发现bug请联系QQ:1065259859 再见!"

#换源,折磨up主
cd ~ && cd ~ && cd ~
rm -rf ubuntu-fs/etc/apt/sources.list
cd ubuntu-fs/etc/apt/
touch sources.list
cd ~ && cd ~ && cd ~
echo "deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ impish main restricted universe multiverse" > ubuntu-fs/etc/apt/sources.list
echo "# deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ impish main restricted universe multiverse" > ubuntu-fs/etc/apt/sources.list
echo "#deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ impish-updates main restricted universe multiverse" > ubuntu-fs/etc/apt/sources.list
echo "# deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ impish-updates main restricted universe multiverse" > ubuntu-fs/etc/apt/sources.list
echo "deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ impish-backports main restricted universe multiverse" > ubuntu-fs/etc/apt/sources.list
echo "# deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ impish-backports main restricted universe multiverse" > ubuntu-fs/etc/apt/sources.list
echo "deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ impish-security main restricted universe multiverse" > ubuntu-fs/etc/apt/sources.list
echo "# deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ impish-security main restricted universe multiverse" > ubuntu-fs/etc/apt/sources.list
#考虑到可能https源会出错,所以暂时用http源,先安装CA证书再切换https源
