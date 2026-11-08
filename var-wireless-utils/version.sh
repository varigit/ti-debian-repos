#!/bin/bash

# Only archive the files needed by this package, rather than the full BSP layer.
export git_repo="https://github.com/varigit/meta-variscite-bsp-common"

git_archive_paths=(
	"recipes-connectivity/var-wireless-utils/var-wireless-utils"
)
