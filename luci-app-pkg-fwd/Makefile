#
# Copyright (C) 2017 Xue Liu <liuxuenetmail@gmail.com>
#
# This is free software, licensed under the GNU General Public License v2.

include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-pkt-fwd
PKG_VERSION:=1.2
PKG_RELEASE:=4

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

ifeq ($(SUBTARGET),wifx_l1)
  HW_FOLDER:=wifx_l1
else
  HW_FOLDER:=lorix_one
endif

include $(INCLUDE_DIR)/package.mk

define Package/luci-app-pkt-fwd
	SECTION:=luci
	CATEGORY:=LuCI
	SUBMENU:=3. Applications
	TITLE:=Semtech LoRa Packet Forward Configuration Interface
	PKGARCH:=all
	DEPENDS:=@PACKAGE_packet-forwarder||@PACKAGE_sx1302_hal-utils
endef

define Build/Compile
endef

define Package/luci-app-pkt-fwd/install
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller/lora
	$(INSTALL_DATA) ./files/global/lora_controller.lua $(1)/usr/lib/lua/luci/controller/lora/lora-pkt-fwd.lua
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi/lora
	$(INSTALL_DATA) ./files/$(HW_FOLDER)/lora_model.lua $(1)/usr/lib/lua/luci/model/cbi/lora/lora_gateway.lua
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/view/lora
	$(INSTALL_DATA) ./files/global/lora_view.htm $(1)/usr/lib/lua/luci/view/lora/lora_view.htm
endef

$(eval $(call BuildPackage,luci-app-pkt-fwd))
