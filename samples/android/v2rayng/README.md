## This is a example of injecting udpdeminer into v2rayNG-1.x.apk

#### How it works?

Replace libhysteria2.so, when connect with hysteria protocol, then udpdeminer and hysteria-android-arm64 will be triggered.

Checkout libhysteria2.so to customize your code.

```
cat /path/to/udpdeminer-binary/samples/android/v2rayng/lib/arm64-v8a/libhysteria2.so
```
#### Notice:
Some build-in busybox does not support awk, RANDOM, <<<
You can repack v2rayNG-fdroid.apk to install on other devices.
