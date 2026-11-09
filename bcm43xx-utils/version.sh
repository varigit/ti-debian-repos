#!/bin/bash

# Only the VAR-SOM-AM62 scripts from the TI BSP are required.
export git_repo="https://github.com/varigit/meta-variscite-bsp-ti"

git_archive_paths=(
	"recipes-connectivity/bcm43xx-utils/bcm43xx-utils/am62x-var-som/bcm43xx-wifi"
	"recipes-connectivity/bcm43xx-utils/bcm43xx-utils/am62x-var-som/bcm43xx-bt"
	"recipes-core/udev/udev-extraconf/am62x-var-som/38-var-ttyBT.rules"
)
