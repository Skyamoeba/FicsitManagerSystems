Build = "0001-0201FIC-1025    "


-- Status Light #############################
PAN = {"FluidManager",0,0,1,0,40,0,1}
-- ##########################################


SiteName = "Tank Site 1"
CBeep            = false
EnableStausLight = true
AlertForAnyPWR   = true -- if this is true then any pwr issues will need change the status light, false it will not trigger onlyin the display you will see issues
EnableScreen     = true
LiqPercentages   = false
--GasPercentages   = false
-- ServerLogger  = false
-- ServerAddress = "" -- Work in progress
-- NetworkCard   = "" -- Work in progress

-- ITEM LIST ############################################################################################
                  ListVer = "4.0.0"
-- Stacks,Display Name, ConErr, LigErr, PwrErr, RadioActive 1Y 0N, System Name 
                      VAL = {100 ,"Default                     ",0,0,0,0,"Default"}
-- Liquids ----------------------------------------------------------------------------------------------
                     Fuel = {"Fuel                        ",0,0,0,0,"Fuel"}
                  BioFuel = {"Bio Fuel                    ",0,0,0,0,"BioFuel"}
                TurboFuel = {"Turbo Fuel                  ",0,0,0,0,"TurboFuel"}
                    Water = {"Water                       ",0,0,0,0,"Water"}
                      Oil = {"Oil                         ",0,0,0,0,"Oil"}
          HeavyOilResidue = {"Heavy Oil Residue           ",0,0,0,0,"HeavyOilResidue"}
          AluminaSolution = {"Alumina Solution            ",0,0,0,0,"AluminaSolution"}
             SulfuricAcid = {"SulfuricAcid                ",0,0,0,0,"SulfuricAcid"}
--#######################################################################################################

-- add below what each container is in the format below:

-- Examples -- ###################################################################
-- Tanks Liquid = LiqStatus(Line,Contents,Alarm)
-- ###############################################################################

function ITEMLIST()

LiqStatus(8,Water,false)
LiqStatus(9,Oil,true)
--GasStatus(2,17,Nitrogen,1,true,true)

end --## ITEM LIST ############################################



--############################################################################
-- Anything after this point you should not have to change.
-- The program will let you know if anything will need updating above.




--############################################################################
--TEST AREA
--############################################################################
server = "0A6327714236EABC4C7C879916A8C876" -- (network Card)
netcard = component.proxy("2C3CF1544EF6734B3844E5BD84A556B2")

function Send(port,receiver,message)
netcard:open(port)
netcard:send(receiver, port, message)
end

--Send(0001,server, "Booting")

--print("Message sent to server")
--############################################################################
--TEST AREA
--############################################################################










-- System Screen Sys P1/3 #############################################################################--
if EnableScreen == true then 
SystemScreenSys = {"System Screen Sys Ver: ","1.0.1"}
--gpu = computer.getGPUs()[1]
gpu = computer.getPCIDevices(findClass("GPU_T1_C"))[1]
--local screen = computer.proxy(component.findComponent("Monitor"))[1]
screen = computer.getPCIDevices(findClass("FINComputerScreen"))[1]
gpu:bindScreen(screen)
w,h = gpu:setSize(115,40) --200 , 55
end
-- System Screen System P1/3 End --

SAT = {true, false}
ERR = {"[System] : Error Detected Starting Self Check ", 
       "[System] : Starting Self Test ", 
       "[ERROR]  : Connection Error For Container: ", 
       "[ERROR]  : Connection Error For Light: ", 
       "[ERROR]  : Connection Error For Power Switch: ",
       "[ERROR]  : Connection Error For Power Monitor: "}

SYS = {"[System] : Light Poles Disabled",
       "[System] : Power Poles Disabled",
       "[System] : Control Panel Lights Disabled", 
       "[System] : Computer Screen Disabled"}
FLAG = 0
Alarm= 0
TEST = 0
IND = 0
UIND= 0
ChkDis = false
StatusPanel = component.proxy(component.findComponent(PAN[1])[1]) 
ProgramStat = StatusPanel:getModule(PAN[2],PAN[3])
UpdateStat = StatusPanel:getModule(PAN[7],PAN[8])
text = StatusPanel:getModule(PAN[4],PAN[5])
text.size = PAN[6]
text.text = "Fluid Manager"
dev = 0
local ProgName = ("Ficsit Fluid Manager 3030     ")
local By = ("Skyamoeba")
local Ver = ("1.0.0 ")
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
VersionFluid= VerCheckFluidD()
VerPrint = VerCheckFluidP()

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



-- Tanks Status Main Start ##############################################

function LiqStatus(DisY,Contents,Alert)
if FLAG == 0 then
 if TEST == 1 then
  Contents[2] = 0
  end
end

function LiqData()
prefix = {"LIQ", "LIG", "PWR"}
local setupliq = {prefixcon= prefix[1], condata=Contents[6]}
local setuplig = {prefixlig= prefix[2], ligdata=Contents[6]}
local setuppwr = {prefixpwr= prefix[3], pwrdata=Contents[6]}
Tank = string.gsub("$prefixcon $condata", "%$(%w+)", setupliq)
Light = string.gsub("$prefixlig $ligdata", "%$(%w+)", setuplig)
Power = string.gsub("$prefixpwr $pwrdata", "%$(%w+)", setuppwr)

Fluid = component.proxy(component.findComponent(Tank)[1])
Name = Fluid.getFluidType
RawMax = Fluid.maxFluidContent
RawLvl = Fluid.fluidContent
LiqMax = round(RawMax)
LiqLvl = round(RawLvl)
FlowIn = Fluid.flowFill
FlowOt = Fluid.flowDrain
MaxFlo = Fluid.flowLimit
end

if Contents[2] == 1 then 
gpu:setForeground(0,0,0,10) gpu:setBackground(1,0,0,0.5)
write(2,DisY,Contents[1])
gpu:setForeground(0,0,0,10) gpu:setBackground(1,0,0,0.5)
write(68,DisY," Error    ")
gpu:setForeground(1,1,1,10) gpu:setBackground(0,0,0,0)
write(81,DisY,"Connection ")
else
if pcall (LiqData) then

LiqData()

if RawMax == 400 then x = 399 y = 199 z = 50 end
if RawMax == 2400 then x = 2399 y = 1199 z = 100 end 
rawpercent = LiqLvl / RawMax * 100/1 
percent= round(rawpercent)

write(2,DisY, Contents[1]) -- The users name for the tank
write(81,DisY,Contents[6]) -- The Contents of the tank

if LiqPercentages == false then
write(36,DisY,LiqLvl.."    ")
else
write(36,DisY,percent.."%   ")
end
write(48,DisY,LiqMax)


if FlowIn > 1     then textCol(1,1,1,1) write(68,DisY,"Refill    ") end 
if FlowOt > 1     then textCol(1,1,1,1) write(68,DisY,"In Use    ") end
if LiqLvl >LiqMax then textCol(1,1,1,1) write(68,DisY,"Full      ") end

if Alert == false then
if LiqLvl == 0    then textCol(1,1,1,1) write(68,DisY,"Empty     ") end
else
if LiqMax == 400 then
 if LiqLvl < 200 then
  textCol(1,1,1,1) write(68,DisY,"Lvl Low   ")
  Alarm = 1 
 end
else
 if LiqLvl < 1200 then
  textCol(1,1,1,1) write(68,DisY,"Lvl Low   ")
  Alarm = 1
 end
end
end



else 
FLAG = 1 print(ERR[3]..Contents[6]) Contents[2] = 1 end
end
gpu:setForeground(1,1,1,1)
gpu:setBackground(0,0,0,0)
end -- END OF TANK FUNCTION

-- Screen System Main P2/3 ############################################################################-- 
--print(SystemScreenSys[1]..SystemScreenSys[2])
function clearScreen() -- Issue #8
  gpu:setForeground(1,1,1,1)
  gpu:setBackground(0,0,0,0)
  --gpu:setBackground(colors[1],colors[2],colors[3],colors[4])
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
end

function UpdateBlink()
if UIND == 1 then 
  UpdateStat:setcolor(1,1,0,10.0)
  text.text = VerPrint.." Update"
  if CBeep == true then computer.beep() end
  UIND = 0
  computer.millis(1000)
else
  text.text = "Fluid Manager"
  UpdateStat:setcolor(1,1,1,0)
  UIND = 1
  computer.millis(1000)
end
--event.pull(1)
end




function UpdateDisplay()
write(37,1,"Tank Site Name    : "..SiteName)
write(37,2,"Update Check      : ")
if currentver < VersionFluid then 
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
write(x,y,"|                                 |          |          |         |            |                                  |")
end

function Sys_BatDis(x,y,Contents)
write(x,y,"O==[ Tank Name ] =================O=[ Lvl  ]=O=[MaxLvl]=O=[ --- ]=O=[ Status ]=O=[ Info / Contants / Errors ]=====O")
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
write(0,0,"Ficsit Production Manager 3030")
write(0,1,"Prg Ver : "..Ver)
write(0,2,"Mod Ver : "..MVer)
write(0,3,"Build   : "..Build)
gpu:flush()
print("O--------------------------------O")
print("|",ProgName,"|")
print("| By : "..By,"                |")
print("| Prg Ver : "..Ver,"              |")
print("| Mod Ver : "..MVer,"               |")
print("| Build   : "..Build.."|")
print("O--------------------------------O")

if dev == 1 then
print("Item List Ver    : ".. ListVer[1])
if EnableScreen == false then print(SYS[4]) else print(SystemScreenSys[1]..SystemScreenSys[2]) end
end
BFlag = 1
if EnableStausLight == true then
ProgramStat:setColor(10.0, 0.0, 10.0,5.0) end
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

--##########################################################################################################
  function MainLoop() if EnableScreen == true then clearScreen() end 
--##########################################################################################################
-- ** Add your containers to the erro check incase of accedential disconnection so the program can keep on *
SystemInfo(0,0) -- Default 83,0
Sys_OverView(34,0)
Sys_GridOverview(0,30)
Sys_BatDis(0,7)

--UpdateDisplay() #Disabled

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
  if EnableStausLight == true then ProgramStat:setColor(10.0, 0.0, 0.0,1) end
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
   if FLAG == 0 then ProgramStat:setColor(0,1,0,10.0) end
    if FLAG == 1 then Blink() end
  end
AlarmStatus = true
if AlarmStatus == true then
  if Alarm == 0 then end
   if Alarm == 1 then Blink() end
end
    
if FLAG == 1 then if Sec == 30 then selfTest() end else TEST = 0 end

-- Screen System Main P3/3 ##############################################################################--
if EnableScreen == true then gpu:flush() end
sleep(1)
Sec = Sec + 1
--Tick = Tick + 1
-- Screen System Main P3/3 End--
end -- while true loop end