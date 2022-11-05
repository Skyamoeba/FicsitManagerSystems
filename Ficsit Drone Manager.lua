-- Move update out of main drone station loop


Build = "0001-0201FIC-1025    "


-- Status Light #############################
PAN = {"DroneManager",0,0,1,0,40,0,1}
ConPan = 0
-- ##########################################


SiteName = "Drone Port 1"
Refresh_Rate = 1
CBeep            = false
EnableStausLight = true
AlertForAnyPWR   = true -- if this is true then any pwr issues will need change the status light, false it will not trigger onlyin the display you will see issues
EnableScreen     = true

--###### SERVER LOGGER #########
ServerLogger     = false
ServerAddress    = "DC73C2544A7BF761FB9BED8C695A5678" -- Work in progress
NetworkCard      = "989413BC4CB77125E97DC5B94290D58B" -- Work in progress
DataPort         = 3
--######################################################################################################


DronePort1  = {100 ,"Drone Port 1 " ,0,0,0,0,"DronePort1"}
DronePort2  = {6 ,"Drone Port 2 " ,0,0,0,0,"DronePort2"}


function DronePorts()
DroneStatus(0,8,DronePort1)
--DroneStatus(0,9,DronePort2)
end
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
text.text = "Drone Manager" 
end 
dev = 0
local ProgName = ("Ficsit Drone Manager 3030   ")
local By = ("Skyamoeba")
local Ver = ("1.0.0")
local currentver    = 100
local MVer = ("0.3.8")
local currentModVer = 38
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
--Battery1  = {1 ,Battery_DisplayName[1] ,0,0,0,0,Batterys_Bank[1] }



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

function SYS_SendStatus(receiver, port, data)
netcard = component.proxy(NetworkCard)
netcard:open(port)
netcard:send(receiver, port, data)
if Admin == true then print("Data Sent: "..receiver.." / "..port) end
end

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
VersionDrone= VerCheckDroneD()
VerPrint = VerCheckDroneP()

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
  ProgramStat:setcolor(1,0,0,5)
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
  text.text = "Drone Manager"
  UpdateStat:setcolor(1,1,1,0)
  IND = 1
  computer.millis(1000)
end
--event.pull(1)
end

-- Main Program Functions Go Here:

function DroneStatus(DisX,DisY,Contents) --#######################################################################################
if FLAG == 0 then
 if TEST == 1 then
  Contents[3] = 0
 end
end

function DROData()

prefix = {"DRO","LIG","SWT"}
local setupdro = {prefixcon= prefix[1], drodata=Contents[7]}
local setuppwr = {prefixpwr= prefix[3], pwrdata=Contents[7]}
local setuplig = {prefixlig= prefix[2], ligdata=Contents[7]}

DROMon = string.gsub("$prefixcon $drodata", "%$(%w+)", setupdro)
Light = string.gsub("$prefixlig $ligdata", "%$(%w+)", setuplig)
Switch = string.gsub("$prefixpwr $pwrdata", "%$(%w+)", setuppwr)

Drone = component.proxy(component.findComponent(DROMon)[1])
end

if Contents[3] == 1 then
--Sys_BatDis(DisX,DisY,Contents)
x = DisX
y = DisY

y=y+1
gpu:setForeground(0,0,0,1) gpu:setBackground(1,0,0,1)
write(2,y,Contents[2])
gpu:setForeground(0,0,0,1) gpu:setBackground(1,0,0,1)
write(77,y," Error   ")
gpu:setForeground(1,1,1,1) gpu:setBackground(0,0,0,0)
write(90,y,"Connection ")
end

if Contents[3] == 1 then else
if pcall (DROData) then

DROData()
--[[
write(37,1,"Drone Site Name : "..SiteName)
write(37,2,"Update Check      : ")
if currentver < VersionDrone then 
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
end]]--

x = DisX
y = DisY
-- Battery Functions
DroneInvOut  = Drone:getInventories()[1]
DroneInvIn   = Drone:getInventories()[2]
DroneInvBatt = Drone:getInventories()[3]
DroneStore   = Drone:getInventories()[4]
InvSumOut    = DroneInvOut.itemCount
InvSumIn     = DroneInvIn.itemCount
InvSumBatt   = DroneInvBatt.itemCount
Standby      = Drone.standby

if EnableScreen == true then
x = DisX
y = DisY
x = x + 2
y = y + 1

write(x,y,Contents[2])
x=x + 34

BattLowFlag = 0

if InvSumBatt < Contents[1] then 
 BattLowFlag = 1 gpu:setBackground(1,0,0,1) write(x,y,InvSumBatt) gpu:setForeground(1,1,1,1) gpu:setBackground(0,0,0,0)
 write(90,y,"Batt Low ")
else
 write(x,y,InvSumBatt)
end
x = x + 11
if InvSumOut == 0 then write(x,y,"Empty") else write(x,y,InvSumOut)end
x = x + 15
if InvSumIn == 0 then write(x,y,"Empty") else write(x,y,InvSumIn)end

if BattLowFlag == 1 then else
 
  if Standby == false then x = x + 15 gpu:setForeground(0,0,0,1) gpu:setBackground(0,1,0,1) write(x,y," Running  ") end
end
  if BattLowFlag == 1 then x = x + 15 gpu:setForeground(0,0,0,1) gpu:setBackground(1,1,0,1) write(x,y," Attention") BattLowFlag = 0 end


end -- EnableScreen


 else 
  FLAG = 1 print(ERR[7]..Contents[7]) Contents[3] = 1
   if ServerLogger == true then SYS_SendStatus(ServerAddress, DataPort, ERR[7]..Contents[7]) end
   end -- End to pcall (BATData)
end -- if Contents[3] == 1
if EnableScreen == true then
gpu:setForeground(1,1,1,1)
gpu:setBackground(0,0,0,0)
end
end --####################################################################################################################




-- Main Program END

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
write(x,y,"O-[ ##################### ] ----------------------------------------------------O")
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

function LineBreak(x,y)
write(x,y,"|                                 |          |              |              |            |            |            |")
end

function Sys_BatDis(x,y,Contents)
write(x,y,"O=[ Drone Port Name / Location ] =O=[ Batt ]=O=[ OutGoing ]=O=[ InComing ]=O=[ Status ]=O=[ Errors ]=O============O")
y = y + 1
LineBreak(x,y)
y = y + 1
LineBreak(x,y)
y = y + 1
LineBreak(x,y)
y = y + 1
LineBreak(x,y)
y = y + 1
LineBreak(x,y)
y = y + 1
LineBreak(x,y)
y = y + 1
LineBreak(x,y)
y = y + 1
LineBreak(x,y)
y = y + 1
LineBreak(x,y)
y = y + 1
LineBreak(x,y)
y = y + 1
LineBreak(x,y)
y = y + 1
LineBreak(x,y)
y = y + 1
LineBreak(x,y)
y = y + 1
LineBreak(x,y)
y = y + 1
LineBreak(x,y)
y = y + 1
LineBreak(x,y)
y = y + 1
LineBreak(x,y)
y = y + 1
LineBreak(x,y)
y = y + 1
LineBreak(x,y)
y = y + 1
LineBreak(x,y)
y = y + 1
LineBreak(x,y)
y = y + 1
write(x,y,"O=================================O==========O==============O==============O============O============O============O")
--gpu:flush()
end

function Sys_GridOverview(x,y)
write(x,y,"O-[ ################### ] ----------------------------------------------------------------------------------------O")
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
print("|",ProgName,"  |")
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
--UpdateChecker() #Disabled
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
 event.pull(x)
end

function ITEMLIST()
--print("Item List Empty")
DronePorts()


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
Tick = Tick + 1
gpu:flush()
-- Screen System Main P3/3 End--
end -- while true loop end