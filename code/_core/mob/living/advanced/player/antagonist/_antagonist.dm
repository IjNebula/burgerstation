/mob/living/advanced/player/antagonist/
	var/loadout/loadout_to_use
	class = /class/player/antagonist
	allow_save = FALSE

	level = 40

/mob/living/advanced/player/antagonist/on_add_xp(var/experience/E,var/added_xp)

	. = ..()

	if(added_xp > 0 && client) //Don't give rewards to afk players.
		var/savedata/client/globals/GD = GLOBALDATA(client.ckey)
		if(!GD) return FALSE
		if(!GD.loaded_data["stored_experience"])
			GD.loaded_data["stored_experience"] = list()
		GD.loaded_data["stored_experience"][E.id] += added_xp

/mob/living/advanced/player/antagonist/adjust_currency(var/currency_to_add)

	. = ..()

	if(currency_to_add > 0 && client) //Don't give rewards to afk players.
		var/savedata/client/globals/GD = GLOBALDATA(client.ckey)
		if(GD) GD.loaded_data["stored_currency"] += currency_to_add



