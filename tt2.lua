-- Main Script for TT2
 
-- Flags
local premiumAccount = {type = CONTROLLER_TYPE.SWITCH, title = "Do you have a Premium Account?", key = "premium", value = 1}
local clickFairies = {type = CONTROLLER_TYPE.SWITCH, title = "Tap Fairies?", key = "fairies", value = 1}
local clickFlashZip = {type = CONTROLLER_TYPE.SWITCH, title = "Chase Flash Zip?", key = "flashzip", value = 1}
local clanQuestRounds = {type = CONTROLLER_TYPE.INPUT, title = "Number of CQ/Titan", key = "cqrounds", value = "1"}
local tapAttack = {type = CONTROLLER_TYPE.SWITCH, title = "Attack with Sword Master?", key = "attack", value = 1}
local prestigeTimer = {type = CONTROLLER_TYPE.INPUT, title = "Prestige Timer (in minutes)", key = "pTimer", value = "60"}

local controls = {premiumAccount, clickFairies, clickFlashZip, tapAttack, clanQuestRounds, prestigeTimer}
local enableRemember = true

dialog(controls, enableRemember)

require "TT2.tt2config"
require "TT2.tt2utils"

if not fileExists("prestige") then writeTime("prestige") end
prestigeTime = readTime("prestige")

while appState("com.gamehivecorp.taptitans2") == "ACTIVATED" do

    while hasPixel(Stage.main) do

        -- Prestige Routine
        if checkForPrestige(prestigeTimer.value) then
            prestige()
            levelSwordMaster()
            learnSkills(1)
            hireHeroes()
            prestigeTime = readTime("prestige")
        end

        -- Clan Quest Routine
        if tonumber(clanQuestRounds.value) > 0 then fightClanQuest(clanQuestRounds.value) end

        -- Collection Routine
        checkForGold()
        checkForNewPet()
        checkForDaily()

        -- Find and Click
        if clickFairies.value then chaseFairies() end
        if clickFlashZip.value then chaseFlashZip() end
        if mainStageBossAvailable() then tapButton(Menu.fightBoss) end
        -- Use Skills
        useSkill()
        -- Level  Hereos
        if checkCounter then levelHeroes() end
        -- Attack with Sword Master
        if tapAttack.value then
            ttap(0, 110, 680);
            ttap(1, 220, 680);
            ttap(2, 330, 620);
            ttap(1, 380, 290);
            ttap(0, 400, 620);
            ttap(1, 550, 400);
            ttap(2, 680, 660);
        end
    end

    while not hasPixel(Stage.main) do
        checkCounter = true
        -- Fairy Ad
        if premiumAccount and hasPixel(Stage.fairyAd) then
            ttap(1, 566, 1040)
        elseif hasPixel(Stage.fairyAd) then
            tap(1, 200, 1040);
            usleep(Delay.menu);
        end

        -- Item Splash, Egg Splash, or Pet Splash
        if hasPixel(Stage.splash) then
            usleep(Delay.animation)
            ttap(1, 357, 350)
            usleep(Delay.menu)
        end

        if hasPixel(Stage.splashDark) then
            usleep(Delay.animation)
            ttap(1, 357, 350)
            usleep(Delay.menu)
        end

        -- Transition
        if hasPixel(Stage.transition) then
            usleep(2e6)
        end
    end
end
