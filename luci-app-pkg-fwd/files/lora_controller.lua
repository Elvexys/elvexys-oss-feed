
module("luci.controller.lora.lora-pkt-fwd",package.seeall)

function index()
    entry({"admin", "lorawan"}, firstchild(), _("LoRaWAN"), 50).index = true
    entry({"admin","lorawan","lora-pkt-fwd"}, cbi("lora/lora_gateway"),_("LoRa Gateway"),99).index=true
end
