var/global/list/all_living = list()

/mob/living/
	var/list/experience/attribute/attributes
	var/list/experience/skill/skills
	var/list/faction/factions
	var/list/starting_factions = list()

	icon_state = "directional"

	var/class = "default"

	var/ai/ai

	mouse_over_pointer = MOUSE_ACTIVE_POINTER

	var/status = 0 //Negative status

	var/stun_time = 0 //Deciseconds of stun. Stun is being knocked down.
	var/sleep_time = 0 //Decieconds of sleep Sleep is being knocke down and blind.
	var/paralyze_time = 0 //Decieconds of paralyze. Paralyze is being unable to move.

	var/first_life = TRUE

	//Base attributes.
	var/health_base = 10
	var/stamina_base = 10
	var/mana_base = 10

	var/armor_burn_base = 0
	var/armor_brute_base = 0

	//Regeneration times are in seconds.

	var/stamina_max = 0
	var/stamina_current = 0
	var/stamina_regeneration = 0

	var/mana_max = 0
	var/mana_current = 0
	var/mana_regeneration = 0

	var/attack_mode = 1

	var/list/attack_left = list(
		list(16,16),
		list(16,16),
		list(16,16),
		list(16,16)

	)

	var/list/attack_right = list(
		list(16,16),
		list(16,16),
		list(16,16),
		list(16,16)
	)

	var/is_sneaking = FALSE
	var/stealth_mod = 0

	var/intent = INTENT_HELP

	var/level = 0

	var/turf/old_turf //Last turf someone has been in.

	var/loot_drop
	var/loot_drop_in_corpse = FALSE

	var/level_multiplier = 1 //Multiplier for enemies. Basically how much each stat is modified by.

	var/stun_angle = 0

	var/boss = FALSE
	var/boss_music

	var/list/mob/living/advanced/player/linked_players

	var/respawn = TRUE
	var/respawn_time = 300 //In deciseconds
	var/random_spawn_dir = TRUE


	var/has_footsteps = FALSE
	var/has_footprints = FALSE
	var/list/footstep_override

	collision_flags = FLAG_COLLISION_WALKING

	var/has_hard_crit = FALSE

	var/list/obj/hud/screen_blood/screen_blood

/mob/living/proc/get_brute_color()
	return "#FF0000"

/mob/living/proc/get_burn_color()
	return "#444444"

/mob/living/New(loc,desired_client,desired_level_multiplier)
	. = ..()

	if(desired_level_multiplier)
		level_multiplier *= desired_level_multiplier

	filters += filter(type="drop_shadow", x=0, y=0, size=4, offset=0, color=rgb(0,0,0))

	attributes = list()
	skills = list()
	factions = list()
	health_elements = list()
	linked_players = list()

	initialize_attributes()
	initialize_skills()

	if(ai)
		ai = new ai(src)

	if(desired_client)
		screen_blood = list()
		screen_blood += new /obj/hud/screen_blood(src,NORTHWEST)
		screen_blood += new /obj/hud/screen_blood(src,NORTHEAST)
		screen_blood += new /obj/hud/screen_blood(src,SOUTHEAST)
		screen_blood += new /obj/hud/screen_blood(src,SOUTHWEST)
		screen_blood += new /obj/hud/screen_blood(src,SOUTH)

	all_living += src

	if(boss)
		tracked_bosses[id] = src

/mob/living/destroy()
	qdel(ai)
	return ..()

/mob/living/Initialize()
	initialize_factions()
	update_stats()
	update_health()
	stamina_current = stamina_max
	mana_current = mana_max
	update_level()
	. = ..()
	if(ai)
		name = "[name] (lvl. [level])"

	if(boss)
		for(var/mob/living/advanced/player/P in view(src,VIEW_RANGE))
			for(var/obj/hud/button/boss_health/B in P.buttons)
				B.target_boss = src
				B.update_stats()

	return .

/mob/living/proc/initialize_factions()
	for(var/k in starting_factions)
		factions[k] = all_factions[k]