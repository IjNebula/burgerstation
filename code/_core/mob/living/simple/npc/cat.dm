var/global/list/mob/living/simple/npc/cat/runtime/all_runtimes = list()

/mob/living/simple/npc/cat
	name = "cat"
	desc = "A cat!"
	desc_extended = "A less obnoxious feline."
	icon = 'icons/mob/living/simple/cat_colored.dmi'
	icon_state = "living"

	immortal = TRUE // :(

	ai = /ai/cat

	var/kittens_left = 20 //Needs to be a limit. Just in case.

	var/sitting = FALSE

/mob/living/simple/npc/cat/post_move(var/atom/old_loc)

	var/old_sitting = sitting

	if(move_dir)
		sitting = FALSE
	else if(prob(25))
		sitting = TRUE

	if(sitting != old_sitting)
		update_sprite()

	return ..()

/mob/living/simple/npc/cat/update_icon()

	if(dead)
		icon_state = "dead"
	else if(sitting)
		icon_state = pick("sit","rest")
	else
		icon_state = "living"

	return ..()


/mob/living/simple/npc/cat/kitten
	name = "kitten"
	desc = "A kitten!"
	desc_extended = "A less obnoxious feline. Now smaller."
	icon = 'icons/mob/living/simple/cat_kitten.dmi'
	icon_state = "living"

	ai = /ai/cat/kitten

/mob/living/simple/npc/cat/runtime
	name = "Runtime"
	desc = "Oh no, it's multiplying!"
	desc_extended = "The CMO's favorite cat. It reproduces asexually every time the world experiences a runtime phenomenome."
	icon = 'icons/mob/living/simple/cat_black.dmi'

	loyalty_tag = "NanoTrasen"
	iff_tag = "NanoTrasen"

/mob/living/simple/npc/cat/runtime/proc/reproduce()

	if(src.qdeleting || src.dead || src.kittens_left <= 0)
		return FALSE

	var/turf/T = get_turf(src)
	if(!T)
		return FALSE

	kittens_left--

	var/mob/living/simple/npc/cat/kitten/K = new(T)
	K.iff_tag = iff_tag
	K.loyalty_tag = loyalty_tag
	INITIALIZE(K)
	GENERATE(K)
	FINALIZE(K)
	if(K.ai)
		K.ai.set_active(TRUE)

	return TRUE

/mob/living/simple/npc/cat/runtime/setup_name()
	name = initial(name)
	return TRUE

/mob/living/simple/npc/cat/runtime/Finalize()
	all_runtimes |= src
	return ..()

/mob/living/simple/npc/cat/runtime/Destroy()
	all_runtimes -= src
	return ..()