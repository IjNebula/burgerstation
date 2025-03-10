/obj/item/storage/egg_carton
	name = "egg carton"
	desc = "Stores eggs."
	desc_extended = "Holds eggs."
	icon = 'icons/obj/item/storage/egg_carton.dmi'
	icon_state = "eggbox"

	dynamic_inventory_count = 12
	max_inventory_x = 6
	container_max_slots = 1

	container_whitelist = list(
		/obj/item/container/edible/egg/chicken,
	)

	size = SIZE_3

	value = 10


/obj/item/storage/egg_carton/update_icon()

	. = ..()

	var/filled_slots = 0
	for(var/k in src.inventories)
		var/obj/hud/inventory/I = k
		filled_slots += length(I.contents)

	icon_state = "[initial(icon_state)][clamp(filled_slots,0,12)]"


/obj/item/storage/egg_carton/fill_inventory()
	for(var/i=1,i<=dynamic_inventory_count,i++)
		new/obj/item/container/edible/egg/chicken(src)
	. = ..()

/obj/item/storage/egg_carton/update_inventory()
	. = ..()
	update_sprite()
