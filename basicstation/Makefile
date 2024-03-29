#
# Copyright (C) 2019 Xue Liu <liuxuenetmail@gmail>
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=basicstation
PKG_VERSION:=2.0.5
PKG_REV:=9bcdf0e12e4568e96011a3910e6d460ec9384f8c
PKG_RELEASE:=3

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL=https://github.com/xueliu/basicstation.git
PKG_SOURCE_VERSION:=$(PKG_REV)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_REV).tar.gz

PKG_MAINTAINER:=Xue Liu <liuxuenetmail@gmail>
PKG_LICENSE:=BSD

ifeq ($(SUBTARGET),wifx_l1)
  HW_FOLDER:=wifx_l1
else
  HW_FOLDER:=lorix_one
endif

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/basicstation
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=LoRaWAN
  TITLE:=a LoRaWAN Gateway implementation from Semtech
  DEPENDS:= +libmbedtls
endef

define Package/basicstation/config
	source "$(SOURCE)/Config.in"
endef

define Package/basicstation/description
  Basic Station is an implementation of a LoRa packet forwarder,
  which is a program running on the host of a LoRa gateway (with or 
  without GPS), forwarding RF packets received by the 
  concentrator (uplinks) to a LoRaWAN Network Server (LNS) 
  through some secured IP link and transmitting RF packets sent by the 
  LNS (downlinks) through the same secured IP to some device.
endef

# set additional CMake options
CMAKE_OPTIONS += -Dbasicstation_VERSION_SHORT=$(PKG_VERSION)
CMAKE_OPTIONS += -Dbasicstation_VERSION_FULL=$(PKG_VERSION)
CMAKE_OPTIONS += -DPLATFORM:STRING=$(CONFIG_GATEWAY_PLATFORM)

define Package/basicstation/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/station* $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/crc32 $(1)/usr/sbin/crc32
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/genkwcrcs $(1)/usr/sbin/genkwcrcs

	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/station.init $(1)/etc/init.d/station

	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_DATA) ./files/$(HW_FOLDER)/station.config $(1)/etc/config/station

	$(INSTALL_DIR) $(1)/etc/station
	$(INSTALL_CONF) -D ./files/$(HW_FOLDER)/station_*.conf $(1)/etc/station
	
	$(INSTALL_DIR) $(1)/etc/hotplug.d/net
	$(INSTALL_BIN)  ./files/99-basic-station-net-reload $(1)/etc/hotplug.d/net/99-basic-station-net-reload
endef

$(eval $(call BuildPackage,basicstation))
