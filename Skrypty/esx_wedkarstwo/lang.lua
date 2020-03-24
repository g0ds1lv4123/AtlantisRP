msg = {}
------------------------------------
-- en / fr / custom
-- Select your lang.
msg.lang = 'en' 

------------------------------------
-- chatMessage
if msg.lang == 'custom' then
	msg[1] = "1 - custom text "
	msg[2] = "2 - custom text "
	msg[3] = "3 - custom text "
	msg[4] = "4 - custom text "
	msg[5] = "5 - custom text "
	msg[6] = "6 - custom text "

elseif msg.lang == 'en' then
	msg[1] = "Zarzucasz wędkę i czekasz ..."
	msg[2] = "Ryba uciekła ..."
	msg[3] = "O jaka piękna rybka!"
	msg[4] = "Niech to! Uciekła!"
	msg[5] = "Bierze!"
	msg[6] = "Musisz stać w wodzie!"
	msg[7] = "Nie posiadasz pozwolenia na łowienie w tym miejscu!"
	msg[8] = "Posiadasz pozwolenie na łowienie w tym miejscu."

elseif msg.lang == 'fr' then
	msg[1] = "Vous avez lancé votre appât, attendez qu'un poisson morde ..."
	msg[2] = "Le poisson s'est échappé ..."
	msg[3] = "Vous avez attrapé un poisson !"
	msg[4] = "Le poisson s'est échappé !"
	msg[5] = "Vous en avez un, ferrez le !"
	msg[6] = "Vous devez être dans l'eau pour pêcher !"

else
	msg[1] = "^1 msg.lang ERROR from lang.lua"
	msg[2] = "^1 msg.lang ERROR from lang.lua"
	msg[3] = "^1 msg.lang ERROR from lang.lua"
	msg[4] = "^1 msg.lang ERROR from lang.lua"
	msg[5] = "^1 msg.lang ERROR from lang.lua"
	msg[6] = "^1 msg.lang ERROR from lang.lua"

end