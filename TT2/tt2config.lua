adaptResolution(750, 1334)
adaptOrientation(ORIENTATION_TYPE.PORTRAIT)

-- Classes

Pixel = {}
function Pixel.new(x, y, color)
    local o = {}
    o.x = x
    o.y = y
    o.color = color
    return o
end

Pixels = {}
function Pixels.new(table, region)
    local o = {}
    o.table = table
    o.region = region
    return o
end

-- Configuration
-- Delays:
-- You might need to tweak these depending on how fast/slow your iOS device is

Delay = {
    tap         = 25000, -- time between/after touchUp/touchDown events [default: 25000]
    menu        = 1e6,   -- time for menu transitions etc [default: 1e6]
    slide       = 1e4,   -- time between touchMove events [default: 1e4]
    animation   = 5e5,   -- time for animations [default: 5e5]
    prestige    = 8e6    -- time for prestige animation [default: 8e6]
}

-- Menu:
-- These are all pixels for relevant ui elements in the menu.
Menu = {
    -- Bottom Bar Menu
    stageClose  = Pixel.new(672, 753, 4405296),
    swordMaster = Pixel.new(60, 1310, 9714722),
    heroes      = Pixel.new(188, 1310, 2119264),
    equipment   = Pixel.new(312, 1310, 8940050),
    pets        = Pixel.new(438, 1310, 3826988),
    artifacts   = Pixel.new(563, 1310, 4599928),

    -- Boss Available
    fightBoss = Pixel.new(656, 64, 16777215),

    -- Prestige Windows
    prestige        = Pixel.new(635, 1239, 16777215),
    prestigeWindow  = Pixel.new(375, 1023, 16777215),
    prestigeConfirm = Pixel.new(525, 880, 16777215),

    -- Multiplier Bar Menu
    xSel = Pixel.new(636, 824, 4280659),
    xOne = Pixel.new(452, 846, 16777215),
    xTen = Pixel.new(333, 846, 16777215),
    xHun = Pixel.new(208, 846, 16777215),
    xMax = Pixel.new(76, 846, 16777215),

    -- Clan Menu
    clanMain  = Pixel.new(123, 33, 8408133),
    clanClose = Pixel.new(668, 78, 4405296),
    clanQuest = Pixel.new(139, 1205, 3552843),
    clanFight = Pixel.new(450, 1232, 16777215),

    clanFightAvailable = Pixel.new(140, 40, 15382955),
    clanFightComplete  = Pixel.new(190, 1167, 16777215),
    clanFightRepeat    = Pixel.new(506, 741, 16777215),

    -- Daily Reward 
    dailyRewardAvailable = Pixel.new(50, 288, 16777215),
    dailyRewardCollect   = Pixel.new(527, 872, 16777215),
    dailyRewardClose     = Pixel.new(670, 400, 4405296),

    -- Pet Reward
    petAvailable = Pixel.new(50, 460, 16777215),

    -- Gold Reward
    goldAvailable = Pixel.new(48, 343, 16777215),

    -- Fairy Ad
    fairyAdNo  = Pixel.new(205, 1035, 16417035)
}

-- Stage Pixels to determine what screen im looking at
Stage = {
    clan   = Pixel.new(129, 103, 000000),
    main   = Pixel.new(5, 1329, 15950906),
    boss   = Pixel.new(196, 108, 2429446),
    equip  = Pixel.new(202, 110, 531749),
    splash = Pixel.new(10, 1320, 3216396),
    splashDark = Pixel.new(10, 1320, 1575430),

    fairyAd = Pixel.new(65, 1040, 16424980),

    transition = Pixel.new(1, 1, 0),

    bossAvailable = Pixel.new(568, 74, 11944970)
}

-- Skills: using a pixel at the end of the cooldown ring
Skill = {    
    heavenlySword  = Pixel.new( 60, 1149, 16777215),
    criticalStrike = Pixel.new(185, 1149, 16777215),
    handOfMidas    = Pixel.new(310, 1149, 16777215),
    fireSword      = Pixel.new(435, 1149, 16777215),
    warCry         = Pixel.new(560, 1149, 16777215),
    shadowClone    = Pixel.new(685, 1149, 16777215)
}

-- Stuff that needs more than one pixel to recognize
Icon = {    
    -- Fairies: Fat, Left, and Right
    fairyF = Pixels.new({{5745706,0,0}, {15624979,0,17}, {4224042,0,5}, {16311253,0,12}, {12204827,0,28}, {5745706,0,-3}}, {20,220,700,150}),
    fairyL = Pixels.new({{5745706,0,0}, {15624979,0,17}, {4224042,0,5}, {16311253,0,12}, {12204827,0,28}, {5745706,0,-3}}, {20,220,700,150}),
    fairyR = Pixels.new({{5745706,0,0}, {15624979,0,17}, {4224042,0,5}, {16311253,0,12}, {12204827,0,28}, {5745706,0,-3}}, {20,220,700,150}),
    
    -- Pet Stuff
    flashZip = Pixels.new({{16711422,0,0}, {16711422,1,-19}, {16711422,-12,-8}, {16711422,-11,10}, {16711422,1,19}, {16711422,12,8}, {16711422,11,-11}}, {40, 220, 670, 500}),

    -- Hero Stuff
    hireAvailable    = Pixels.new({{16764166,0,0}, {16764166,0,10}, {16764166,0,20}, {16764166,0,30}, {16764166,0,40}, {16764166,0,50}, {16764166,0,60}, {16764166,0,70}, {16764166,0,80}, {16764166,0,90}, {3158064,0,-1}}, {715, 806, 25, 479}),
    upgradeAvailable = Pixels.new({{16030225,0,0}, {16030225,0,10}, {16030225,0,20}, {16030225,0,30}, {16030225,0,40}, {16030225,0,50}, {16030225,0,60}, {16030225,0,70}, {16030225,0,80}, {16030225,0,90}}, {715, 806, 25, 479})
}