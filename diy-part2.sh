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

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

# 添加额外软件包
git clone https://github.com/sirpdboy/luci-app-poweroffdevice package/luci-app-poweroffdevice

# 修改连接数
#sed -i 's/net.netfilter.nf_conntrack_max=.*/net.netfilter.nf_conntrack_max=165535/g' package/kernel/linux/files/sysctl-nf-conntrack.conf
#修正连接数（by ベ七秒鱼ベ）
sed -i '/customized in this file/a net.netfilter.nf_conntrack_max=165535' package/base-files/files/etc/sysctl.conf

#git clone https://github.com/siropboy/sirpdboy-package package/sirpdboy-package

# themes添加（svn co 命令意思：指定版本如https://github）
#git clone https://github.com/xiaoqingfengATGH/luci-theme-infinityfreedom package/luci-theme-infinityfreedom
#git clone https://github.com/Leo-Jo-My/luci-theme-opentomcat.git package/luci-theme-opentomcat
#git clone https://github.com/openwrt-develop/luci-theme-atmaterial.git package/luci-theme-atmaterial
#git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon

#git clone https://github.com/sirpdboy/luci-app-netdata.git package/luci-app-netdata

#添加额外非必须软件包
#git clone https://github.com/rufengsuixing/luci-app-adguardhome.git package/luci-app-adguardhome
#git clone https://github.com/vernesong/OpenClash.git package/OpenClash
#git clone https://github.com/zzsj0928/luci-app-pushbot.git package/luci-app-pushbot
#git clone https://github.com/riverscn/openwrt-iptvhelper.git package/openwrt-iptvhelper

#添加smartdns
#git clone https://github.com/kiddin9/luci-app-dnsfilter.git package/luci-app-dnsfilter

#git clone https://github.com/pymumu/openwrt-smartdns package/smartdns
#git clone -b lede https://github.com/pymumu/luci-app-smartdns.git package/luci-app-smartdns

#./scripts/feeds update -a
#./scripts/feeds install -a
