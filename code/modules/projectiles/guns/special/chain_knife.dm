/// Chain knife
/obj/item/gun/magic/chain_knife
	name = "chain knife"
	desc = ""
	ammo_type = /obj/item/ammo_casing/magic/chain_knife
	icon_state = "hook"
	base_icon_state = "hook"
	inhand_icon_state = "hook"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	fire_sound = 'sound/weapons/batonextend.ogg'
	pinless = TRUE
	max_charges = 1
	sharpness = SHARP_EDGED
	force = 10
	antimagic_flags = NONE

	var/force_wielded = 18
	var/force_unwielded = 10

/obj/item/gun/magic/chain_knife/shoot_with_empty_chamber(mob/living/user)
	balloon_alert(user, "not ready yet!")

/obj/item/gun/magic/chain_knife/can_trigger_gun(mob/living/user, akimbo_usage) // This isn't really a gun, so it shouldn't be checking for TRAIT_NOGUNS, a firing pin (pinless), or a trigger guard (guardless)
	if(akimbo_usage)
		return FALSE //this would be kinda weird while shooting someone down.
	if(!HAS_TRAIT(src, TRAIT_WIELDED))
		return //has to be wielded to fire
	return TRUE

/obj/item/gun/magic/chain_knife/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/anti_magic, MAGIC_RESISTANCE|MAGIC_RESISTANCE_HOLY)
	AddComponent(/datum/component/effect_remover, \
		success_feedback = "You disrupt the magic of %THEEFFECT with %THEWEAPON.", \
		success_forcesay = "BEGONE FOUL MAGIKS!!", \
		tip_text = "Clear rune", \
		on_clear_callback = CALLBACK(src, PROC_REF(on_cult_rune_removed)), \
		effects_we_clear = list(/obj/effect/rune, /obj/effect/heretic_rune, /obj/effect/cosmic_rune), \
	)
	AddElement(/datum/element/bane, target_type = /mob/living/basic/revenant, damage_multiplier = 0, added_damage = 25, requires_combat_mode = FALSE)
	AddComponent(/datum/component/two_handed, force_unwielded=force_unwielded, force_wielded=force_wielded, icon_wielded="[base_icon_state]")

/obj/item/gun/magic/chain_knife/proc/on_cult_rune_removed(obj/effect/target, mob/living/user)
	SIGNAL_HANDLER
	if(!istype(target, /obj/effect/rune))
		return

	var/obj/effect/rune/target_rune = target
	if(target_rune.log_when_erased)
		user.log_message("erased [target_rune.cultist_name] rune using [src]", LOG_GAME)
	SSshuttle.shuttle_purchase_requirements_met[SHUTTLE_UNLOCK_NARNAR] = TRUE

/obj/item/ammo_casing/magic/chain_knife
	name = "hook"
	desc = "A hook."
	projectile_type = /obj/projectile/chain_knife
	caliber = CALIBER_HOOK
	firing_effect_type = /obj/effect/temp_visual/dir_setting/firing_effect

/obj/projectile/chain_knife
	name = "hook"
	icon_state = "hook"
	icon = 'icons/obj/mining_zones/artefacts.dmi'
	pass_flags = PASSTABLE
	damage = 25
	armour_penetration = 40
	damage_type = BRUTE
	hitsound = 'sound/effects/splat.ogg'
	range = 5 //about 4 tiles of travel
	/// The chain we send out while we are in motion.
	var/datum/beam/chain

/obj/projectile/chain_knife/fire(setAngle)
	if(firer)
		chain = firer.Beam(src, icon_state = "chain", emissive = FALSE)
	return ..()

/obj/projectile/chain_knife/Destroy(force)
	QDEL_NULL(chain)
	return ..()
