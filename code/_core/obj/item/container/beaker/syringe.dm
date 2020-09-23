/obj/item/container/syringe
	name = "syringe"
	desc = "For when you want to poke holes into people and get away with it."
	desc_extended = "Holds reagents. Can be toggled to inject or draw."
	crafting_id = "syringe"

	icon = 'icons/obj/item/container/syringe.dmi'
	icon_state = "syringe"

	reagents = /reagent_container/syringe/

	var/icon_count = 7

	var/inject_amount = 15
	var/draw_amount = 5

	var/injecting = FALSE

	value = 15

	//Contains special snowflake code.
	allow_reagent_transfer_to = FALSE
	allow_reagent_transfer_from = FALSE

/obj/item/container/syringe/get_examine_list(var/mob/examiner)
	return ..() + div("notice",reagents.get_contents_english())

/obj/item/container/syringe/on_pickup(var/atom/old_location,var/obj/hud/inventory/new_location) //When the item is picked up.
	update_sprite()
	return ..()


/obj/item/container/syringe/drop_item(var/atom/desired_loc,var/pixel_x_offset = 0,var/pixel_y_offset = 0)
	. = ..()
	update_sprite()
	return .

/obj/item/container/syringe/update_icon()

	icon = initial(icon)
	icon_state = initial(icon_state)

	var/num_state = CEILING(clamp(reagents.volume_current/reagents.volume_max,0,1)*icon_count,1)

	var/icon/I = icon(icon,"[icon_state]_[num_state]")
	var/icon/I2 = icon(icon,"liquid")

	if(reagents && reagents.volume_current)
		I2.Blend(reagents.color,ICON_MULTIPLY)
		I.Blend(I2,ICON_UNDERLAY)

	if(src.loc && is_inventory(src.loc))
		var/icon/I3 = icon(icon,"action_[injecting]")
		I.Blend(I3,ICON_OVERLAY)

	icon = I

	return ..()

/obj/item/container/syringe/click_self(var/mob/caller,location,control,params)
	injecting = !injecting
	update_sprite()
	return TRUE

/obj/item/container/syringe/proc/can_inject(var/mob/caller,var/atom/target)

	INTERACT_CHECK
	INTERACT_CHECK_OTHER(target)

	if(!target || !target.reagents)
		caller.to_chat("You can't target this!")
		return FALSE

	return TRUE


/obj/item/container/syringe/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	var/atom/defer_object = object.defer_click_on_object(location,control,params)

	if(is_inventory(defer_object))
		return ..()

	if(istype(defer_object,/obj/item/container/))
		inject(caller,object,injecting ? inject_amount : -draw_amount)
		return TRUE

	var/self_inject = caller == object

	if(can_inject(caller,defer_object))

		var/real_object_name = defer_object.name

		if(is_organ(defer_object) && is_living(object))
			real_object_name = "[object.name]'s [object.name]"

		var/transfer_amount = 0
		if(injecting)
			transfer_amount = inject_amount
			caller.visible_message("\The [caller.name] tries to inject \the [real_object_name] with \the [src.name]!")
		else
			caller.visible_message("\The [caller.name] tries to draw blood from \the [real_object_name] with \the [src.name]!")
			transfer_amount = -draw_amount

		PROGRESS_BAR(caller,src,self_inject ? BASE_INJECT_TIME_SELF : BASE_INJECT_TIME,.proc/inject,caller,object,transfer_amount)
		PROGRESS_BAR_CONDITIONS(caller,src,.proc/can_inject,caller,object)

	return TRUE

/obj/item/container/syringe/proc/inject(var/mob/caller,var/atom/object,var/amount=5)

	if(object.reagents)
		if(amount > 0)
			var/transfer_amount = reagents.transfer_reagents_to(object.reagents,amount)
			if(transfer_amount)
				caller.to_chat(span("notice","You inject [transfer_amount] units of liquid into \the [object]."))
				return TRUE

		else if(amount < 0)
			var/transfer_amount = object.reagents.transfer_reagents_to(reagents,-amount)
			if(transfer_amount)
				caller.to_chat(span("notice","You draw [transfer_amount] units of liquid from \the [object]."))
				return TRUE

	if(is_organ(object) && is_living(object.loc))
		var/mob/living/L = object.loc
		L.to_chat("You feel a tiny prick.")
	else if(is_living(object))
		var/mob/living/L = object
		L.to_chat("You feel a tiny prick.")

	return FALSE

/obj/item/container/syringe/epinephrine/
	name = "syringe (epinephrine)"

/obj/item/container/syringe/epinephrine/Generate()
	reagents.add_reagent(/reagent/medicine/adrenaline/epinephrine,reagents.volume_max)
	return ..()