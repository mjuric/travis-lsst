#!/bin/bash
#
# This script needs to be _sourced_ from travis.yml
# so $PATH is set up correctly
#

set -e

if [[ ! -f conda-lsst/.deployed ]]; then
	# Prepare conda-lsst
	rm -rf conda-lsst
	git clone https://github.com/mjuric/conda-lsst
	cd conda-lsst
	./bin/bootstrap.sh
	export PATH="$PWD/bin:$PWD/miniconda/bin:$PATH"
	hash -r
	conda config --set always_yes yes --set changeps1 no
	conda config --add channels http://eupsforge.net/conda/dev
	touch .deployed
else
	# Already here, from Travis' cache
	cd conda-lsst
	export PATH="$PWD/bin:$PWD/miniconda/bin:$PATH"
	hash -r
fi
