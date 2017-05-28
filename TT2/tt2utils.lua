-- Utilities and Functions for TT2

-- Counters

clanFightTime       = nil
currentMultiplier   = nil

-- Utilities

function ttap(i, x, y)
    touchDown(i, x, y)
    usleep(Delay.tap)
    touchUp(i, x, y)
    usleep(Delay.tap)
end

function scroll(q, a, b, x, y, z)
    local dx = (a - x) / z
    local dy = (b - y) / z

    touchDown(q, a, b)
    usleep(1e5)

    for i = 2, z do
        a = a - dx
        b = b - dy
        touchMove(q, a, b)
        usleep(Delay.slide)
    end
    
    touchMove(q, x, y)
    usleep(1e6)
    touchUp(q, x, y)
    usleep(Delay.tap)
end

function scrollTop()
    touchDown(5, 400, 850);
    usleep(5e4);
    touchMove(5, 400, 860);
    usleep(Delay.slide);
    touchMove(5, 400, 903);
    usleep(Delay.slide);
    touchMove(5, 400, 1000);
    usleep(Delay.slide);
    touchMove(5, 400, 1116);
    usleep(Delay.slide);
    touchMove(5, 400, 1250);
    usleep(Delay.slide);
    touchUp(5, 400, 1259);
    usleep(5e5);
end

function scrollBottom()
    touchDown(5, 400, 1215);
    usleep(5e4);
    touchMove(5, 400, 1176);
    usleep(Delay.slide);
    touchMove(5, 400, 1154);
    usleep(Delay.slide);
    touchMove(5, 400, 1120);
    usleep(Delay.slide);
    touchMove(5, 400, 1064);
    usleep(Delay.slide);
    touchMove(5, 400, 961);
    usleep(Delay.slide);
    touchMove(5, 400, 808);
    usleep(Delay.slide);
    touchMove(5, 400, 600);
    usleep(Delay.slide);
    touchMove(5, 400, 351);
    usleep(Delay.slide);
    touchMove(5, 400, 109);
    usleep(Delay.slide);
    touchUp(5, 400, 105);
    usleep(5e5);
end

function hasPixel(pixel)
    if getColor(pixel.x, pixel.y) == pixel.color then
        return true
    end
end

function hasPixels(pixels, count)
    local result = findColors(pixels.table, count, pixels.region)

    if next(result) ~= nil then
        return true
    end
end

function waitForPixel(pixel, timeout)
    local pause = 1
    local timer = 0
    local result = 1

    while (pause == 1) do
        if (getColor(pixel.x, pixel.y) == pixel.color) then
            pause = 0
            usleep(1e5)
        else
            timer = timer + 1
            if (timeout > 0 and timer > timeout * 10) then
                wait = 0
                result = 0
            else
            usleep(1e5)
            end
        end
    end
    return result
end

function tapButton(pixel)
    if getColor(pixel.x, pixel.y) == pixel.color then
        ttap(1, pixel.x, pixel.y)
        usleep(Delay.animation)
    end
end

function levelUpMultiplier(multiplier)
    if multiplier ~= currentMultiplier then
        tapButton(Menu.swordMaster)
        scrollTop()
        tapButton(Menu.xSel)

        if multiplier == 1 then
            tapButton(Menu.xOne)
            currentMultiplier = 1
        elseif multiplier == 10 then
            tapButton(Menu.xTen)
            currentMultiplier = 10
        elseif multiplier == 100 then
            tapButton(Menu.xHun)
            currentMultiplier = 100
        else
            tapButton(Menu.xMax)
            currentMultiplier = 0
        end
    end
end

function mainStageBossAvailable()
    if hasPixel(Stage.main) and not (hasPixel(Stage.boss) or hasPixel(Stage.equip)) then
        return true
    end
end

function chaseFairies()
    local findFairiesL = findColors(Icon.fairyL.table, 0, Icon.fairyL.region)
    local findFairiesR = findColors(Icon.fairyR.table, 0, Icon.fairyR.region)
    local findFairiesF = findColors(Icon.fairyF.table, 0, Icon.fairyF.region)

    if next(findFairiesL) ~= nil then
        for k, fairy in pairs(findFairiesL) do
            ttap(1, fairy[1], fairy[2])
        end
    end

    if next(findFairiesR) ~= nil then
        for k, fairy in pairs(findFairiesR) do
            ttap(1, fairy[1], fairy[2])
        end
    end

    if next(findFairiesF) ~= nil then
        for k, fairy in pairs(findFairiesF) do
            ttap(1, fairy[1], fairy[2])
        end
    end
end

function chaseFlashZip()
    if hasPixel(Stage.main) then
        local flashZip = findColors(Icon.flashZip.table, 0, Icon.flashZip.region)

        if next(flashZip) ~= nil then
            ttap(1, flashZip[1][1], flashZip[1][2])
        end
    end
end

function checkForNewPet()
    if getColor(Menu.petAvailable.x, Menu.petAvailable.y) == Menu.petAvailable.color then
        ttap(1, Menu.petAvailable.x, Menu.petAvailable.y)

        if waitForPixel(Stage.splash, 5) then
            ttap(1, Menu.petAvailable.x, Menu.petAvailable.y)
            usleep(Delay.menu)
        end

        while not hasPixel(Stage.main) do
            ttap(1, Menu.petAvailable.x, Menu.petAvailable.y)
        end
    end
end

function checkForGold()
    if getColor(Menu.goldAvailable.x, Menu.goldAvailable.y) == Menu.goldAvailable.color then
        ttap(1, Menu.goldAvailable.x, Menu.goldAvailable.y+30)
    end
end

function checkForDaily()
    if getColor(Menu.dailyRewardAvailable.x, Menu.dailyRewardAvailable.y) == Menu.dailyRewardAvailable.color then
        ttap(1, Menu.dailyRewardAvailable.x, Menu.dailyRewardAvailable.y)
        -- wait for daily reward window
        if waitForPixel(Menu.dailyRewardCollect, 10) then
            tapButton(Menu.dailyRewardCollect)
            -- tap until at main stage
            while not hasPixel(Stage.main) do
                ttap(1, Menu.dailyRewardAvailable.x, Menu.dailyRewardAvailable.y)
            end
        end
    end 
end

function checkForPrestige(timer)
    local prestigeTimer = tonumber(timer)

    if prestigeTimer > 0 then
        if (math.floor(os.difftime(os.time(),prestigeTime) / 60) > prestigeTimer) then
            return true
        end
    end
end

function checkClanQuestDiamonds()
    if not fileExists("clanquest") then
        return true
    else
        clanQuestTime = readTime("clanquest")
        -- check if more than 6 hours has passed since last diamond expenditure
        if os.difftime(os.time(), clanQuestTime) > 21599 then
            return true
        end
    end
end

function prestige()
    tapButton(Menu.swordMaster)
    scroll(3, 400, 1100, 400, 1014, 20) -- multiplier bar
    usleep(Delay.animation)
    scroll(4, 400, 1250, 400, 766, 40)
    usleep(Delay.animation)
    tapButton(Menu.prestige)
    -- wait for prestige window (network delay sometimes)
    if waitForPixel(Menu.prestigeWindow, 5) then
        tapButton(Menu.prestigeWindow)
        -- wait for prestige confirmation window
        if waitForPixel(Menu.prestigeConfirm, 5) then
            tapButton(Menu.prestigeConfirm)

            writeTime("prestige")
        end

        usleep(Delay.prestige)
    end
end

function fightClanQuest(value)
    rounds = tonumber(value)

    if getColor(Menu.clanFightAvailable.x, Menu.clanFightAvailable.y) == Menu.clanFightAvailable.color then
        tapButton(Menu.clanFightAvailable)

        if waitForPixel(Menu.clanQuest, 10) then
            tapButton(Menu.clanQuest)

            local round = 1

            for i = 1, rounds do
                -- dont do successive clan quests unless 6 hours has past since last diamond use
                if round > 1 and not checkClanQuestDiamonds() then break end
                
                if waitForPixel(Menu.clanFight, 10) then
                    
                    tapButton(Menu.clanFight)

                    if round > 1 and checkClanQuestDiamonds() then
                        waitForPixel(Menu.clanFightRepeat, 5)
                        tapButton(Menu.clanFightRepeat)
                    end

                    while hasPixel(Stage.clan) do
                        touchDown(1, 440, 620)
                        usleep(16000)
                        touchUp(1, 440, 620)
                        usleep(16000)
                    end

                    round = round + 1
                    waitForPixel(Menu.clanFightComplete, 3)
                    tapButton(Menu.clanFightComplete)
                end
            end
            -- write new clan quest time if diamonds were spent
            if round > 1 then writeTime("clanquest") end
            -- Exit Clan Quest Window
            waitForPixel(Menu.clanClose, 4)
            tapButton(Menu.clanClose)
        end
        -- Exit Clan Chat Window
        waitForPixel(Menu.clanClose, 4)
        tapButton(Menu.clanClose)
    end
end

function levelSwordMaster()
    tapButton(Menu.swordMaster)
    scrollTop()
    levelUpMultiplier(100)
    for i = 1, 6 do ttap(1, 630, 945) end
end

function learnSkills(x)
    local count = x or 1
    tapButton(Menu.swordMaster)
    scrollTop()
    scroll(3, 400, 1100, 400, 1014, 20) -- multiplier bar

    for i=1, count do
        ttap(1, 630, 1000); -- learn pos 2 (heavenly strike)
        ttap(1, 630, 1120); -- learn pos 3 (critical strike)
        ttap(1, 630, 1220); -- learn pos 4 (hand of midas)
    end
    
    scroll(4, 400, 1250, 400, 766, 40)
    usleep(Delay.menu);

    for i=1, count do
        ttap(1, 630, 875); -- learn pos 1
        ttap(1, 630, 977); -- learn pos 2
        ttap(1, 630, 1110); -- learn pos 3
    end
    usleep(Delay.animation)
    tapButton(Menu.stageClose);
end

function hireHeroes()
    local hireAvailable = {}

    levelUpMultiplier(0)
    tapButton(Menu.heroes)
    scrollTop()
    scrollTop()
    scrollTop()
    usleep(Delay.menu)
    scroll(3, 400, 1100, 400, 1014, 20) -- multiplier bar
    usleep(Delay.animation)

    for i = 1, 7 do
        hireAvailable = findColors(Icon.hireAvailable.table, 0, Icon.hireAvailable.region)

        if next(hireAvailable) ~= nil then
            for k, v in pairs(hireAvailable) do
                while (getColor(v[1], v[2]) ~= 10921638) do
                    ttap(1, 630, v[2]+50)
                    usleep(Delay.tap)
                end
            end
        end
        usleep(Delay.animation)
        scroll(4, 400, 1250, 400, 766, 40)
        usleep(Delay.animation)
    end
    usleep(Delay.animation)
    tapButton(Menu.stageClose);
end

function levelHeroes()
    levelUpMultiplier(0);
    tapButton(Menu.heroes);
    scrollBottom();
    usleep(Delay.menu);

    for i=1,3 do
        ttap(1, 650, 1125); 
        usleep(Delay.animation);
    end
    for i=1,3 do 
        ttap(1, 650, 1000);
        usleep(Delay.animation);
    end
    checkCounter = false;
    usleep(Delay.animation)
    tapButton(Menu.stageClose);
end

function useSkill()
    tapButton(Skill.warCry)
    tapButton(Skill.handOfMidas)
    tapButton(Skill.shadowClone)
end

function fileExists(file)
    local f = io.open(rootDir() .. "TT2/" .. file .. ".txt", "r")
    if f ~= nil then io.close(f) return true else return false end
end

function readTime(file)
    local f = io.open(rootDir() .. "TT2/" .. file .. ".txt", "r")

    local time = f:read("*n")
    f:close()

    return time
end

function writeTime(file)
    local f = io.open(rootDir() .. "TT2/" .. file .. ".txt", "w")
    f:write(os.time())
    f:close()
    -- write time to log as well
    log(file .. " at " .. os.date("%X"))
end