#
#Copyright (C) 2015 OpenWrt.org
#Copyright (C) 2018 Infoteam SA
#
# This is an IFT fork of the uttpd package to provide more basic configuration options


include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-uhttpd-basic
PKG_VERSION:=1.0
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/luci-app-uhttpd-basic
  SECTION:=luci
  CATEGORY:=LuCI
  SUBMENU:=3. Applications
  TITLE:=uHTTPd Basic configuration
  DEPENDS:=+uhttpd
endef

define Package/luci-app-uhttpd-basic/description
  Basic webUI to configure uHTTPd
endef

define Package/luci-app-uhttpd-basic/install
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller/uhttpd-basic
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi/uhttpd-basic
	$(INSTALL_DATA) ./files/controller/uhttpd-basic.lua $(1)/usr/lib/lua/luci/controller/uhttpd-basic/uhttpd-basic.lua
	$(INSTALL_DATA) ./files/model/uhttpd-basic.lua $(1)/usr/lib/lua/luci/model/cbi/uhttpd-basic/uhttpd-basic.lua

endef

define Build/Compile
endef

$(eval $(call BuildPackage,luci-app-uhttpd-basic))
