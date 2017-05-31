# TT2B #

An exploration into automation via AutoTouch in TT2. 

## Requirements

 * iDevice w/ [Jailbreak](https://www.reddit.com/r/jailbreak/)
 * [AutoTouch](https://autotouch.net)

## Features

 * Daily Rewards
 * Collect Pets
 * Fairies
 * Flash Zip
 * Clan Quest
 * Prestige
 * Learn/Level/Upgrade Heroes and Skills (Primitive)

## Configuration

Basic configuration is done in ```tt2config.lua```, depending on what device you are using certain game elements and animations may take longer to load. The following delay settings can be adjusted accordingly (these times are in microseconds). 

```lua
Delay = {
	tap 		= 25000, -- time between/after touchUp/touchDown events [default: 25000]
	menu		= 1e6,   -- time for menu transitions etc [default: 1e6]
	slide 		= 1e4,   -- time between touchMove events [default: 1e4]
	animation 	= 5e5,   -- time for animations [default: 5e5]
    prestige    = 8e6    -- time for prestige animation [default: 8e6]
}
```

Upon starting the script several options will be available. 

### Premium Account
With this enabled when fairy ads are displayed you will automatically click Collect, otherwise the default is to ignore.
### Click Fairies
This setting will have the bot actively look for fairies.
### Click Flash Zip
This setting will chase after the flash zip when facing a boss titan.
### Clan Quest Rounds
This setting will determine how many attacks you do per clan quest. Entering 0 will disable clan quests completely. Inputs greater than 1 will force multiple attacks with a six hour cooldown. Meaning if you set this at 3 you will burn 30 diamonds, after which for the next 6 hours you will only attack once every time a fight triggers. The timer for this is stored outside of the script so if you would like to clear the last time you spent diamonds manually delete ```clanquest.txt``` from the TT2 folder.
### Tap Attack
If you would rather not attack titans and let your heroes do it for you go ahead and turn this off. Keep in mind this will prevent pet attacks from occuring if you have less than 500 pet levels. Will not effect clan quests.
### Prestige Timer
After X minutes you will prestige. This timer is stored outside of the script so starting/stopping the script will not change the time. Setting this to 0 will disable auto-prestige. If you would like to clear the last prestige time manually delete ```prestige.txt``` from the TT2 folder. 

## Status
The bot currently has basic functionality with only a few minor issues that are being worked on so I'm releasing it as is. There will be minor updates in the future fixing any issues. The two additional features planned are:

 1. Hero recognition for Nohni, Finn, and Damon (in progress).
 2. Advanced skill usage based on mana.

A premium version of this script is planned to be released on the AutoTouch store with advanced features such as clan hopping during cq cooldown, auto tournament to max bracket stage, purchasing pets from the store and more. To be announced soon<sup>tm</sup>. 

### Issues
If you have a feature request or bug report go ahead and throw something up [here](https://github.com/kaijxc/TT2B/issues/new). 