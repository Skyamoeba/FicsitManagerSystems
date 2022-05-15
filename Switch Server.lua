netcard = component.proxy("DC73C2544A7BF761FB9BED8C695A5678")

-- [3] Ficsit Storage Manager 3030

for n=1,40 do
netcard:open(n)

end
print("Ports Opened")

flag = {0,""}

Factory_Names = {"Storage","Storage","Storage","Storage"}

wire = {"IronPlates","IronRods","Wire","Cable"}

print("Switch Server for Ficsit Storage Manager 3030")
print("v-0.0.3")
print("Running....")


function sleep(x)
 x = x * 1000
local millis = computer.millis()
    while computer.millis() - millis < x do
        computer.skip()
    end
end

function EXT_Connection(Switch,State)
function Connection_GPwrSwitch()
Comp = component.proxy(component.findComponent(Switch)[1])
end -- END Connection_GPwrSwitch()
Connection_GPwrSwitch()
Comp.isSwitchOn = State
--ReturnState = Comp.isBridgeActive
--return ReturnState
end -- END EXT_Connection


function CheckNetwork()
    --event.listen(netcard)
    e, s, sender, port, message = event.pull()
    if e == "NetworkMessage" then
sender = "Storage"
        print(sender.." | " .. port.." | ".. message)
--if sender == "Copper Factory" then Factory_Copper = message end
if sender == "Storage" then
 if message == "Error" then
   computer.beep(1)
   flag[1] = 1
end
if message == wire[port] then
 EXT_Connection(wire[port],true)
print("Switch On")
end
if message ==  wire[port].." Full" then
 EXT_Connection(wire[port],false)
print("Switch Off")
end
end
    

end
 end

function CheckIronPlates()
    --event.listen(netcard)
    e, s, sender, port, message = event.pull()
    if e == "NetworkMessage" then
sender = Factory_Names[port]
        print(sender.." | " .. port.." | ".. message)
--if sender == "Copper Factory" then Factory_Copper = message end
if sender == "Storage" then
 if message == "Error" then
   computer.beep(1)
   flag[1] = 1
end
if message == "IronPlates" then
 EXT_Connection("IronPlates",true)
print("Switch On")
end
if message ==  "IronPlates Full" then
 EXT_Connection("IronPlates",false)
print("Switch Off")
end
end
    

end
 end




while true do
CheckNetwork()
--CheckIronPlates()

if flag[1] == 1 then
print("Flash Light")
print("[System] : Error at : "..Factory_Names[port])
end
--sleep(0.1)
end