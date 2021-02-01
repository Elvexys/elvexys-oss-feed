module("luci.controller.lora.station",package.seeall)

function index()
    entry({"admin","lorawan","station"}, cbi("lora/station"),_("LoRaWAN Basic station"),99).index=true
end
