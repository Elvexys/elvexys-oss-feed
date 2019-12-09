#
# Copyright (C) 2017 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=packet-forwarder
PKG_VERSION:=3.1.0-wifx
PKG_RELEASE:=3

PKG_BUILD_DIR:=$(BUILD_DIR)/packet_forwarder-$(PKG_VERSION)
PKG_SOURCE:=v$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://github.com/Wifx/packet_forwarder/archive/
PKG_MD5SUM:=955fe6070481470211c62a53d593ef9f

include $(INCLUDE_DIR)/package.mk

define Package/packet-forwarder/Default
  TITLE:=Semtech packet-forwarder program
  URL:=https://github.com/Lora-net/packet_forwarder
endef

define Package/packet-forwarder
$(call Package/packet-forwarder/Default)
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=LoRaWAN
  DEPENDS:=+libloragw +librt +libuci-lua +libubox-lua +lua-jf-json +libubus-lua
endef

define Package/packet-forwarder/description
  A LoRa packet forwarder is a program running on the host of a LoRa gateway
  that forwards RF packets receive by the concentrator to a server through a
  IP/UDP link, and emits RF packets that are sent by the server.
endef

define Package/packet-forwarder-utils
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=LoRaWAN
  TITLE:=Utilities for lora pakcet forwarder
  DEPENDS:=+libloragw +packet-forwarder
endef

CFLAGS += $(FPIC) -O2 -Wall -Wextra -std=c99 -Iinc -I. -lm

define Build/Compile
	$(MAKE) CC=$(TARGET_CC) LGW_PATH=$(BUILD_DIR)/lora_gateway-4.1.3-wifx/libloragw -C $(PKG_BUILD_DIR)
endef

define Package/packet-forwarder/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/lora_pkt_fwd/lora_pkt_fwd $(1)/usr/sbin
	$(INSTALL_BIN) ./files/gen_lora_global_conf $(1)/usr/sbin
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/lora_pkt_fwd.init $(1)/etc/init.d/lora_pkt_fwd
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/lora-global.config $(1)/etc/config/lora-global
	$(INSTALL_DIR) $(1)/etc/lora
	$(INSTALL_CONF) ./files/global_conf_EU868_2dBi_indoor.json $(1)/etc/lora
	$(INSTALL_CONF) ./files/global_conf_US915_2dBi_indoor.json $(1)/etc/lora
	$(INSTALL_CONF) ./files/global_conf_AU915_2dBi_indoor.json $(1)/etc/lora
	$(INSTALL_CONF) ./files/global_conf_EU868_4dBi_outdoor.json $(1)/etc/lora
	$(INSTALL_CONF) ./files/global_conf_US915_4dBi_outdoor.json $(1)/etc/lora
	$(INSTALL_CONF) ./files/global_conf_AU915_4dBi_outdoor.json $(1)/etc/lora
	$(INSTALL_DIR) $(1)/etc/hotplug.d/net
	$(INSTALL_BIN)  ./files/99-lora-pkt-fwd-net-reload $(1)/etc/hotplug.d/net/99-lora-pkt-fwd-net-reload
endef

define Package/packet-forwarder-utils/install
	$(INSTALL_DIR) $(1)/root/packet_forwarder
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/util_ack/util_ack $(1)/root/packet_forwarder
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/util_sink/util_sink $(1)/root/packet_forwarder
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/util_tx_test/util_tx_test $(1)/root/packet_forwarder
endef

$(eval $(call BuildPackage,packet-forwarder))
$(eval $(call BuildPackage,packet-forwarder-utils))
