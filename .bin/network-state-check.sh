#!/bin/bash

NET_CONNECTION="$1"

# find out the current host
if [[ "$HOST" == localhost ]]; then
	if type termux-wifi-connectioninfo 2>&1 > /dev/null; then
		CURRENT_HOST="PHONE"
	else
		exit 1
	fi
else
	CURRENT_HOST="$HOST"
fi

get_ipv4_mask(){
	ip addr | awk '{
		NON_FOUND=1
		if ($0 ~ /state UP/) {
			getline
			getline
			print $4
			NON_FOUND=0
			exit 0
		}
	}
	END{
		if (NON_FOUND){
			print "non"
		}
	}'
}

get_wifi_network(){
	connmanctl services | awk '{
		if ($0 ~ /\*/) {
			print $2
		}
	}'
}

case "$CURRENT_HOST" in
	NUC|ARCHPI)
		if [[ "$NET_CONNECTION" == "home" ]]; then
			[[ "$(get_wifi_network)" == "Behar" ]]
			exit $?
		elif [[ "$NET_CONNECTION" == hotspot ]]; then
			[[ "$(get_wifi_network)" == "DORON-hotspot" ]]
			exit $?
		fi
		;;
	PHONE)
		if [[ "$NET_CONNECTION" == "home" ]]; then
			exec $(termux-wifi-connectioninfo | jq --raw-output '.ssid == "Behar"')
		elif [[ "$NET_CONNECTION" == "hotspot" ]]; then
			[[ "$(get_ipv4_mask)" == "192.168.43.255" ]]
			exit $?
		fi
		;;
	*)
		exit 1
		;;
esac
