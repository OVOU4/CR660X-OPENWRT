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

# Default theme
#sed -i 's/luci-theme-bootstrap/luci-theme-opentomcat/g' feeds/luci/collections/luci/Makefile

#移除不需要的软件
rm -rf feeds/luci/applications/luci-app-netdata
rm -rf feeds/packages/net/smartdns
#rm -rf feeds/luci/themes/luci-theme-argon

#修正连接数（by ベ七秒鱼ベ）
sed -i '/customized in this file/a net.netfilter.nf_conntrack_max=165535' package/base-files/files/etc/sysctl.conf

# 版本号里显示一个自己的名字（ababwnq build $(TZ=UTC-8 date "+%Y.%m.%d") @ 这些都是后增加的）
# sed -i 's/OpenWrt /编译时间 $(TZ=UTC-8 date "+%Y.%m.%d") @ 洋洋姐姐 /g' package/lean/default-settings/files/zzz-default-settings
sed -i 's/OpenWrt /OpenWrt @ 洋洋姐姐 /g' package/lean/default-settings/files/zzz-default-settings

#切换ramips内核到5.15
sed -i '/KERNEL_PATCHVER/cKERNEL_PATCHVER:=5.10' target/linux/ramips/Makefile


#安装额外软件
git clone https://github.com/kongfl888/luci-app-adguardhome.git package/luci-app-adguardhome
git clone https://github.com/sirpdboy/luci-app-netdata package/luci-app-netdata
svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-app-smartdns package/luci-app-smartdns
svn co https://github.com/kenzok8/openwrt-packages/trunk/smartdns package/smartdns


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


# 添加argon-config 最新argon v1.x.x 适配18.06和Lean Openwrt
#git clone https://github.com/jerrykuku/luci-app-argon-config package/luci-app-argon-config
#svn co https://github.com/jerrykuku/luci-theme-argon/branches/18.06 package/luci-theme-argon

# 添加themes
#svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-theme-atmaterial_new package/luci-theme-atmaterial_new
#svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-theme-ifit package/luci-theme-ifit
#svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-theme-neobird package/luci-theme-neobird
#svn co https://github.com/Leo-Jo-My/luci-theme-opentomato/trunk package/luci-theme-opentomato
#svn co https://github.com/Leo-Jo-My/luci-theme-opentomcat/trunk package/luci-theme-opentomcat

# fix luci-theme-opentomcat dockerman icon missing

#rm -f package/luci-theme-opentomcat/files/htdocs/fonts/advancedtomato.woff
#cp $GITHUB_WORKSPACE/general/advancedtomato.woff package/luci-theme-opentomcat/files/htdocs/fonts
#sed -i 's/e025/e02c/g' package/luci-theme-opentomcat/files/htdocs/css/style.css
#sed -i 's/66CC00/00b2ee/g' package/luci-theme-opentomcat/files/htdocs/css/style.css
#svn co https://github.com/sirpdboy/luci-theme-opentopd/trunk package/luci-theme-opentopd
#svn co https://github.com/apollo-ng/luci-theme-darkmatter/trunk/luci/themes/luci-theme-darkmatter package/luci-theme-darkmatter
#svn co https://github.com/rosywrt/luci-theme-rosy/trunk/luci-theme-rosy package/luci-theme-rosy

# 修改makefile
#find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/include\ \.\.\/\.\.\/luci\.mk/include \$(TOPDIR)\/feeds\/luci\/luci\.mk/g' {}
#find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/include\ \.\.\/\.\.\/lang\/golang\/golang\-package\.mk/include \$(TOPDIR)\/feeds\/packages\/lang\/golang\/golang\-package\.mk/g' {}


./scripts/feeds update -a
./scripts/feeds install -a


#target=$(grep "^CONFIG_TARGET" .config --max-count=1 | awk -F "=" '{print $1}' | awk -F "_" '{print $3}')
#for configFile in $(ls target/linux/$target/config*)
#do
#    echo -e "\nCONFIG_NETFILTER_NETLINK_GLUE_CT=y" >> $configFile
#done
