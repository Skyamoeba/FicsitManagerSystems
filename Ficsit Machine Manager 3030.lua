Build = "0000-0201FIC-1025    "


-- Status Light #############################
PAN = {"MachineManager",0,0,1,0,40,0,1}
ConPan = 0
-- ##########################################


SiteName = "Machine Manager 1"
Refresh_Rate = 1
CBeep            = false
EnableStausLight = true
AlertForAnyPWR   = true -- if this is true then any pwr issues will need change the status light, false it will not trigger onlyin the display you will see issues
EnableScreen     = true
setup            = false

--###### SERVER LOGGER #########
ServerLogger     = false
ServerAddress    = "DC73C2544A7BF761FB9BED8C695A5678" -- Work in progress
NetworkCard      = "989413BC4CB77125E97DC5B94290D58B" -- Work in progress
DataPort         = 3
--######################################################################################################

Miner        = {100 ,"Miner       " ,0,0,0,0,"Miner"}
Smelter      = {100 ,"Smelter     " ,0,0,0,0,"Smelter"}
Foundry      = {100 ,"Foundry     " ,0,0,0,0,"Foundry"}
Constructor  = {100 ,"Constructor " ,0,0,0,0,"Constructor"}
Assembler    = {100 ,"Assembler   " ,0,0,0,0,"Assembler"}
Manufacture  = {100 ,"Manufacture " ,0,0,0,0,"Manufacture"}
Packager     = {100 ,"Packager    " ,0,0,0,0,"Packager"}
Refinery     = {100 ,"Refinery    " ,0,0,0,0,"Refinery"}
Blender      = {100 ,"Blender     " ,0,0,0,0,"Blender"}
ParticleAcc  = {100 ,"Particle Acc" ,0,0,0,0,"ParticleAcc"}
OilExtractor = {100 ,"OilExtractor" ,0,0,0,0,"OilExtractor"}
ResourceWell = {100 ,"Resource Well" ,0,0,0,0,"ResourceWell"}

Concrete = {100 ,"Refinery 2" ,0,0,0,0,"Concrete2"}


function MachineList()
--MachineStatus(0,8,Miner,false,false,true)
--MachineStatus(0,9,Smelter,false,false)
--MachineStatus(0,10,Foundry,false,false)
--MachineStatus(0,11,Constructor,true,false)
--MachineStatus(0,12,Assembler,false,false)
--MachineStatus(0,13,Manufacture,false,false)
--MachineStatus(0,14,Packager,false,false)
MachineStatus(0,15,Concrete,true,false)
--MachineStatus(0,16,Blender,false,false)
--MachineStatus(0,17,ParticleAcc,false,false)
--MachineStatus(0,18,OilExtractor,false,false,true)
--MachineStatus(0,19,ResourceWell,false,false,true)
end
--############################################################################
-- Anything after this point you should not have to change.
-- The program will let you know if anything will need updating above.





-- System Screen Sys P1/3 #############################################################################--
if EnableScreen == true then 
gpu = computer.getPCIDevices(findClass("GPU_T1_C"))[1]
screen = computer.getPCIDevices(findClass("FINComputerScreen"))[1]
gpu:bindScreen(screen)
w,h = gpu:setSize(115,40) --
end
-- System Screen System P1/3 End --

SAT = {true, false}
SYS_Stat = {" [INFO  ] ",
            " [System] ",
            " [Error ] ",
            " [  On  ] "}


ERR = {"[System] : Error Detected Starting Self Check ", 
       "[System] : Starting Self Test ", 
       "[ERROR]  : Connection Error For Container: ", 
       "[ERROR]  : Connection Error For Light: ", 
       "[ERROR]  : Connection Error For Power Switch: ",
       "[ERROR]  : Connection Error For Power Monitor: ",
       "[ERROR]  : Connection Error For Machine : "}

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
text.text = "Machine Manager"


end 

dev = 0
local ProgName = ("Ficsit Machine Manager 3030 ")
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
VersionMachine= VerCheckMachineD()
VerPrint = VerCheckMachineP()

if currentModVer < ModVersion then
print("[FINSYS] : Update Avliable for Ficsit Networks")
else
print("[FINSYS] : Latest MOD Version Installed")
end

if ModVersion < currentModVer then
print("[FINSYS] : Program has not been tested on this FIN Version : "..MVer)
end
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
  text.text = "Machine Manager"
  UpdateStat:setcolor(1,1,1,0)
  IND = 1
  computer.millis(1000)
end
--event.pull(1)
end

-- Main Program Functions Go Here:

function MachineStatus(DisX,DisY,Contents,HSwitch,HLight,Miner) --#######################################################################################
if FLAG == 0 then
 if TEST == 1 then
  Contents[3] = 0
 end
end

local function Round(x)
local f = math.floor(x)
 if (x == f) or (x % 2.0 == 0.5) then --(x % 2.0 == 0.5)
  return f
 else 
  return math.floor(x + 0.05)
 end
end

function MACData()

prefix = {"MAC","LIG","PWR"}
local setupmac = {prefixcon= prefix[1], macdata=Contents[7]}
local setuppwr = {prefixpwr= prefix[3], pwrdata=Contents[7]}
local setuplig = {prefixlig= prefix[2], ligdata=Contents[7]}

MACMon = string.gsub("$prefixcon $macdata", "%$(%w+)", setupmac)
Light = string.gsub("$prefixlig $ligdata", "%$(%w+)", setuplig)
Switch = string.gsub("$prefixpwr $pwrdata", "%$(%w+)", setuppwr)

Machine = component.proxy(component.findComponent(MACMon)[1])
if HSwitch == true then PwrSwitch = component.proxy(component.findComponent(Switch)[1]) SwitchD = PwrSwitch.isBridgeActive end

end

if Contents[3] == 1 then
--Sys_BatDis(DisX,DisY,Contents)
x = DisX
y = DisY

y=y+1
gpu:setForeground(0,0,0,1) gpu:setBackground(1,0,0,0.5)
write(2,y,Contents[2])
gpu:setForeground(0,0,0,1) gpu:setBackground(1,0,0,0.5)
write(67,y,SYS_Stat[3])
gpu:setForeground(1,1,1,1) gpu:setBackground(0,0,0,0)
write(80,y,"Connection ")
end

if Contents[3] == 1 then else
if pcall (MACData) then

MACData()

write(37,1,"Machine Site Name : "..SiteName)
write(37,2,"Update Check      : ")
if currentver < VersionMachine then 
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



x = DisX
y = DisY
-- Battery Functions
Progress    = Machine.progress
Consumption = Machine.powerConsumProducing
ProdEff     = Machine.productivity
CycleTime   = Machine.cycletime
--MaxPoten    = Machine.maxPotential
--MinPoten    = Machine.minPotential
Standby     = Machine.standby

if Miner == true then else
Poten       = Machine.potential
RawRecipe   = Machine:getRecipe()
Rname       = RawRecipe.name -- Gets the name of the Recipe being used
InventoryIn = Machine:getInputInv()
InventoryOut= Machine:getOutputInv()
InputCon = InventoryIn.itemCount
OutputCon= InventoryOut.itemCount
end

PPercent = Progress *100/1 -- Sorts the percentages out for progress
ProdEf   = ProdEff *100/1 -- Sorts the percentages out for Production Efficency

if EnableScreen == true then
x = DisX
y = DisY
x = x + 2
y = y + 1

write(x,y,Contents[2]) 

x=x + 34

write(x,y,Round(PPercent))
x = x + 11
write(x,y,Round(Consumption))
x = x + 10
write(x,y,Round(ProdEf))
if Miner == true then write(80,y,"Mining") else write(80,y,Rname) end

if HSwitch == false then 
x = x + 10
if Standby == true then 
gpu:setForeground(0,0,0,1) gpu:setBackground(1,1,0,1)
write(x,y," [ INFO ] ")
gpu:setForeground(1,1,1,1) gpu:setBackground(0,0,0,0)
write(80,y,"Machine Switch Is Set to Standby ")
else
gpu:setForeground(0,0,0,1) gpu:setBackground(0,1,0,1) 
write(x,y,SYS_Stat[4]) 
end 
end


if HSwitch == true then
x = x + 10
 if SwitchD == false then
gpu:setForeground(0,0,0,1) gpu:setBackground(1,1,0,1) 
write(x,y," [ INFO ] ") 
gpu:setForeground(1,1,1,1) gpu:setBackground(0,0,0,0)
   write(80,y,"Assigned External Switch is Off  ")
  elseif 
   Standby == true then gpu:setForeground(0,0,0,1) gpu:setBackground(1,1,0,1) write(x,y," [ INFO ] ")
   gpu:setForeground(1,1,1,1) gpu:setBackground(0,0,0,0)
   write(80,y,"Machine Switch Is Set to Standby ")
 else
  gpu:setForeground(0,0,0,1) gpu:setBackground(0,1,0,1) 
write(x,y,SYS_Stat[4])


end
end

if setup == true then
if HSwitch == true then 
gpu:setForeground(0,0,0,1) gpu:setBackground(0,1,0,0.5)
write(80,y,"[ Switch ]") 
else
gpu:setForeground(0,0,0,0.5) gpu:setBackground(1,0,0,0.5)
write(80,y,"[ Switch ]") 
end

if HLight == true then 
gpu:setForeground(0,0,0,1) gpu:setBackground(0,1,0,0.5)
write(91,y,"[ Light ]") 
else
gpu:setForeground(0,0,0,0.5) gpu:setBackground(1,0,0,0.5)
write(91,y,"[ Light ]") 
end
end

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
write(x,y,"|                                 |          |         |         |            |                                   |")
end

function Sys_BatDis(x,y,Contents)
write(x,y,"O==[ Machine Name ] ==============O=[ Prog ]=O=[ Pwr ]=O=[ Eff ]=O=[ Status ]=O=[ Info / Making / Errors ]========O")
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
write(x,y,"O=================================O==========O=========O=========O============O===================================O")
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
 event.pull(x)
end

function ITEMLIST()
--print("Item List Empty")
MachineList()
if Page == 0 then
Page = 1
else
Page = 0
end


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