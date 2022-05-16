Build = "1027-0201DEV-0003    "
-- Program 1 / 6

-- Status Light #############################
PAN = {"StorageManager",0,0,1,0,40,0,1}
ConPan = 0
-- ##########################################


SiteName = "Store Site 1"
CBeep            = false
EnableStausLight = true
EnableScreen     = true
ConPercentages   = false
ServerConnected  = true
DirectConnection = true

-- ITEM LIST ############################################################################################
                  ListVer = "4.0.0"
-- Stacks,Display Name, ConErr, LigErr, PwrErr, RadioActive 1Y 0N, System Name 
                      VAL = {100 ,"Default                     ",0,0,0,0,"Default"}
-- Ground Floor

IronPlates = {200 ,"Iron Plates                 ",0,0,0,0,"IronPlates"}
IronRods = {200 ,"Iron Rods                   ",0,0,0,0,"IronRods"}
Wire = {500 ,"Wire                        ",0,0,0,0,"Wire"}
Cable = {200 ,"Cable                       ",0,0,0,0,"Cable"}
Concrete = {500 ,"Concrete                    ",0,0,0,0,"Concrete"}
ReinforcedIronPlate = {100 ,"Reinforced Iron Plate       ",0,0,0,0,"ReinforcedIronPlate"}
HeavyModularFrame = {50  ,"Heavy Modular Frame         ",0,0,0,0,"HeavyModularFrame"}
SteelPipe = {100 ,"Steel Pipe                  ",0,0,0,0,"SteelPipe"}
AlcladAluminumSheet = {100 ,"Alclad Aluminum Sheet       ",0,0,0,0,"AlcladAluminumSheet"}
AluminumCasing = {100 ,"Aluminum Casing             ",0,0,0,0,"AluminumCasing"}
Screws = {500 ,"Screws                      ",0,0,0,0,"Screws"}
SteelBeam = {100 ,"Steel Beam                  ",0,0,0,0,"SteelBeam"}
Quickwire = {500 ,"Quickwire                   ",0,0,0,0,"Quickwire"}
CopperSheet = {200 ,"Copper Sheet                ",0,0,0,0,"CopperSheet"}
Computer = {50  ,"Computer                    ",0,0,0,0,"Computer"}
CircuitBoard = {200 ,"CircuitBoard                ",0,0,0,0,"CircuitBoard"}
Rotor = {100 ,"Rotor                       ",0,0,0,0,"Rotor"}
RadioControlUnit = {50  ,"Radio Control Unit          ",0,0,0,0,"RadioControlUnit"}
Motor = {50  ,"Motor                       ",0,0,0,0,"Motor"}
ModularFrame = {50  ,"Modular Frame               ",0,0,0,0,"ModularFrame"}

--Floor 2

Rubber = {200 ,"Rubber                      ",0,0,0,0,"Rubber"}
HighSpeedConnector = {100 ,"High Speed Connector        ",0,0,0,0,"HighSpeedConnector"}
Plastic = {200 ,"Plastic                     ",0,0,0,0,"Plastic"}
Supercomputer = {50  ,"Supercomputer               ",0,0,0,0,"Supercomputer"}
QuartzCrystal = {100 ,"Quartz Crystal              ",0,0,0,0,"QuartzCrystal"}
CrystalOscillator = {100 ,"Crystal Oscillator          ",0,0,0,0,"CrystalOscillator"}
EncasedIndustrialBeam = {100 ,"Encased Industrial Beam     ",0,0,0,0,"EncasedIndustrialBeam"}
PortableMiner         = {100 ,"PortableMiner       ",0,0,0,0,"PortableMiner"}
AILimiter = {100 ,"A.I. Limiter                ",0,0,0,0,"AILimiter"}
TurboMotor = {50  ,"Turbo Motor                 ",0,0,0,0,"TurboMotor"}
Beacon = {100 ,"Beacon                      ",0,0,0,0,"Beacon"}
CoolingSystem = {100 ,"CoolingSystem               ",0,0,0,0,"CoolingSystem"}
FusedModularFrame = {50  ,"Fused Modular Frame         ",0,0,0,0,"FusedModularFrame"}
Stator = {100 ,"Stator                      ",0,0,0,0,"Stator"}
ElectromagneticControlRod = {100 ,"Electromagnetic Control Rod ",0,0,0,0,"ElectromagneticControlRod"}
VAL = {100 ,"Default                     ",0,0,0,0,"Default"}
VAL = {100 ,"Default                     ",0,0,0,0,"Default"}
VAL = {100 ,"Default                     ",0,0,0,0,"Default"}
VAL = {100 ,"Default                     ",0,0,0,0,"Default"}
VAL = {100 ,"Default                     ",0,0,0,0,"Default"}

--#######################################################################################################


 

-- add below what each container is in the format below:

-- Examples -- ###################################################################
-- Containers   = ConStatus(DisX,DisY,Contents,ConNumber,ConType,ELight,EPower)

-- Example For containers ########################################################
-- Container Name Example : CON B1 LimeStone

function ContainerList()
-- Display



ConStatus(8,IronPlates,1,1)
ConStatus(9,IronRods,1,2)
ConStatus(10,Wire,1,3)
ConStatus(11,Cable,1,4)
ConStatus(12,Concrete,1,5)
ConStatus(13,ReinforcedIronPlate,1,6)
ConStatus(14,HeavyModularFrame,1,7)
ConStatus(15,SteelPipe,1,8)
ConStatus(16,AlcladAluminumSheet,1,9)
ConStatus(17,AluminumCasing,1,10)
ConStatus(18,Screws,1,11)
ConStatus(19,SteelBeam,1,12)
ConStatus(20,Quickwire,1,13)
ConStatus(21,CopperSheet,1,14)
ConStatus(22,Computer,1,15)
ConStatus(23,CircuitBoard,1,16)
ConStatus(24,Rotor,1,17)
ConStatus(25,RadioControlUnit,1,18)
ConStatus(26,Motor,1,19)
ConStatus(27,ModularFrame,1,20)

--Page 2
--ConStatus(28,Rubber,1,21)
--ConStatus(29,HighSpeedConnector,1,22)
--ConStatus(30,Plastic,1,23)
--ConStatus(31,Supercomputer,1,24)
--ConStatus(32,QuartzCrystal,1,25)
--ConStatus(33,CrystalOscillator,1,26)
--ConStatus(34,EncasedIndustrialBeam,1,27)
--ConStatus(35,PortableMiner,1,28)
--ConStatus(36,AILimiter,1,29)
--ConStatus(37,TurboMotor,1,30)
--ConStatus(38,Beacon,1,31)
--ConStatus(39,CoolingSystem,1,32)
--ConStatus(40,FusedModularFrame,1,33)
--ConStatus(41,Stator,1,34)
--ConStatus(42,ElectromagneticControlRod,1,35)



end --## ITEM LIST ############################################



--############################################################################
-- Anything after this point you should not have to change.
-- The program will let you know if anything will need updating above.




--############################################################################
--TEST AREA
--############################################################################
print("Server-Sender-v0.0.3")
HubServer = "DC73C2544A7BF761FB9BED8C695A5678"
Port = 1
--netcard = component.proxy("C0DD742E45CDFEE03E5160ADF2378678")
--for n = 1,40 do
--netcard:open(n)
--end


function SendToServer(Server, Port, Data)
netcard = component.proxy("C0DD742E45CDFEE03E5160ADF2378678")
netcard:open(Port)
netcard:send(Server, Port, Data)
--print(Server.."|"..Port.."|"..Data)
end

--SendToServer(SwitchServer,Port,"IronPlates")



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
TEST = 0
IND = 0
ChkDis = false
if EnableStausLight == true then 
StatusPanel = component.proxy(component.findComponent(PAN[1])[1]) 
ProgramStat = StatusPanel:getModule(PAN[2],PAN[3])
UpdateStat = StatusPanel:getModule(PAN[7],PAN[8])
text = StatusPanel:getModule(PAN[4],PAN[5])
text.size = PAN[6]
text.text = "Storage Manager" 
end
dev = 0
local ProgName = ("Ficsit Storage Manager 3030   ")
local By = ("Skyamoeba")
local Ver = ("1.0.0 ")
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

function LayoutMode(X,Y)
textCol(1,0,0,1) 
write(X,Y,"#") 
gpu:setForeground(1,1,1,1)
gpu:setBackground(0,0,0,0)
end

function Connection(x,y,Contents,DisY)
if FLAG == 0 then
 if TEST == 1 then
  Contents[5] = 0
  end
end

function GPwrSwitch()
Comp = component.proxy(component.findComponent(x)[1])
end


if Contents[5] == 1 then else
if pcall (GPwrSwitch) then

GPwrSwitch()

Comp.isSwitchOn = y

else 
 FLAG = 1 print(ERR[5]..Contents[7])
 gpu:setForeground(0,0,0,10) gpu:setBackground(1,0,0,0.5)
write(2,DisY,Contents[2])
gpu:setForeground(0,0,0,10) gpu:setBackground(1,0,0,0.5)
write(69,DisY," Error    ")
gpu:setForeground(1,1,1,10) gpu:setBackground(0,0,0,0)
write(82,DisY,"Power Connection")
 Contents[5] = 1 
end
end
end --Function Connection End

function ConStatus(DisY,Contents,ConType,Port)
if FLAG == 0 then
 if TEST == 1 then
  Contents[3] = 0
 end
end

function ConData()
prefix = {"CON","LIG","PWR"}
local setupcon = {prefixcon= prefix[1], condata=Contents[7]}
local setuppwr = {prefixpwr= prefix[3], pwrdata=Contents[7]}
local setuplig = {prefixlig= prefix[2], ligdata=Contents[7]}

Container = string.gsub("$prefixcon $condata", "%$(%w+)", setupcon)
Light = string.gsub("$prefixlig $ligdata", "%$(%w+)", setuplig)
Power = string.gsub("$prefixpwr $pwrdata", "%$(%w+)", setuppwr)

ContStore = component.proxy(component.findComponent(Container)[1])
conInv = ContStore:getInventories()[1]
conSum = conInv.itemCount
itemStack = conInv:getStack(0)
Cont_Size = conInv.size
Item_StackSize = itemStack.count
MaxLvl = Cont_Size * Item_StackSize

end
if Contents[3] == 1 then 
gpu:setForeground(0,0,0,10) gpu:setBackground(1,0,0,0.5)
write(2,DisY,Contents[2])
gpu:setForeground(0,0,0,10) gpu:setBackground(1,0,0,0.5)
write(69,DisY," Error    ")
gpu:setForeground(1,1,1,10) gpu:setBackground(0,0,0,0)
write(82,DisY,"Connection")
else
if pcall (ConData) then 

ConData()

if ConType == 0 then -- "Small"
if Contents[1] == 50 then x = 1199 y = 599 z = 200 end
if Contents[1] == 100 then x = 2399 y = 1600 z = 800 end
if Contents[1] == 200 then x = 4799 y = 1600 z = 1000 end
if Contents[1] == 500 then x = 11999 y = 8000 z = 2000 end
end

if ConType == 1 then -- "Large"
if Contents[1] == 50 then x = 2399 y = 1199 z = 200 end
if Contents[1] == 100 then x = 4799 y = 2400 z = 800 end
if Contents[1] == 200 then x = 9599 y = 1600 z = 1000 end
if Contents[1] == 500 then x = 23999 y = 11999 z = 1000 end
end

--a = x + 1
--rawpercent = conSum / a * 100/1 
--percent= round(rawpercent)

-- Screen List Start
if EnableScreen == true then
textCol(1,1,1,1)

write(2,DisY,Contents[2]) -- Container Name

write(36,DisY,conSum) -- Amount in Container

write(48,DisY,MaxLvl) -- MaxAmount in Container

write(59,DisY,Cont_Size) -- Slot amount in Container

--if conSum > x then
if conSum ==  MaxLvl then gpu:setForeground(0,0,0,1) gpu:setBackground(0,1,0,0.5) write(69,DisY," Full     ") --end

if ServerConnected == true then 
end

if DirectConnection == true then
gpu:setForeground(0,0,0,1) 
gpu:setBackground(1,1,1,0)
write(82,DisY,"                             ")
Connection(Power,false,Contents,DisY) 
end
else

if conSum < MaxLvl then  gpu:setForeground(0,0,0,1) gpu:setBackground(1,1,0,1) write(69,DisY," FreeSlot ") end

if ServerConnected == true then
end

if DirectConnection == true then
gpu:setForeground(0,0,0,1) 
gpu:setBackground(1,1,0,1) 
write(82,DisY," Item Requested From Factory ")
Connection(Power,true,Contents,DisY)
end

if conSum < 100 then     gpu:setForeground(0,0,0,1) gpu:setBackground(1,0,0,1) write(69,DisY," Low      ") end
if conSum == 0 then      gpu:setForeground(0,0,0,1) gpu:setBackground(1,0,0,1) write(69,DisY," Empty    ") end




end

end
--Screen List End
else 
FLAG = 1 print(ERR[3]..Contents[7]) Contents[3] = 1 
end
end
gpu:setForeground(1,1,1,1)
gpu:setBackground(0,0,0,0)
end
-- Container Status Main End--



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
VersionStorage= VerCheckStoreD()
VerPrint = VerCheckStoreP()

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
if UIND == 1 then 
  UpdateStat:setcolor(1,1,0,10.0)
  text.text = VerPrint.." Update"
  if CBeep == true then computer.beep() end
  UIND = 0
  computer.millis(1000)
else
  text.text = "Storage Manager"
  UpdateStat:setcolor(1,1,1,0)
  UIND = 1
  computer.millis(1000)
end
--event.pull(1)
end

function UpdateDisplay()
write(37,1,"Storage Site Name : "..SiteName)
write(37,2,"Update Check      : ")
if currentver < VersionStorage then 
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

function ServerStatus()
if ServerConnected == true then 
write(37,4,"Server Connected  : ") 
gpu:setForeground(0,0,0,1)
gpu:setBackground(0,1,0,1)
write(57,4,"Item Request Avaliable")
else
write(37,4,"Server Connected  : ") 
gpu:setForeground(0,0,0,1)
gpu:setBackground(0,1,0,1)
write(57,4,"Unmanaged Fill Only")
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
write(x,y,"|                                 |           |          |         |            |                                 |")
end

function Sys_BatDis(x,y,Contents)
write(x,y,"O==[ Container Name / Contents ] =O=[ Items ]=O=[MaxLvl]=O=[ Stk ]=O=[ Status ]=O=[ Info / Errors ]===============O")
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
write(DisX,y,"O--------------------------------O")

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

--##########################################################################################################
  function MainLoop() if EnableScreen == true then clearScreen() end 
--##########################################################################################################
-- ** Add your containers to the erro check incase of accedential disconnection so the program can keep on *
SystemInfo(0,0) -- Default 83,0
Sys_OverView(34,0)
Sys_GridOverview(0,30)
Sys_BatDis(0,7)
UpdateDisplay()
ContainerList()
ServerStatus()

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

if FLAG == 1 then 
if Sec == 30 then SendToServer(HubServer, 1, "Error") end 
else 
if Sec == 30 then SendToServer(HubServer, 1, "Error Fixed") end 
end
   
if FLAG == 1 then if Sec == 30 then selfTest() end else TEST = 0 end

-- Screen System Main P3/3 ##############################################################################--
if EnableScreen == true then gpu:flush() end
sleep(1)
Sec = Sec + 1
--Tick = Tick + 1
-- Screen System Main P3/3 End--
end -- while true loop end