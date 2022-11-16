m=Map("lora-global",translate("LoRa Gateway"),translate("Here you can configure the LoRa gateway and packet forwarder"))

--
-- Global config
--
global=m:section(TypedSection,"global","Global Parameters")
global.addremove=false
global.anonymous=true

antenna = global:option(ListValue,"antenna",translate("Antenna"))
antenna.optional = false
antenna.rmempty = false
antenna.default = "5dBi"
antenna.datatype = "string"
antenna:value("5dBi",translate("5dBi Antenna"))
antenna:value("2dBi",translate("2dBi Antenna"))
antenna:value("3dBi",translate("3dBi Antenna"))
antenna:value("4dBi",translate("4dBi Antenna"))

freq_plan = global:option(DummyValue,"freq_plan",translate("Frequency plan"))
freq_plan.template = "lora/lora_view"

--
-- LoRa Gateway config for gateway_conf
--
gateway=m:section(TypedSection,"gateway","Gateway Parameters")
gateway.addremove=false
gateway.anonymous=true

gateway:tab("general",  translate("General Settings"))
gateway:tab("forward",  translate("Forward Rules"))
gateway:tab("gps", translate("GPS Settings"))
gateway:tab("beacon", translate("Beacon Settings"))

gateway_id_entry = gateway:taboption("general", DummyValue,"gateway_ID",translate("Gateway ID"))
gateway_id_entry.template = "lora/lora_view"
gateway:taboption("general", Value,"server_address",translate("Server Address"))
gateway:taboption("general", Value,"serv_port_up",translate("Server Port (Up)"))
gateway:taboption("general", Value,"serv_port_down",translate("Server Port (Down)"))
gateway:taboption("general", Value,"keepalive_interval",translate("Keep Alive Interval"))
gateway:taboption("general", Value,"push_timeout_ms",translate("Push Timeout"))

--
-- forward_crc_valid
--
forward_crc_valid = gateway:taboption("forward", ListValue,"forward_crc_valid",translate("Forward When CRC Valid"))
forward_crc_valid.optional = false
forward_crc_valid.rmempty = false
forward_crc_valid.default = true
forward_crc_valid.datatype = "bool"
forward_crc_valid:value(true, translate("True"))
forward_crc_valid:value(false, translate("False"))

--
-- forward_crc_error
--
forward_crc_error = gateway:taboption("forward", ListValue,"forward_crc_error",translate("Forward When CRC Error"));
forward_crc_error.optional = false;
forward_crc_error.rmempty = false;
forward_crc_error.default = false
forward_crc_error.datatype = "bool"
forward_crc_error:value(true, translate("True"))
forward_crc_error:value(false, translate("False"))

--
-- forward_crc_disabled
--
forward_crc_disabled = gateway:taboption("forward", ListValue,"forward_crc_disabled",translate("Forward When CRC Disabled"))
forward_crc_disabled.optional = false;
forward_crc_disabled.rmempty = false;
forward_crc_disabled.default = false
forward_crc_disabled.datatype = "bool"
forward_crc_disabled:value(true, translate("True"))
forward_crc_disabled:value(false, translate("False"))

--
-- GPS Enable
--
gps_enable = gateway:taboption("gps", ListValue,"gps_enable",translate("GPS Enable"))
gps_enable.optional = false;
gps_enable.rmempty = false;
gps_enable.default = false
gps_enable.datatype = "bool"
gps_enable:value(true, translate("True"))
gps_enable:value(false, translate("False"))

--
-- TTY path for GPS
--
gps_tty_path = gateway:taboption("gps", Value,"gps_tty_path",translate("TTY path for GPS"))
gps_tty_path.optional = true;
gps_tty_path.rmempty = true;
gps_tty_path.default = false
gps_tty_path.datatype = "string"
gps_tty_path:depends("gps_enable", "true")

--
-- GPS reference coordinates: latitude
--
gps_latitude = gateway:taboption("gps", Value,"ref_latitude",translate("GPS Reference Latitude"))
gps_latitude.optional = true;
gps_latitude.rmempty = true;
gps_latitude.default = '1.0'
gps_latitude.datatype = "float"
gps_latitude:depends("gps_enable", "true")

--
-- GPS reference coordinates: longitude
--
gps_longitude = gateway:taboption("gps", Value,"ref_longitude",translate("GPS Reference Longitude"))
gps_longitude.optional = true;
gps_longitude.rmempty = true;
gps_longitude.default = '1.0'
gps_longitude.datatype = "float"
gps_longitude:depends("gps_enable", "true")

--
-- GPS reference coordinates: altitude
--
gps_altitude = gateway:taboption("gps", Value,"ref_altitude",translate("GPS Reference Altitude"))
gps_altitude.optional = true;
gps_altitude.rmempty = true;
gps_altitude.default = '1.0'
gps_altitude.datatype = "float"
gps_altitude:depends("gps_enable", "true")

--
-- Beacon enable
--
beacon_enable = gateway:taboption("beacon", ListValue,"beacon_enable",translate("Beacon Enable"))
beacon_enable.optional = false;
beacon_enable.rmempty = false;
beacon_enable.default = false
beacon_enable.datatype = "bool"
beacon_enable:value(true, translate("True"))
beacon_enable:value(false, translate("False"))

--
-- Beacon period
--
beacon_period = gateway:taboption("beacon", Value,"beacon_period",translate("Beacon Period"), "in second")
beacon_period.optional = true;
beacon_period.rmempty = true;
beacon_period.default = '128'
beacon_period.datatype = "uinteger"
beacon_period:depends("beacon_enable", "true")

--
-- Beacon channel frequency
--
beacon_frequency = gateway:taboption("beacon", Value,"beacon_frequency",translate("Beacon Channel Frequency"), "in Hz")
beacon_frequency.optional = true;
beacon_frequency.rmempty = true;
beacon_frequency.default = '869525000'
beacon_frequency.datatype = "uinteger"
beacon_frequency:depends("beacon_enable", "true")

--
-- Beacon channel datarate
--
beacon_datarate = gateway:taboption("beacon", Value,"beacon_datarate",translate("Beacon Channel Datarate"))
beacon_datarate.optional = true;
beacon_datarate.rmempty = true;
beacon_datarate.default = '9'
beacon_datarate.datatype = "uinteger"
beacon_datarate:depends("beacon_enable", "true")

--
-- Beacon channel bandwidth
--
beacon_bandwidth = gateway:taboption("beacon", Value,"beacon_bandwidth",translate("Beacon Channel Bandwidth"), "in Hz")
beacon_bandwidth.optional = true;
beacon_bandwidth.rmempty = true;
beacon_bandwidth.default = '125000'
beacon_bandwidth.datatype = "uinteger"
beacon_bandwidth:depends("beacon_enable", "true")

--
-- Beacon signal strength
--
beacon_power = gateway:taboption("beacon", Value,"beacon_power",translate("Beacon Signal Strength"), "in dBm")
beacon_power.optional = true;
beacon_power.rmempty = true;
beacon_power.default = '14'
beacon_power.datatype = "uinteger"
beacon_power:depends("beacon_enable", "true")

--
-- Beacon info description
--
beacon_infodesc = gateway:taboption("beacon", Value,"beacon_infodesc",translate("Beacon Info Description"))
beacon_infodesc.optional = true;
beacon_infodesc.rmempty = true;
beacon_infodesc.default = '0'
beacon_infodesc.datatype = "uinteger"
beacon_infodesc:depends("beacon_enable", "true")


return m


