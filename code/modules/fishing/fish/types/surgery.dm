/obj/item/fish/blood_eel
	name = "pulsating blood eel"
	fish_id = "bloodeel"
	desc = "..."
	icon_state = "bloodeel"
	sprite_width = 7
	sprite_height = 5
	random_case_rarity = FISH_RARITY_NOPE
	required_fluid_type = AQUARIUM_FLUID_BLOOD
	fillet_type = /obj/item/food/meat/slab/human/mutant/zombie //eww...
	fish_traits = list(/datum/fish_trait/necrophage, /datum/fish_trait/aberrant/blood_eel)
	required_temperature_min = MIN_AQUARIUM_TEMP+15
	required_temperature_max = MIN_AQUARIUM_TEMP+35
	fish_movement_type = /datum/fish_movement/zippy
	favorite_bait = list(
		list(
			FISH_BAIT_TYPE = FISH_BAIT_FOODTYPE,
			FISH_BAIT_VALUE = MEAT
		)
	)
	beauty = FISH_BEAUTY_DISGUSTING

/obj/item/fish/blood_eel/get_fish_taste()
	return list("vermin" = 2, "maintenance" = 1)

/obj/item/fish/blood_eel/get_fish_taste_cooked()
	return list("cooked vermin" = 2, "burned fur" = 0.5)

/obj/item/fish/ratfish/get_food_types()
	return MEAT|RAW|GORE //Not-so-quite-seafood
