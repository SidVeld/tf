/datum/sex_action/masturbate_penis_other
	name = "Вздрочнуть ему"
	check_same_tile = FALSE

/datum/sex_action/masturbate_penis_other/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(!target.getorganslot(ORGAN_SLOT_PENIS))
		return FALSE
	return TRUE

/datum/sex_action/masturbate_penis_other/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(!get_location_accessible(target, BODY_ZONE_PRECISE_GROIN))
		return FALSE
	if(!target.getorganslot(ORGAN_SLOT_PENIS))
		return FALSE
	return TRUE

/datum/sex_action/masturbate_penis_other/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	..()
	if(HAS_TRAIT(user, TRAIT_TINY) && !(HAS_TRAIT(target, TRAIT_TINY)))	//Make it more explicit in telling the size difference, fairies need both hands
		user.visible_message(span_warning("[user] проталкивает меж своих сложенных ладоней крохотный пенис [target]..."))
	else if(!(HAS_TRAIT(user, TRAIT_TINY)) && HAS_TRAIT(target, TRAIT_TINY))
		user.visible_message(span_warning("[user] наяривает член [target] большим и указательным пальцами..."))
	else
		user.visible_message(span_warning("[user] надрачивает пенис [target]..."))

/datum/sex_action/masturbate_penis_other/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user.sexcon.do_message_signature("[type]"))
		user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] дрочит хер [target]..."))
	playsound(user, 'sound/misc/mat/fingering.ogg', 30, TRUE, -2, ignore_walls = FALSE)

	user.sexcon.perform_sex_action(target, 2, 0, TRUE)

	target.sexcon.handle_passive_ejaculation()

/datum/sex_action/masturbate_penis_other/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	..()
	user.visible_message(span_warning("[user] перестает надрачивать [target]."))

/datum/sex_action/masturbate_penis_other/is_finished(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(target.sexcon.finished_check())
		return TRUE
	return FALSE
