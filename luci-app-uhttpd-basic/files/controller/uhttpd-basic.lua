-- Copyright 2015 Daniel Dickinson <openwrt@daniel.thecshore.com>
-- Copyright 2018 Titouan Mesot <titouan.mesot@infoteam.ch>
-- Licensed to the public under the Apache License 2.0.

module("luci.controller.uhttpd-basic.uhttpd-basic", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/uhttpd") then
		return
	end

	local page

	page = entry({"admin", "services", "uhttpd"}, cbi("uhttpd-basic/uhttpd-basic"), _("Web interface"))
	page.leaf = true

end
