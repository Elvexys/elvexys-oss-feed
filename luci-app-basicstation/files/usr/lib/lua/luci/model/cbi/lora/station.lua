local fs = require "nixio.fs"
m=Map("station",translate("Basicstation"),translate("Here you can configure the Semtech basicstation"))

function string.tohex(str)
    return (str:gsub('.', function (c)
        return string.format('0x%02X ', string.byte(c))
    end))
end

--
-- Global Parameters
--
global=m:section(TypedSection,"global","Global Parameters")
global.addremove=false
global.anonymous=true

antenna = global:option(ListValue,"antenna",translate("Antenna"))
antenna.optional = false
antenna.rmempty = false
antenna.default = "4dBi_outdoor"
antenna.datatype = "string"
antenna:value("4dBi_outdoor",translate("4dBi Outdoor Antenna"))
antenna:value("2dBi_indoor",translate("2dBi Indoor Antenna"))

freq_plan = global:option(DummyValue,"freq_plan",translate("Frequency plan"))
freq_plan.template = "lora/lora_view"

gateway_id_entry = global:option(DummyValue,"gateway_ID",translate("Gateway ID"))
gateway_id_entry.template = "lora/lora_view"

--
-- LNS Server Configuration
--
local lns = m:section(NamedSection, "tc", "server", translate("LNS Server"))
lns.addremove = true
lns.anonymous = false

--
-- LNS Server URI
--
local lns_uri = lns:option(Value, "uri", translate("URI"))
lns_uri.optional = false;
lns_uri.rmempty = true;

--
-- LNS Server Port
--
local lns_port = lns:option(Value, "port", translate("Port"))
lns_port.optional = false;
lns_port.rmempty = true;

--
-- LNS Authentication Mode
--
local lns_auth_mode = lns:option(ListValue, "auth_mode", translate("Authentication Mode"))
lns_auth_mode:value("none", "No Authentication")
lns_auth_mode:value("tls-server", "TLS Server Authentication")
lns_auth_mode:value("tls-server-client", "TLS Server and Client Authentication")
lns_auth_mode:value("tls-server-token", "TLS Server Authentication and Client Token")


--
-- LNS Server CA Certificate
--
local lns_trust = lns:option(TextValue, "_trust", translate("Server’s CA certificate"))
lns_trust.wrap = "off"
lns_trust.rows = 4
lns_trust:depends("auth_mode", "tls-server")
lns_trust:depends("auth_mode", "tls-server-client")
lns_trust:depends("auth_mode", "tls-server-token")

function lns_trust.cfgvalue()
	return fs.readfile("/etc/station/tc.trust") or ""
end

function lns_trust.write(self, section, value)
	if value then
		fs.writefile("/etc/station/tc.trust", value:gsub("\r\n", "\n"))
		m:set(section, "trust", "/etc/station/tc.trust")
	end
end

function lns_trust.remove(self, section)
	fs.remove("/etc/station/tc.trust")
	m:del(section, "trust")
end

--
-- LNS Station Certificate
--
local lns_crt = lns:option(TextValue, "_crt", translate("Station’s Own Certificate"))
lns_crt.wrap = "off"
lns_crt.rows = 4
lns_crt:depends("auth_mode","tls-server-client")

function lns_crt.cfgvalue()
	return fs.readfile("/etc/station/tc.crt") or ""
end

function lns_crt.write(self, section, value)
	if value then
		fs.writefile("/etc/station/tc.crt", value:gsub("\r\n", "\n"))
		m:set(section, "crt", "/etc/station/tc.crt")
	end
end

function lns_crt.remove(self, section)
	fs.remove("/etc/station/tc.crt")
	m:del(section, "crt")
end

--
-- LNS Station Private Key
--
local lns_key = lns:option(TextValue, "_key", translate("Station’s Private Key"))
lns_key.wrap = "off"
lns_key.rows = 4
lns_key:depends("auth_mode","tls-server-client")

function lns_key.cfgvalue()
	return fs.readfile("/etc/station/tc.crt") or ""
end

function lns_key.write(self, section, value)
	if value then
		fs.writefile("/etc/station/tc.key", value:gsub("\r\n", "\n"))
		m:set(section, "key", "/etc/station/tc.key")		
	end
end

function lns_key.remove(self, section)
	fs.remove("/etc/station/tc.key")
	m:del(section, "key")
end

--
-- LNS Station Token
--
local lns_token = lns:option(Value, "token", translate("Station's Token"))
lns_token:depends("auth_mode","tls-server-token")

return m
