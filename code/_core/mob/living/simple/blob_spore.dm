/mob/living/simple/blob_spore

	name = "blob spore"
	desc = "Get out of my head!"
	desc_extended = "A fast-moving fragile and volatile spore of a blob designed to latch onto a sapience being's head and inject mind-controlling spores. Full control is granted when the victim succumbs to death."
	icon = 'icons/mob/living/simple/blob.dmi'
	icon_state = "blobpod"

	health_base = 25
	stamina_base = 25
	mana_base = 25

	value = 5

	ai = /ai/blob_spore

	damage_type = /damagetype/npc/blob_spore
	armor = /armor/blob/spore

	size = SIZE_ANIMAL

	movement_delay = DECISECONDS_TO_TICKS(1)

	iff_tag = "Blob"
	loyalty_tag = "Blob"

	stun_angle = 0

	enable_medical_hud = FALSE
	enable_security_hud = FALSE

	blood_volume = 100
	blood_type = /reagent/blood/blob

	level = 2

	reagents = /reagent_container/blob

	var/idle = FALSE

	delete_on_death = TRUE

/mob/living/simple/blob_spore/post_move(var/atom/old_loc)
	if(idle)
		idle = FALSE
		icon_state = initial(icon_state)

/mob/living/simple/blob_spore/post_death()

	var/turf/T = get_turf(src)
	if(T)
		reagents.add_reagent(/reagent/toxin/blob_spore,50)
		smoke(T,5,SECONDS_TO_DECISECONDS(3),reagents,src,255)
		var/reagent/R = REAGENT(blood_type)
		create_blood(
			/obj/effect/cleanable/blood/splatter,
			T,
			R.color,
			rand(-TILE_SIZE*0.25,TILE_SIZE*0.25),
			rand(-TILE_SIZE*0.25,TILE_SIZE*0.25)
		)

	. = ..()
