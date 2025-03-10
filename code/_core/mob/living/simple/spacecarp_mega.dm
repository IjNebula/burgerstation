/mob/living/simple/megacarp
	name = "space megacarp"
	icon = 'icons/mob/living/simple/megacarp.dmi'
	icon_state = "living"

	damage_type = /damagetype/unarmed/bite/

	ai = /ai/

	health_base = 300
	stamina_base = 300
	mana_base = 50

	value = 400

	butcher_contents = list(
		/obj/item/container/edible/dynamic/fish/raw_carp/,
		/obj/item/container/edible/dynamic/fish/raw_carp/,
		/obj/item/container/edible/dynamic/fish/raw_carp/,
		/obj/item/container/edible/dynamic/fish/raw_carp/,
		/obj/item/container/edible/dynamic/fish/raw_carp/,
		/obj/item/container/edible/dynamic/fish/raw_carp/
	)

	collision_flags = FLAG_COLLISION_FLYING | FLAG_COLLISION_SWIMMING
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

	armor = /armor/carp/shark

	size = SIZE_GIANT

	movement_delay = DECISECONDS_TO_TICKS(2)

	has_footsteps = FALSE

	pixel_x = -16

	loyalty_tag = "Shark"
	iff_tag = "Shark"

	blood_type = /reagent/blood/carp
	blood_volume = 750

	level = 22
