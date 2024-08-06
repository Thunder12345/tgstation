/*

The Goat King



Difficulty: Hard

*/

/mob/living/simple_animal/hostile/megafauna/goatking
	name = "Goat King"
	desc = "The oldest and wisest of the goats. Its golden fleece glitters and sparkles in the light."
	health = 2500
	maxHealth = 2500
	attack_verb_continuous = "headbutts"
	attack_verb_simple = "headbutt"
	attack_sound = 'sound/magic/demon_attack1.ogg'
	icon_state = "goat"
	icon_living = "goat"
	icon_dead = "goat_dead"
	friendly_verb_continuous = "stares down"
	friendly_verb_simple = "stare down"
	icon = 'icons/mob/simple/animal.dmi'
	speak_emote = list("brays")
	armour_penetration = 25
	melee_damage_lower = 25
	melee_damage_upper = 25
	speed = 2
	move_to_delay = 5
	retreat_distance = 5
	minimum_distance = 5
	rapid_melee = 8 // every 1/4 second
	melee_queue_distance = 20 // as far as possible really, need this because of blood warp
	ranged = TRUE
	del_on_death = TRUE
	crusher_loot = list(/obj/structure/closet/crate/necropolis/bubblegum/crusher)
	loot = list(/obj/structure/closet/crate/necropolis/bubblegum)
	gps_name = "Bleating Signal"
	achievement_type = /datum/award/achievement/boss/king_goat_kill
	crusher_achievement_type = /datum/award/achievement/boss/bubblegum_crusher
	score_achievement_type = /datum/award/score/bubblegum_score
	death_message = "bleats one last time, before falling over dead... "
	death_sound = 'sound/magic/enter_blood.ogg'
	summon_line = "EHEHEHEHEHEHEHEHE!"

/mob/living/simple_animal/hostile/megafauna/Initialize(mapload)
	. = ..()
	name = goatking_name()
	AddComponent(/datum/component/seethrough_mob)
	if(gps_name && true_spawn)
		AddComponent(/datum/component/gps, gps_name)
	ADD_TRAIT(src, TRAIT_SPACEWALK, INNATE_TRAIT)
	add_traits(list(TRAIT_NO_TELEPORT, TRAIT_MARTIAL_ARTS_IMMUNE), MEGAFAUNA_TRAIT)
	grant_actions_by_list(attack_action_types)
