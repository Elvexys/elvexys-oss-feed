-- Copyright 2015 Daniel Dickinson <openwrt@daniel.thecshore.com>
-- Copyright 2018 Titouan Mesot <titouan.mesot@infoteam.ch>
-- Licensed to the public under the Apache License 2.0.

local fs = require("nixio.fs")

local m = Map("uhttpd", translate("Web interface"),
              translate("Manage web interface configuration"))

local ucs = m:section(TypedSection, "uhttpd", "")
ucs.addremove = false
ucs.anonymous = true

local cert_file = nil
local key_file = nil

ucs:tab("general", translate("Certificate Settings"))

cert_file = ucs:taboption("general", FileUpload, "cert", translate("HTTPS Certificate (DER Encoded)"))

key_file = ucs:taboption("general", FileUpload, "key", translate("HTTPS Private Key (DER Encoded)"))

o = ucs:taboption("general", Button, "remove_old", translate("Remove old certificate and key"),
                  translate("Renew self-signed certificate. Make sure you saved your configuration below before."))
o.inputstyle = "remove"

function o.write(self, section)
        if cert_file:cfgvalue(section) and fs.access(cert_file:cfgvalue(section)) then fs.unlink(cert_file:cfgvalue(section)) end
        if key_file:cfgvalue(section) and fs.access(key_file:cfgvalue(section)) then fs.unlink(key_file:cfgvalue(section)) end
        luci.sys.call("/etc/init.d/uhttpd restart")
        luci.http.redirect(luci.dispatcher.build_url("admin", "services", "uhttpd"))
end

local s = m:section(TypedSection, "cert", translate("Self-signed Certificate Parameters"),translate("Please, remember to Save & Apply before Removing old certificate"))

s.template  = "cbi/tsection"
s.anonymous = true

o = s:option(Value, "days", translate("Valid for # of Days"))
o.default = 730
o.datatype = "uinteger"

o = s:option(Value, "bits", translate("Length of key in bits"))
o.default = 2048
o.datatype = "min(2048)"

o = s:option(Value, "commonname", translate("Server Hostname"), translate("a.k.a CommonName"))
o.default = luci.sys.hostname()

o = s:option(Value, "country", translate("Country"))
o.default = "ZZ"

o = s:option(Value, "state", translate("State"))
o.default = "Unknown"

o = s:option(Value, "location", translate("Location"))
o.default = "Unknown"

return m
