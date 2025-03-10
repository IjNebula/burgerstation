/obj/item/clothing/shirt/blouse
	name = "blouse"
	desc = "Standard secretary issue."
	desc_extended = "A shirt with an ample collar."
	icon = 'icons/obj/item/clothing/shirts/blouse.dmi'

	item_slot = SLOT_TORSO

	armor = /armor/cloth

	dyeable = TRUE

	polymorphs = list(
		"blouse" = COLOR_WHITE
	)

	value = 1


/obj/item/clothing/shirt/blouse/frill
	name = "striped blouse"
	desc = "Standard secretary issue."
	desc_extended = "A shirt with an ample collar, this one sporting fancy sprites"
	polymorphs = list(
		"blouse" = COLOR_GREY,
		"frill" = COLOR_WHITE
	)

/obj/item/clothing/shirt/blouse/frill/black
	polymorphs = list(
		"blouse" = COLOR_BLACK,
		"frill" = COLOR_WHITE
	)

/obj/item/clothing/shirt/blouse/frill/nanotrasen
	polymorphs = list(
		"blouse" = COLOR_NANOTRASEN,
		"frill" = COLOR_WHITE
	)

/obj/item/clothing/shirt/blouse/uniform
	name = "uniformed blouse"
	desc_extended = "A uniformed blouse. Are they really standard issue for any department...?"
	polymorphs = list(
		"blouse" = COLOR_WHITE,
		"shoulders" = COLOR_BLACK
	)

/obj/item/clothing/shirt/blouse/random/Generate()
	. = ..()
	for(var/k in polymorphs)
		polymorphs[k] = random_color()