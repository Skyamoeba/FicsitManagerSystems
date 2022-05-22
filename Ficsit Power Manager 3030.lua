--https://raw.githubusercontent.com/Skyamoeba/FicsitManagerSystems/main/Ver.lua

Build = "0001-0201FIC-1025    "


-- Status Light #############################
STA = "StatusLight"
PAN = {"PowerManager",0,0,1,0,40,0,1}
ConPan = 0
-- ##########################################


SiteName = "Power Manager"
Refresh_Rate = 1
--FicsItNetworksVer= "0.2.1"
CBeep            = false
EnableStausLight = true
AlertForAnyPWR   = true -- if this is true then any pwr issues will need change the status light, false it will not trigger onlyin the display you will see issues
EnableScreen     = true

-- Local Network Settings
ServerLogger     = false
ServerAddress    = "DC73C2544A7BF761FB9BED8C695A5678" -- Work in progress
NetworkCard      = "989413BC4CB77125E97DC5B94290D58B" -- Work in progress
DataPort         = 3
--###### End Of LNS ######

Power_Monitor  = "PWRIncoming" --State the network connection for the incoming power
Power_Main     = {1 ,"Building 1      ",0,0,0,0,"PowerMain"}
Power_Transport= {1 ,"Building 1      ",0,0,0,0,"PowerTransport"}
Power_Battery  = {1 ,"Building 1      ",0,0,0,0,"PowerBattery"}
Power_HyperTube= {1 ,"Building 1      ",0,0,0,0,"PowerHypertube"}


function ITEMLIST()
if PWRIncoming == "" then print("[System] : Power Probe Not Setup") else PWRStatus(22,PWRIncoming) end

end --## ITEM LIST ############################################

--############################################################################
-- Anything after this point you should not have to change.
-- The program will let you know if anything will need updating above.





-- System Screen Sys P1/3 #############################################################################--
if EnableScreen == true then 
SystemScreenSys = {"System Screen Sys Ver: ","1.0.1"}
gpu = computer.getPCIDevices(findClass("GPU_T1_C"))[1]
screen = computer.getPCIDevices(findClass("FINComputerScreen"))[1]
gpu:bindScreen(screen)
w,h = gpu:setSize(115,40) --
end
-- System Screen System P1/3 End --

SAT = {true, false}
ERR = {"[System] : Error Detected Starting Self Check ", 
       "[System] : Starting Self Test ", 
       "[ERROR]  : Connection Error For Container: ", 
       "[ERROR]  : Connection Error For Light: ", 
       "[ERROR]  : Connection Error For Power Switch: ",
       "[ERROR]  : Connection Error For Power Monitor: ",
       "[ERROR]  : Connection Error For Battery : "}

SYS = {"[System] : Light Poles Disabled",
       "[System] : Power Poles Disabled",
       "[System] : Control Panel Lights Disabled", 
       "[System] : Computer Screen Disabled"}
FLAG = 0
TEST = 0
IND = 0
ChkDis = false
if EnableStausLight == true then
StatusPanel = component.proxy(component.findComponent(PAN[1])[1]) 
ProgramStat = StatusPanel:getModule(PAN[2],PAN[3])
UpdateStat = StatusPanel:getModule(PAN[7],PAN[8])
text = StatusPanel:getModule(PAN[4],PAN[5])
text.size = PAN[6]
text.text = "Power Manager"
end
dev = 0
local ProgName = ("Ficsit Power Manager 3030     ")
local By = ("Skyamoeba")

local Ver = ("0.0.1")
local currentver    = 1
local MVer = ("0.3.7")
local currentModVer = 37
local BFlag = 0
Page = 0
fCont = {0,0,0,0,0,0,0,0,0,0,0}
Tick = 0
Loop = 0
Days = 0
Hrs = 0
Mins = 0
Sec = 0
Cat = 0


--Error handler for the power monitor
PWRIncoming  = {1 ,"MainPower",0,0,0,0,Power_Monitor}

-- Screen System Main P2/3 ############################################################################-- 
--print(SystemScreenSys[1]..SystemScreenSys[2])
function clearScreen() -- Issue #8
  gpu:setForeground(1,1,1,1)
  gpu:setBackground(0,0,0,0)
  gpu:fill(0,0,200,55," ")
  --gpu:flush()
  return w,h
end

function textCol(x,y,z,i)
gpu:setBackground(0,0,0,0)
gpu:setForeground(x,y,z,i)
end

function write(x,y,z)
gpu:setText(x,y,z)
end

function clearLoc(x,y,z)
gpu:setBackground(0,0,0,0)
gpu:setForeground(1,1,1,1)  
gpu:setText(x,y,z)
end

function LayoutMode(X,Y)
textCol(1,0,0,1) 
write(X,Y,"#") 
gpu:setForeground(1,1,1,1)
gpu:setBackground(0,0,0,0)
end


-- Screen System Main  P2/3 End --


--local Network 
function SYS_SendStatus(receiver, port, data)
netcard = component.proxy(NetworkCard)
netcard:open(port)
netcard:send(receiver, port, data)
if Admin == true then print("Data Sent: "..receiver.." / "..port) end
end
-- end Local Network

-- Update Checker (part of boot up)
function UpdateChecker()
if Debug == true then print("System - Checking For Internet Card") end
local card = computer.getPCIDevices(findClass("FINInternetCard"))[1]
if not card then
  print("[ERROR] - No internet-card found! Please install a internet card!")
  computer.beep(0.2)
  return
end

local req = card:request("https://raw.githubusercontent.com/Skyamoeba/FicsitManagerSystems/main/Ver.lua", "GET", "")
local _, Ver = req:await()
filesystem.initFileSystem("/dev")
filesystem.makeFileSystem("tmpfs", "tmp")
filesystem.mount("/dev/tmp","/")
local file = filesystem.open("Ver.lua", "w")
file:write(Ver)
file:close()
filesystem.doFile("Ver.lua")

ModVersion = MODVerD()
ModVerPrint= MODVerP()
VersionBatt= VerCheckBattD()
VerPrint = VerCheckBattP()

if currentModVer < ModVersion then
print("[FINSYS] : Update Avliable for Ficsit Networks")
else
print("[FINSYS] : Latest MOD Version Installed")
end

if ModVersion < currentModVer then
print("[FINSYS] : Program has not been tested on this FIN Version : "..MVer)
end

--if VersionBatt > currentver then
-- print("[System] - Update Avliable")
--else
-- print("[System] - Latest Version Installed")
--end

end
--End Of Updater









--- LightStatus Pole V2 ---
LightSys = {"Light System Ver : ","2.0.1"}
function LightSPL(LightNumber,RED,GREEN,BLUE,INTENSITY,Contents)

if FLAG == 0 then
 if TEST == 1 then
  Contents[4] = 0
 end
end

function LigData() 
ContLight = component.proxy(component.findComponent(LightNumber)[1])
end

if Contents[4] == 1 then else
  if pcall (LigData) then
   LigData()
   ContLight:setColor(RED,GREEN,BLUE,INTENSITY)
  else 
   FLAG = 1 print(ERR[4]..Contents[7]) Contents[4] = 1 end
  end
end

function Blink(r,g,b)
if IND == 1 then 
  ProgramStat:setcolor(1,0,0,10.0)
  if CBeep == true then computer.beep() end
  IND = 0
  computer.millis(1000)
else
  ProgramStat:setcolor(1,1,1,0)
  IND = 1
  computer.millis(1000)
end
--event.pull(1)
end

function UpdateBlink()
if IND == 1 then 
  UpdateStat:setcolor(1,1,0,10)
  text.text = VerPrint.." Update"
  if CBeep == true then computer.beep() end
  IND = 0
  computer.millis(1000)
else
  text.text = "Power Manager"
  UpdateStat:setcolor(1,1,1,0)
  IND = 1
  computer.millis(1000)
end
--event.pull(1)
end

function UpdateDisplay()
write(37,1,"Storage Site Name : "..SiteName)
write(37,2,"Update Check      : ")
if currentver < VersionBatt then 
gpu:setForeground(0,0,0,1)
gpu:setBackground(1,1,0,1)
write(57,2,""..VerPrint.." Update Aviliable")
UpdateBlink()
gpu:setForeground(1,1,1,1)
gpu:setBackground(0,0,0,0)
else
gpu:setForeground(0,0,0,1)
gpu:setBackground(0,1,0,1)
write(57,2,"Program Up-To-Date")
UpdateStat:setcolor(1,1,1,0)
gpu:setForeground(1,1,1,1)
gpu:setBackground(0,0,0,0)
end

write(37,3,"Mod Update Check  : ")
if currentModVer < ModVersion then 
gpu:setForeground(0,0,0,1)
gpu:setBackground(1,1,0,1)
write(57,3,""..ModVerPrint.." Update Aviliable")
--UpdateBlink()
gpu:setForeground(1,1,1,1)
gpu:setBackground(0,0,0,0)
else
gpu:setForeground(0,0,0,1)
gpu:setBackground(0,1,0,1)
write(57,3,"MOD Up-To-Date")
gpu:setForeground(1,1,1,1)
gpu:setBackground(0,0,0,0)
end
end

--- Power Conections / Monitoring ---
PowerSys = {"Power System Ver : ","4.0.2"}
function Connection(x,y,Contents)
if FLAG == 0 then
 if TEST == 1 then
  Contents[5] = 0
  end
end

function GPwrSwitch()
Comp = component.proxy(component.findComponent(x)[1])
print(Comp)
end


if Contents[5] == 1 then else
if pcall (GPwrSwitch) then

GPwrSwitch()

Comp.isSwitchOn = y

else 
 FLAG = 1 print(ERR[5]..Contents[7]) Contents[5] = 1 
end
end

end --Function Connection End

function CheckConnected(x,y)
Comp = component.proxy(PWR[x])
ChkDis = Comp:isConnected()
end

function GetPowerData(Connection)
powermonpole = component.proxy(component.findComponent(Connection)[1]) -- Name your power poll
connector = powermonpole:getPowerConnectors()[1]
circuit = connector:getCircuit()
end

function RoundDP(num, dp)
    local mult = 10^(dp or 0)
    num = num * 100
    return math.floor(num * mult + 0.5)/mult
end


function PWRStatus(DisY,Contents) --########################################################################################
DisX = 2
if FLAG == 0 then
 if TEST == 1 then
  Contents[3] = 0
 end
end

function PWRData()
prefix = {"MON","LIG","SWT"}
local setupcon = {prefixcon= prefix[1], condata=Contents[7]}
local setuppwr = {prefixpwr= prefix[3], pwrdata=Contents[7]}
local setuplig = {prefixlig= prefix[2], ligdata=Contents[7]}

PWRMon = string.gsub("$prefixcon $condata", "%$(%w+)", setupcon)
Light = string.gsub("$prefixlig $ligdata", "%$(%w+)", setuplig)
Switch = string.gsub("$prefixpwr $pwrdata", "%$(%w+)", setuppwr)

powermonpole = component.proxy(component.findComponent(PWRMon)[1])
connector = powermonpole:getPowerConnectors()[1]
Circuit = connector:getCircuit()

Production = Circuit.production 
Capacity   = Circuit.capacity
Consumption= Circuit.consumption
Fused      = Circuit.isFuesed
end


if Contents[3] == 1 then else
if pcall (PWRData) then

PWRData()

x = DisX
y = DisY
Production = Circuit.production 
Capacity   = Circuit.capacity
Consumption= Circuit.consumption
Fused      = Circuit.isFuesed

x = DisX
y = DisY
x = x + 2
y = y + 1

write(2,y,round(Production))
y = y + 1
write(x,y,round(Capacity))
y = y + 1
write(x,y,round(Consumption))
y = y + 1
write(x,y,"Fuse Status: ")

if Fused == true then 
gpu:setForeground(1,0,0,1)
gpu:setBackground(1,0,0,1)
x = x + 13
write(x,y,"###")
FLAG = 1
else 
gpu:setForeground(0,1,0,1)
gpu:setBackground(0,1,0,1)
x = x + 13
write(x,y,"###")
if AlertForAnyPWR == false then FLAG = 0 end
-- Flash Light / Sound
end
end
  --else FLAG = 1 print(ERR[6]..Contents[7]) Contents[3] = 1
 end
end
gpu:setForeground(1,1,1,1)
gpu:setBackground(0,0,0,0)
end



function PWRBackUp(DisX,DisY,Contents)
if FLAG == 0 then
 if TEST == 1 then
  Contents[3] = 0
 end
end

function PWRData()
prefix = {"BCK","LIG","SWT"}
local setupcon = {prefixcon= prefix[1], condata=Contents[7]}
local setuppwr = {prefixpwr= prefix[3], pwrdata=Contents[7]}
local setuplig = {prefixlig= prefix[2], ligdata=Contents[7]}

PWRMon = string.gsub("$prefixcon $condata", "%$(%w+)", setupcon)
Light = string.gsub("$prefixlig $ligdata", "%$(%w+)", setuplig)
Switch = string.gsub("$prefixpwr $pwrdata", "%$(%w+)", setuppwr)

powermonpole = component.proxy(component.findComponent(PWRMon)[1])
connector = powermonpole:getPowerConnectors()[1]
Circuit = connector:getCircuit()

Production = Circuit.production 
Capacity   = Circuit.capacity
Consumption= Circuit.consumption
Fused      = Circuit.isFuesed

end
if Contents[3] == 1 then else
if pcall (PWRData) then

PWRData()

x = DisX
y = DisY

if EnableScreen == true then 
write(x,y, "O-------------------------------O")
y = y + 1
write(x,y,"|                                |")
y = y + 1
write(x,y,"|                                |")
y = y + 1
write(x,y,"|                                |")
y = y + 1
write(x,y,"|                                |")
y = y + 1
write(x,y,"O--------------------------------O")

x = DisX
y = DisY
x = x + 2
y = y + 1

write(x,y,Contents[2])
y = y + 1
write(x,y,"Consuption : "..round(Consumption))
y = y + 1
write(x,y,"Threshold  : "..Contents[1])
y = y + 1
write(x,y,"Active     : ")

 if Consumption > Contents[1] then
  Connection(Switch,true, Contents)
  gpu:setForeground(0,1,0,1)
  gpu:setBackground(0,1,0,1)
  x = x + 13
  write(x,y,"###")
 else
  Connection(Switch,false, Contents)
  gpu:setForeground(1,0,0,1)
  gpu:setBackground(1,0,0,1)
  x = x + 13
  write(x,y,"###") end

    
  end
else FLAG = 1 print(ERR[6]..Contents[7]) Contents[3] = 1
 end
end

gpu:setForeground(1,1,1,1)
gpu:setBackground(0,0,0,0)
end -- PWRData()


--- Power Connections End ---



function SystemInfo(DisX,DisY) --83 0
textCol(1,1,1,1)
x = DisX
y = DisY

write(DisX,y,"O================================#")
y = y +1
write(DisX,y,"| "..ProgName)
y = y +1
write(DisX,y,"| By : "..By)
y = y +1
write(DisX,y,"| Prg Ver : "..Ver)
y = y +1
write(DisX,y,"| Mod Ver : "..MVer)
y = y +1
write(DisX,y,"| Run Time: "..Days.." | "..Hrs.." : "..Mins.." : "..Sec)
y = y +1
write(DisX,y,"O================================O")


x = x + 33
y = DisY + 1
write(x,y,"|")
y = y + 1
write(x,y,"|")
y = y + 1
write(x,y,"|")
y = y + 1
write(x,y,"|")
y = y + 1
write(x,y,"|")-- +33
textCol(1,1,1,1)
end

function Sys_OverView(x,y)
write(x,y,"O-[ System Overview ] ----------------------------------------------------------O")
y = y + 1
write(x,y,"|                                                                               |")
y = y + 1
write(x,y,"|                                                                               |")
y = y + 1
write(x,y,"|                                                                               |")
y = y + 1
write(x,y,"|                                                                               |")
y = y + 1
write(x,y,"|                                                                               |")
y = y + 1
write(x,y,"O-------------------------------------------------------------------------------O")
end

function Sys_BatDis(x,y,Contents)
write(x,y,"O=[ Circuit Name ] ==================O=[ Prod ]=O=[ Time E/F ]=O=[ Consuption ]=O=[ Status ]====O=[ Errors ]======O")
y = y + 1
write(x,y,"|                                    |          |              |                |               |                 |")
y = y + 1
write(x,y,"|                                    |          |              |                |               |                 |")
y = y + 1
write(x,y,"|                                    |          |              |                |               |                 |")
y = y + 1
write(x,y,"|                                    |          |              |                |               |                 |")
y = y + 1
write(x,y,"|                                    |          |              |                |               |                 |")
y = y + 1
write(x,y,"|                                    |          |              |                |               |                 |")
y = y + 1
write(x,y,"|                                    |          |              |                |               |                 |")
y = y + 1
write(x,y,"|                                    |          |              |                |               |                 |")
y = y + 1
write(x,y,"|                                    |          |              |                |               |                 |")
y = y + 1
write(x,y,"|                                    |          |              |                |               |                 |")
y = y + 1
write(x,y,"|                                    |          |              |                |               |                 |")
y = y + 1
write(x,y,"|                                    |          |              |                |               |                 |")
y = y + 1
write(x,y,"|                                    |          |              |                |               |                 |")
y = y + 1
write(x,y,"|                                    |          |              |                |               |                 |")
y = y + 1
write(x,y,"|                                    |          |              |                |               |                 |")
y = y + 1
write(x,y,"|                                    |          |              |                |               |                 |")
y = y + 1
write(x,y,"|                                    |          |              |                |               |                 |")
y = y + 1
write(x,y,"|                                    |          |              |                |               |                 |")
y = y + 1
write(x,y,"|                                    |          |              |                |               |                 |")
y = y + 1
write(x,y,"|                                    |          |              |                |               |                 |")
y = y + 1
write(x,y,"|                                    |          |              |                |               |                 |")
y = y + 1
write(x,y,"O====================================O==========O==============O================O===============O=================O")
--gpu:flush()
end

function Sys_GridOverview(x,y)
write(x,y,"O-[ Power Grid Overview ] ----------------------------------------------------------------------------------------O")
y = y + 1
write(x,y,"|                                                                                                                 |")
y = y + 1
write(x,y,"|                                                                                                                 |")
y = y + 1
write(x,y,"|                                                                                                                 |")
y = y + 1
write(x,y,"|                                                                                                                 |")
y = y + 1
write(x,y,"|                                                                                                                 |")
y = y + 1
write(x,y,"|                                                                                                                 |")
y = y + 1
write(x,y,"|                                                                                                                 |")
y = y + 1
write(x,y,"|                                                                                                                 |")
y = y + 1
write(x,y,"O=================================================================================================================O")
--gpu:flush()
end

-- Boot Loop -- Add anything thats needs to be loaded before the main loop here
function Boot()
if BFlag == 0 then
clearScreen()
write(0,0,ProgName)
write(0,1,"Prg Ver : "..Ver)
write(0,2,"Mod Ver : "..MVer)
write(0,3,"Build   : "..Build)
gpu:flush()
print("O--------------------------------O")
print("|",ProgName,"|")
print("| By : "..By,"                |")
print("| Prg Ver : "..Ver,"               |")
print("| Mod Ver : "..MVer,"               |")
print("| Build   : "..Build.."|")
print("O--------------------------------O")

if dev == 1 then
print("Item List Ver    : ".. ListVer[1])
if EnableScreen == false then print(SYS[4]) else print(SystemScreenSys[1]..SystemScreenSys[2]) end
end
BFlag = 1
if EnableStausLight == true then ProgramStat:setColor(10.0, 0.0, 10.0,5.0) end
print("[System] : Checking For Errors / Updates")
UpdateChecker()
sleep(5)
if STA == "" then print("[System] : Program needs setting up") else print("[System] : Boot Ok!") end
 end
end
-- End of Boot Loop --################################################################################

function DisplayAmmounts(Name, RReact, LocX, LocY)
    textCol(1,1,1,1)
    write(LocX,LocY,Name)
end

function round(x)
local f = math.floor(x)
 if (x == f) or (x % 2.0 == 0.5) then 
  return f
 else 
  return math.floor(x + 0.5)
 end
end

function sleep(x)
 --event.pull(x)
 x = x * 1000
local millis = computer.millis()
    while computer.millis() - millis < x do
        computer.skip()
    end
end


--##########################################################################################################
  function MainLoop() if EnableScreen == true then clearScreen() end 
--##########################################################################################################
-- ** Add your containers to the erro check incase of accedential disconnection so the program can keep on *
SystemInfo(0,0) -- Default 83,0

Sys_OverView(34,0)
Sys_GridOverview(0,30)
Sys_BatDis(0,7)
ITEMLIST()
UpdateDisplay()

if Cat == 0 then
Cat = 1
else
Cat = 0
end

Loop = Loop + 1

if Tick == 255 then
 Sec = Sec + 1
 Tick = 0
end

if Sec == 60 then
 Mins = Mins + 1
Sec = 0
end

if Mins == 60 then
 Hrs = Hrs + 1
 Mins = 0
end

if Hrs == 24 then
 Days = Days + 1
 Hrs = 0
end
  
--##########################################################################################################
end
--##########################################################################################################

function selfTest()
  if EnableStausLight == true then ProgramStat:setColor(10.0, 0.0, 0.0,10.0) end
  print(ERR[2])
  FLAG = 0
  TEST = 1
end


while true do
write(0,0,"Booting System Up")
--computer.reset()
Boot()
--print(FLAG)
MainLoop()

--ErrorBoxDis(0,50)
  if EnableStausLight == true then
   if FLAG == 0 then ProgramStat:setColor(0.0, 10.0, 0.0,1) end
    if FLAG == 1 then Blink() end
  end
    
if FLAG == 1 then if Sec == 30 then selfTest() end else TEST = 0 end

-- Screen System Main P3/3 ##############################################################################--
if EnableScreen == true then gpu:flush() end
sleep(Refresh_Rate)
Sec = Sec + 1
--Tick = Tick + 1
gpu:flush()
-- Screen System Main P3/3 End--
end -- while true loop end