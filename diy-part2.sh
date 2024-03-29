#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# 删除自定义源默认的 argon 主题
rm -rf package/lean/luci-theme-argon
# 拉取 argon 原作者的源码
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/lean/luci-theme-argon
# 替换默认主题为 luci-theme-argon
sed -i 's/luci-theme-bootstrap/luci-theme-argon/' feeds/luci/collections/luci/Makefile

# 修改mt7620 固件配置文件
mv $GITHUB_WORKSPACE/images/openwrt_mt7620.mk target/linux/ramips/image/mt7620.mk
# psg1218 修改启用USB
mv $GITHUB_WORKSPACE/images/openwrt_mt7620a_phicomm_k2x.dtsi target/linux/ramips/dts/mt7620a_phicomm_k2x.dtsi
# psg1218 修改为16M内存
mv $GITHUB_WORKSPACE/images/openwrt_mt7620a_phicomm_psg1218a.dts target/linux/ramips/dts/mt7620a_phicomm_psg1218a.dts
# sed -i 's/0x7b0000/0xfb0000/g' target/linux/ramips/dts/mt7620a_phicomm_psg1218a.dts

#删除默认密码
sed -i "/CYXluq4wUazHjmCDBCqXF/d" package/lean/default-settings/files/zzz-default-settings

#修改wifi信息
sed -i 's/OpenWrt/HOME/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
sed -i 's/none/*123qweASD*/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh


# Modify default IP
sed -i 's/192.168.1.1/192.168.123.1/g' package/base-files/files/bin/config_generate
