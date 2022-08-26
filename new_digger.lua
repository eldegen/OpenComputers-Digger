local component = require("component")
local sides = require("sides")

local robot = component.robot
local computer = component.computer

local angle = false --counter clockwise

print("Starting program...")
computer.beep(1000, 0.1)

if robot.durability() ~= nil then
    if robot.durability() <= 0.1 then
        --computer.crash("[i] Инструмент в руке имеет меньше 10 (" .. robot.durability() .. ") прочности!")
        print("[i] Инструмент в руке имеет меньше 10 (" .. robot.durability() .. ") прочности!")
        robot.setLightColor(0xFFFF00)
        os.sleep(5)
        computer.stop()
    end
else
    --computer.crash("[i] Где инструмент, Лебовски!")
    print("[i] Где инструмент, Лебовски!")
    robot.setLightColor(0xFFFF00)
    os.sleep(5)
    computer.stop()
end    

print("[i] Инструмент цел, " .. robot.durability() .. " прочности")
print("[i] Начинаю работать")
robot.setLightColor(0x00FF09)
computer.beep("...")

--

for i = 0, 40 do
    for i = 0, 11 do
        for i = 0, 11 do
            success, blockType = robot.swing(sides.front)
            --print(success)
            if success == false and blockType == "block" then
                print("[i] Я не могу сломать этот блок")
                robot.setLightColor(0xFFFF00)
                for i = 0, 4 do
                    computer.beep(2000, 0.05)
                end
                os.sleep(5)
                computer.stop()
            else
                robot.move(sides.front)
            end
        end
        robot.turn(angle)
        robot.swing(sides.front)
        robot.move(sides.front)
        robot.turn(angle)
        if angle == false then
            angle = true
        else
            angle = false
        end
        --print("[Debug] angle - " .. tostring(angle))
    end
    robot.turn(true)
    robot.swing(sides.bottom)
    robot.move(sides.bottom)
end

print("[i] Цикл завершен")
robot.setLightColor(0x0000FF)