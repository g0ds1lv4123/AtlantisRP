local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}
 
local animname = nil
local voice = {default = 10.0, shout = 26.0, whisper = 3.0, current = 1, level = nil, start = 0.1}
 
function drawLevel(r, g, b, a)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextScale(0.5, 0.5)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
 
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(_U('voice', voice.level))
    EndTextCommandDisplayText(0.175, 0.92)
end
local proxLocked = true
 RegisterNetEvent('esx_voice:UnlockProx')
AddEventHandler('esx_voice:UnlockProx', function()
    proxLocked = false
    Citizen.Wait(200)
    setVoice(voice.current)
end)
Citizen.CreateThread(function ()

    while proxLocked do
        Citizen.Wait(1)
        NetworkSetTalkerProximity(0.1)
    end

end)
AddEventHandler('onClientMapStart', function()
    NetworkSetTalkerProximity(0.1)

end)
local toggle = false
local distance = voice.default
Citizen.CreateThread(function()

--RequestAnimDict("facials@gen_male@variations@normal")
RequestAnimDict("facials@gen_male@base")
RequestAnimDict("mp_facial")

    while true do
        Citizen.Wait(1)
	
	player = GetPlayerPed(-1)

        if IsControlJustPressed(1, Keys['F5']) then
            
            
        
            voice.current = (voice.current + 1) % 3
            setVoice(voice.current)
           
            TriggerEvent("esx_customui:talking", voice.current + 1)
   
        end
        if IsControlPressed(1, Keys['CAPS']) and not IsPedOnAnyBike(PlayerPedId()) then
            local ped = GetPlayerPed(-1)
            local headPos = GetPedBoneCoords(ped, 12844, .0, .0, .0)
             DrawMarker(28, headPos, 0.0, 0.0, 0.0, 0.0, 0.0, .0, distance + .0, distance + .0, distance + .0, 20, 192, 255, 70, 0, 0, 2, 0, 0, 0, 0)
         end

 
        if NetworkIsPlayerTalking(PlayerId()) and not toggle then
            PlayFacialAnim(PlayerPedId(), "mic_chatter", "mp_facial")
            --drawLevel(41, 128, 185, 255)
            TriggerEvent("esx_customui:istalking", true)
            toggle = true
        elseif not NetworkIsPlayerTalking(PlayerId()) and toggle then
			PlayFacialAnim(PlayerPedId(), "mood_normal_1", "facials@gen_male@base")
            --drawLevel(185, 185, 185, 255)
            TriggerEvent("esx_customui:istalking", false)
            toggle = false
        end
    end
end)
function setVoice( level )
    if level == 0 then
        NetworkSetTalkerProximity(voice.whisper)
        voice.level = _U('whisper')
        distance = voice.whisper
    elseif level == 1 then
        NetworkSetTalkerProximity(voice.default)
        voice.level = _U('normal')
        distance = voice.default
    elseif level == 2 then
        NetworkSetTalkerProximity(voice.shout)
        voice.level = _U('shout')
        distance = voice.shout
    end
    --print("setVoice: "..tostring(level))
end
----- FIX NA ANIMACJE GADANIA -----

Citizen.CreateThread(function()
    RequestAnimDict("facials@gen_male@variations@normal")
   RequestAnimDict("mp_facial")

    local talkingPlayers = {}
    while true do
        Citizen.Wait(300)

        for k,v in pairs(GetPlayers()) do
            local boolTalking = NetworkIsPlayerTalking(v)
            if v ~= PlayerId() then
                if boolTalking then
                   PlayFacialAnim(GetPlayerPed(v), "mic_chatter", "mp_facial")
                    talkingPlayers[v] = true
                elseif not boolTalking and talkingPlayers[v] then
                    PlayFacialAnim(GetPlayerPed(v), "mood_normal_1", "facials@gen_male@variations@normal")
                    talkingPlayers[v] = nil
                end
            end
        end
    end
end)

--[[RegisterCommand("getprox", function(source, args, raw)
    player = GetPlayerPed(-1)
          local currentprox = NetworkGetTalkerProximity()
          --print(currentprox)    
end, false)]]

Citizen.CreateThread(function()
    while true do
    Citizen.Wait(30000)
        player = GetPlayerPed(-1)
        local currentprox = NetworkGetTalkerProximity()
            setVoice(voice.current)
           -- NetworkSetTalkerProximity(voice.default)
            --print('odswiezam voice prox')
            --print('czekam sekunde')
    end
end)

function GetPlayers()
    local players = {}

    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end

    return players
end