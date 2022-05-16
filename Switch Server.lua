netcard = component.proxy("DC73C2544A7BF761FB9BED8C695A5678")

-- [3] Ficsit Storage Manager 3030

for n=1,40 do
netcard:open(n)

end
print("Ports Opened")

flag = {0}

Factory_Names = {"Storage Manager"}

print("Hub Server for Ficsit Storage Manager 3030")
print("v-0.0.3")
print("Running....")


function sleep(x)
 x = x * 1000
local millis = computer.millis()
    while computer.millis() - millis < x do
        computer.skip()
    end
end

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
    flag[port] = 1
     end
if message == "Error Fixed" then
 print(Factory_Names[port].." System : Running Normal")
 flag[port] = 0
end
end
    

end
 end --CheckNetwork


while true do
CheckNetwork()

if flag[port] == 1 then
print("Flash Light")
print("[System] : Error at "..Factory_Names[port])
end
--sleep(0.1)
end