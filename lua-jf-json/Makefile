#
# Copyright (C) 2018 Infoteam.ch
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#  

include $(TOPDIR)/rules.mk

PKG_NAME:=lua-jf-json
PKG_VERSION:=20170927.26
PKG_RELEASE:=1

LUA_MODULE_PATH:=/usr/lib/lua

include $(INCLUDE_DIR)/package.mk

define Package/lua-jf-json
	SUBMENU:=Lua
	SECTION:=lang
	CATEGORY:=Languages
	TITLE:=lua-jf-json
	URL:=http://regex.info/blog/lua/json
	DEPENDS:=+lua
endef

define Package/lua-jf-json/description
	JSON for Lua by Jeffrey Friedl
endef

define Build/Compile
endef

define Package/lua-jf-json/install
	$(INSTALL_DIR) $(1)/$(LUA_MODULE_PATH)
	$(INSTALL_DATA) ./files/JSON.lua $(1)/$(LUA_MODULE_PATH)/JSON.lua
endef

$(eval $(call BuildPackage,lua-jf-json))
