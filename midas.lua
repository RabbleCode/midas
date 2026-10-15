midas = {};

function midas:OnLoad()
    SLASH_MIDAS1 = "/midas";
    
	SlashCmdList["MIDAS"] = function(setName) midas:DisplaySessionEarnings() end

	midasFrame:RegisterEvent("PLAYER_LOGIN")
    midasFrame:RegisterEvent("PLAYER_MONEY")
	midasFrame:RegisterEvent("PLAYER_LOGOUT")
end

function midas:OnEvent(self, event, ...)
	local arg1, arg2, arg3, arg4 = ...
	if event == "PLAYER_LOGIN" then
        midasFrame:UnregisterEvent("PLAYER_LOGIN");
		midas:LoadPlayerData();        
		midas:Announce();
    elseif event == "PLAYER_MONEY" then
        midas:UpdateSessionMoney()        
	elseif event == "PLAYER_LOGOUT" then
	 	midasFrame:UnregisterEvent("PLAYER_LOGOUT");
        midas:SaveSessionMoney()
    end
end

function midas:LoadPlayerData()

	midas.Player = {}
    midas.Player.Name = UnitName("player")
    midas.Player.Realm = GetRealmName()
	midas.Player.Faction = select(1, UnitFactionGroup("player")) -- Select the non-localized (English) faction name
	midas.Player.Class = select(2, UnitClass("player")) -- Select the non-localized (English) class name
    midas.Player.Money = {}
    midas.Player.Money.SessionStart = GetMoney();
    midas.Player.Money.SessionEnd = GetMoney();
end

function midas:Announce()    
    midas:PrintMessageWithPrefix("activated. Starting gold: ".. GetCoinTextureString(midas.Player.Money.SessionStart));
end

function midas:PrintMessageWithPrefix(message)
    midas:PrintMessage(YELLOW_FONT_COLOR_CODE.."MIDAS|r | "..message)
end
    
function midas:PrintMessage(message)
    DEFAULT_CHAT_FRAME:AddMessage(message)
end

function midas:DisplaySessionEarnings()
    local earnings = midas:GetSessionEarnings()
    if(earnings < 0) then
        midas:PrintMessageWithPrefix(RED_FONT_COLOR_CODE..'Lost|r '..GetCoinTextureString(math.abs(earnings))..' this session.')
    elseif(earnings > 0) then
        midas:PrintMessageWithPrefix(GREEN_FONT_COLOR_CODE..'Gained|r '..GetCoinTextureString(earnings)..' this session.')
    else
        midas:PrintMessageWithPrefix(GetCoinTextureString(earnings)..' changed this session.')
    end
end

function midas:GetSessionEarnings()
   local current = GetMoney()
   return current - midas.Player.Money.SessionStart 
end

function midas:UpdateSessionMoney()    
    midas.Player.Money.SessionEnd = GetMoney()
end

function midas:SaveSessionMoney()
    if(MidasGoldAmounts == nil) then
        MidasGoldAmounts = {}
    end

    if(MidasGoldAmounts[midas.Player.Realm] == nil) then
        MidasGoldAmounts[midas.Player.Realm] = {}
    end

    if(MidasGoldAmounts[midas.Player.Realm][midas.Player.Name] == nil) then
        MidasGoldAmounts[midas.Player.Realm][midas.Player.Name] = {}
    end

    local d = date("%Y%m%d")
    if(MidasGoldAmounts[midas.Player.Realm][midas.Player.Name][d] == nil) then
        MidasGoldAmounts[midas.Player.Realm][midas.Player.Name][d] = {}
    end

    local t = date("%H:%M:%S")
    if(MidasGoldAmounts[midas.Player.Realm][midas.Player.Name][d][t] == nil) then
        MidasGoldAmounts[midas.Player.Realm][midas.Player.Name][d][t] = {}
    end

    MidasGoldAmounts[midas.Player.Realm][midas.Player.Name][d][t] = midas.Player.Money
end