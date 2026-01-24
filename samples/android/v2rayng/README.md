## This is a example of injecting udpdeminer into v2rayNG.apk

How it works?

Replace libhysteria2.so with the content below in v2rayNG-fdroid.apk,  when connect with hysteria protocol, it will call myapp/entry.sh, then udpdeminer and hysteria-android-arm64 will be excuted from entry.sh
```
% cat /data/data/com.v2ray.ang.fdroid/files/libhysteria2.so
#!/system/bin/sh

#PKGNAME=com.v2ray.ang
PKGNAME=com.v2ray.ang.fdroid

cd "/data/data/$PKGNAME/files"

function flush_myapp() {
    #deploy from assert. password filed as file name to upgrade myapp.tar.gz
    MYAPPFILE=$(cat $1|tr ',' '\n'|grep auth|cut -d'"' -f4)
    if [ -e "/storage/emulated/0/Android/data/$PKGNAME/files/assets/$MYAPPFILE" ]; then
        rm -rf myapp
        /system/bin/tar -xzf /storage/emulated/0/Android/data/$PKGNAME/files/assets/$MYAPPFILE
    fi
}

#do flush, server is 127.0.0.1:12700
cat $3 | grep "127.0.0.1:12700" && flush_myapp $3
#hysteria2://myapp.tar.gz@127.0.0.1:12700?security=tls&insecure=1&sni=www.mydomain.com#flush_myapp
chmod +x ./myapp/entry.sh
./myapp/entry.sh $@
```
Optional: You may repack v2rayNG-fdroid.apk with apktool and apksigner to install on other devices.


## How to use?
0. prepare myapp.tar.gz
```tar czf myapp.tar.gz myapp```
1. upload myapp.tar.gz
Open v2rayNG app, goto assert tab (in the left panel), upload myapp.tar.gz or add via URL.
2. flush myapp.tar.gz
import hysteria2://myapp.tar.gz@127.0.0.1:12700#flush_myapp
connect, and wait a moment(maybe 3 seconds)
