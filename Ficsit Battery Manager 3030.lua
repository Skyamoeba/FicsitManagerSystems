Build = "0001-0201FIC-1025    "


-- Status Light #############################
STA = "StatusLight"
PAN = {"BatteryManager",0,0,1,0,40,0,1}
ConPan = 0
-- ##########################################


SiteName = "Battery Storage 1"
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

Power_Monitor = "PWRIncoming" --State the network connection for the incoming power

Batterys_Bank = {"StoreBank1","","","","","","","","","","","","","","","","","","",""}


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
text.text = "Battery Manager"
end
dev = 0
local ProgName = ("Ficsit Battery Manager 3030   ")
local By = ("Skyamoeba")

local Ver = ("1.0.0")
local currentver    = 100
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

--Error Handler for the batterys
Battery1  = {1 ,Batterys_Bank[1] ,0,0,0,0,Batterys_Bank[1] }
Battery2  = {1 ,Batterys_Bank[2] ,0,0,0,0,Batterys_Bank[2] }
Battery3  = {1 ,Batterys_Bank[3] ,0,0,0,0,Batterys_Bank[3] }
Battery4  = {1 ,Batterys_Bank[4] ,0,0,0,0,Batterys_Bank[4] }
Battery5  = {1 ,Batterys_Bank[5] ,0,0,0,0,Batterys_Bank[5] }
Battery6  = {1 ,Batterys_Bank[6] ,0,0,0,0,Batterys_Bank[6] }
Battery7  = {1 ,Batterys_Bank[7] ,0,0,0,0,Batterys_Bank[7] }
Battery8  = {1 ,Batterys_Bank[8] ,0,0,0,0,Batterys_Bank[8] }
Battery9  = {1 ,Batterys_Bank[9] ,0,0,0,0,Batterys_Bank[9] }
Battery10 = {1 ,Batterys_Bank[10],0,0,0,0,Batterys_Bank[10]}
Battery11 = {1 ,Batterys_Bank[11],0,0,0,0,Batterys_Bank[11]}
Battery12 = {1 ,Batterys_Bank[12],0,0,0,0,Batterys_Bank[12]}
Battery13 = {1 ,Batterys_Bank[13],0,0,0,0,Batterys_Bank[13]}
Battery14 = {1 ,Batterys_Bank[14],0,0,0,0,Batterys_Bank[14]}
Battery15 = {1 ,Batterys_Bank[15],0,0,0,0,Batterys_Bank[15]}
Battery16 = {1 ,Batterys_Bank[16],0,0,0,0,Batterys_Bank[16]}
Battery17 = {1 ,Batterys_Bank[17],0,0,0,0,Batterys_Bank[17]}
Battery18 = {1 ,Batterys_Bank[18],0,0,0,0,Batterys_Bank[18]}
Battery19 = {1 ,Batterys_Bank[19],0,0,0,0,Batterys_Bank[19]}
Battery20 = {1 ,Batterys_Bank[20],0,0,0,0,Batterys_Bank[20]}

--Error handler for the power monitor
PWRIncoming  = {1 ,"",0,0,0,0,Power_Monitor}

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

local req = card:request("https://raw.githubusercontent.com/Skyamoeba/FicsitNetworksPrograms-/main/Ver.lua", "GET", "")
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
  text.text = "Battery Manager"
  UpdateStat:setcolor(1,1,1,0)
  IND = 1
  computer.millis(1000)
end
--event.pull(1)
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


function PWRStatus(Contents) --########################################################################################
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
--battery stats on pwr network
TotalPwr   = Circuit.batteryStorePercent
BatInput   = Circuit.batteryIn
BatOutput  = Circuit.batteryOut

end


if Contents[3] == 1 then else
if pcall (PWRData) then

PWRData()

write(37,1,"Battery Site Name : "..SiteName)
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

write(37,4,"Production   : "..round(Production))
write(37,5,"Consumption  : "..round(Consumption))

write(87,1,"Total Stored : [        ]")


if RoundDP(TotalPwr,0) == 0         then write(103,1,"        ") end
if RoundDP(TotalPwr,0) == 100.0 then gpu:setForeground(0,1,0,1) write(110,1,"=")end
if RoundDP(TotalPwr,0) > 87.5  then gpu:setForeground(0,1,0,1) write(109,1,"=")end
if RoundDP(TotalPwr,0) > 75.0  then gpu:setForeground(0,1,0,1) write(108,1,"=")end
if RoundDP(TotalPwr,0) > 62.5  then gpu:setForeground(1,1,0,1) write(107,1,"=")end
if RoundDP(TotalPwr,0) > 50.0  then gpu:setForeground(1,1,0,1) write(106,1,"=")end
if RoundDP(TotalPwr,0) > 37.5  then gpu:setForeground(1,1,0,1) write(105,1,"=")end
if RoundDP(TotalPwr,0) > 25.0  then gpu:setForeground(1,0,0,1) write(104,1,"=")end
if RoundDP(TotalPwr,0) > 12.5  then gpu:setForeground(1,0,0,1) write(103,1,"=") end
gpu:setForeground(1,1,1,1)
gpu:setBackground(0,0,0,0)


write(87,2,"% Stored     : "..RoundDP(TotalPwr,0).."%")
write(87,3,"Battery In   : "..round(BatInput))
write(87,4,"Battery Out  : "..round(BatOutput))
write(87,5,"Fuse Status  : [        ]")

if Fused == true then 
gpu:setForeground(1,0,0,1)
write(103,5,"===//===")
FLAG = 1
else 
gpu:setForeground(0,1,0,1)
write(103,5,"========")
if AlertForAnyPWR == false then FLAG = 0 end
ProgramStat:setColor(0.0, 10.0, 0.0,10.0)
end
  else FLAG = 1 print(ERR[6]..Contents[7]) Contents[3] = 1
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


function BatStatus(DisX,DisY,Contents) --#######################################################################################
if FLAG == 0 then
 if TEST == 1 then
  Contents[3] = 0
 end
end

function BATData()

prefix = {"BAT","LIG","SWT"}
local setupbat = {prefixcon= prefix[1], batdata=Contents[7]}
local setuppwr = {prefixpwr= prefix[3], pwrdata=Contents[7]}
local setuplig = {prefixlig= prefix[2], ligdata=Contents[7]}

BATMon = string.gsub("$prefixcon $batdata", "%$(%w+)", setupbat)
Light = string.gsub("$prefixlig $ligdata", "%$(%w+)", setuplig)
Switch = string.gsub("$prefixpwr $pwrdata", "%$(%w+)", setuppwr)

battery = component.proxy(component.findComponent(BATMon)[1])
end

if Contents[3] == 1 then
--Sys_BatDis(DisX,DisY,Contents)
x = DisX
y = DisY

y=y+1
gpu:setBackground(1,0,0,1)
write(2,y,Contents[2])
gpu:setForeground(1,1,1,1) gpu:setBackground(1,0,0,1)
write(84,y," Error       ")
gpu:setForeground(1,1,1,1) gpu:setBackground(0,0,0,0)
write(100,y,"Connection ")
end

if Contents[3] == 1 then else
if pcall (BATData) then

BATData()
x = DisX
y = DisY
-- Battery Functions
Stored     = battery.powerStore -- Shows Stored Percentage
--StoredPer  = battery.powerStorePercent -- shows something else dont know what
TimeFull   = battery.timeUntilFull -- Time till full in Secs
TimeEmpty  = battery.timeUntilEmpty -- Time till Empty In Secs
Incoming   = battery.powerIn -- Shows the power coming in for charging
Outgoing   = battery.powerOut -- Shows the power going out
Capacity   = battery.powerCapacity -- Shows Battery Capacity
Status     = battery.batteryStatus -- Shows the state the battery is in values 0 - 4 (see below for what the output number means)

if EnableScreen == true then
x = DisX
y = DisY
x = x + 2
y = y + 1

write(x,y,Contents[2])
x=x + 41
write(x,y,round(Stored).."%")
x = x + 13
if Status == 3 then write(x,y,round(TimeFull))
elseif Status == 4 then write(x,y,round(TimeEmpty))
else write(x,y,"N/A") end
x = x + 16
write(x,y,round(Incoming))

if Status == 0 then x = x + 12 gpu:setForeground(0,0,0,1) gpu:setBackground(1,1,0,0.5) write(x,y," Idle        ") end
if Status == 1 then x = x + 12 gpu:setForeground(0,0,0,1) gpu:setBackground(1,1,0,0.5) write(x,y," Idle Empty  ") end
if Status == 2 then x = x + 12 gpu:setForeground(0,0,0,1) gpu:setBackground(0,1,0,0.5) write(x,y," Idle Full   ") end
if Status == 3 then x = x + 12 gpu:setForeground(0,0,0,1) gpu:setBackground(0,1,1,0.5) write(x,y," Charging    ") end
if Status == 4 then x = x + 12 gpu:setForeground(0,0,0,1) gpu:setBackground(1,0,0,0.5) write(x,y," In Use      ") end

end -- EnableScreen

--BATExample()
 else 
  FLAG = 1 print(ERR[7]..Contents[7]) Contents[3] = 1
   if ServerLogger == true then SYS_SendStatus(ServerAddress, DataPort, ERR[7]..Contents[7]) end
   end -- End to pcall (BATData)
end -- if Contents[3] == 1
if EnableScreen == true then
gpu:setForeground(1,1,1,1)
gpu:setBackground(0,0,0,0)
end
end --BatStatus() ####################################################################################################################

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
write(x,y,"O-[ Power / Batt Overview ] ----------------------------------------------------O")
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
write(x,y,"O=[ Battery Name ] ==================O=[ Stored ]=O=[ Time E/F ]=O=[ Consuption ]=O=[ Status ]====O=[ Errors ]====O")
y = y + 1
write(x,y,"|                                    |            |              |                |               |               |")
y = y + 1
write(x,y,"|                                    |            |              |                |               |               |")
y = y + 1
write(x,y,"|                                    |            |              |                |               |               |")
y = y + 1
write(x,y,"|                                    |            |              |                |               |               |")
y = y + 1
write(x,y,"|                                    |            |              |                |               |               |")
y = y + 1
write(x,y,"|                                    |            |              |                |               |               |")
y = y + 1
write(x,y,"|                                    |            |              |                |               |               |")
y = y + 1
write(x,y,"|                                    |            |              |                |               |               |")
y = y + 1
write(x,y,"|                                    |            |              |                |               |               |")
y = y + 1
write(x,y,"|                                    |            |              |                |               |               |")
y = y + 1
write(x,y,"|                                    |            |              |                |               |               |")
y = y + 1
write(x,y,"|                                    |            |              |                |               |               |")
y = y + 1
write(x,y,"|                                    |            |              |                |               |               |")
y = y + 1
write(x,y,"|                                    |            |              |                |               |               |")
y = y + 1
write(x,y,"|                                    |            |              |                |               |               |")
y = y + 1
write(x,y,"|                                    |            |              |                |               |               |")
y = y + 1
write(x,y,"|                                    |            |              |                |               |               |")
y = y + 1
write(x,y,"|                                    |            |              |                |               |               |")
y = y + 1
write(x,y,"|                                    |            |              |                |               |               |")
y = y + 1
write(x,y,"|                                    |            |              |                |               |               |")
y = y + 1
write(x,y,"|                                    |            |              |                |               |               |")
y = y + 1
write(x,y,"O====================================O============O==============O================O===============O===============O")
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
write(0,0,"Ficsit Battery Manager 3030   ")
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

function ITEMLIST()
if PWRIncoming == "" then print("[System] : Power Probe Not Setup") else PWRStatus(PWRIncoming) end
-- Bank 1
if Batterys_Bank[1] == "" then else BatStatus(0,8,Battery1) end
if Batterys_Bank[2] == "" then else BatStatus(0,9,Battery2) end
if Batterys_Bank[3] == "" then else BatStatus(0,10,Battery3) end
if Batterys_Bank[4] == "" then else BatStatus(0,11,Battery4) end
if Batterys_Bank[5] == "" then else BatStatus(0,12,Battery5) end
if Batterys_Bank[6] == "" then else BatStatus(0,13,Battery6) end
if Batterys_Bank[7] == "" then else BatStatus(0,14,Battery7) end
if Batterys_Bank[8] == "" then else BatStatus(0,15,Battery8) end
if Batterys_Bank[9] == "" then else BatStatus(0,16,Battery9) end
if Batterys_Bank[10] == "" then else BatStatus(0,17,Battery10) end
if Batterys_Bank[11] == "" then else BatStatus(0,18,Battery11) end
if Batterys_Bank[12] == "" then else BatStatus(0,19,Battery12) end
if Batterys_Bank[13] == "" then else BatStatus(0,20,Battery13) end
if Batterys_Bank[14] == "" then else BatStatus(0,21,Battery14) end
if Batterys_Bank[15] == "" then else BatStatus(0,22,Battery15) end
if Batterys_Bank[16] == "" then else BatStatus(0,23,Battery16) end
if Batterys_Bank[17] == "" then else BatStatus(0,24,Battery17) end
if Batterys_Bank[18] == "" then else BatStatus(0,25,Battery18) end
if Batterys_Bank[19] == "" then else BatStatus(0,26,Battery19) end
if Batterys_Bank[20] == "" then else BatStatus(0,27,Battery20) end

end --## ITEM LIST ############################################

--##########################################################################################################
  function MainLoop() if EnableScreen == true then clearScreen() end 
--##########################################################################################################
-- ** Add your containers to the erro check incase of accedential disconnection so the program can keep on *
SystemInfo(0,0) -- Default 83,0

Sys_OverView(34,0)
Sys_GridOverview(0,30)
Sys_BatDis(0,7)
ITEMLIST()

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