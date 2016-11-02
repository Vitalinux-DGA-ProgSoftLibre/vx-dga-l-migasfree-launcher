#!/bin/bash

if which purge-old-kernels &> /dev/null ; then
	echo "--> Van a eliminarse kernels antiguos si los hubiera ..."
	purge-old-kernels --assume-yes
fi