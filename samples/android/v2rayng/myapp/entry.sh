#!/system/bin/sh
ORIGINAL_ARGS="$@"
cd $(dirname $0)

kill -9 $(pidof udpdeminer-aarch64-linux-android)
chmod +x bin/*

function patch_config() {
	##Do patching

	#Start udpdeminer
	if grep -q "ipv6" <<< "$1";then
		source ./etc/ipv6.env
		./bin/udpdeminer-aarch64-linux-android -l 12740 -s 2001::1 -p 443 --hookpath ./bin/ipv6hook.sh &
	else
		source ./etc/ipv4.env
		./bin/udpdeminer-aarch64-linux-android -l 12740 -s 127.0.0.1 -p 12750 --outbound 0.0.0.0 --hookpath ./bin/ipv4hook.sh &
	fi
}

cat $3 | grep "127.0.0.1:1274" && start_myapp
patch_config $3

killall hysteria-android-arm64
exec ./bin/hysteria-android-arm64 $ORIGINAL_ARGS
