#!/usr/bin/env bash

# Set our ruby paths
GEM_PATH="$(gem env gempath):$GEM_PATH"
export GEM_PATH
for path in $(echo "$GEM_PATH" | sed 's|:| |g')
do 
	export PATH="$path/bin:$PATH"
done

if [ $# -eq 0 ]
then
	cd /onepg/make_the_page/elixir_version/ || exit 1
	if [ -f /onepg/make_the_page/index.html ]
	then
		rm /onepg/make_the_page/index.html
	fi
	./onepg_ex > /dev/null 2>&1
	cat /onepg/make_the_page/index.html
else
	echo "How come things that happen to stupid people, keep happening to me?"
	exec "$@"
fi
