/**
  * # Client Anticheat
  *
  * This is a datum to be attached to clients, and serves for a central point for checking visibility exploits, aimbot, and clickspam
  *
  * If you edit any of these procs, PLEASE ensure the edited versions do not false-positive for legitimate players
  * I cannot stress this enough, -aa07
  */
/datum/client_anticheat
	/// Has any cheat detection been tripped?
	var/tripped = FALSE
	/// Client anticheat log
	var/list/log = list()

	/* Clickspam vars */
	/// Clickspam strikes. Three strikes, and youre out
	var/clickspam_strikes = 0
	/// Next time to check clickspam (Avoids admin spamming)
	var/clickspam_next_check = 0

	/* Vischeck vars */
	/// Next time to check visibility (Avoids admin spamming)
	var/vischeck_next_check = 0

	/* Aimbot vars */
	/// Last x-offset of click
	var/aimbot_last_x = 0
	/// Last y-offset of click
	var/aimbot_last_y = 0
	/// last atom clicked
	var/atom/aimbot_last_atom = null
	/// Next time to check aimbot (Avoids admin spamming)
	var/aimbot_next_check = 0



/**
  * Helper for logging anticheat data
  *
  * Takes a text argument and generates a nice log entry, adding a timestamp
  *
  * Arguments:
  * * type - Type of detection tripped
  * * text - Text for the log entry
  */
/datum/client_anticheat/proc/log_message(text)
	tripped = TRUE // Mark as tripped for the sake of iteration
	log += "<b>\[[time_stamp()]] \[[type]]</b> \[[text]]"

/**
  * Clickspam handler
  *
  * Called whenever a client clicks too much. Works on a "3 strikes youre out" principal, with each strike getting worse
  *
  * Arguments:
  * * M - The mob who clicked
  */
/datum/client_anticheat/proc/handle_clickspam(mob/M)
	// We dont want someone to burn through all their strikes instantly
	// Give them a chance atleast
	if(world.time < clickspam_next_check)
		return

	switch(clickspam_strikes)
		if(0)
			// First strike, force them to click a second later
			clickspam_strikes++
			M.changeNext_click(1 SECONDS)
			clickspam_next_check = world.time + 1 SECONDS
			// And inform admins obviously
			message_admins("[key_name_admin(usr)] has hit clickspam strike 1/3. Potential autoclicker or modified client use.")
			log_message("CLICKSPAM", "Hit clickspam strike 1/3")
		if(1)
			// Second strike, force them to click 3 seconds later
			clickspam_strikes++
			M.changeNext_click(3 SECONDS)
			clickspam_next_check = world.time + 3 SECONDS
			// And inform admins obviously
			message_admins("[key_name_admin(usr)] has hit clickspam strike 2/3. If they continue to use an autoclicker or modified client, they will be kicked.")
			log_message("CLICKSPAM", "Hit clickspam strike 2/3")
		if(2)
			// Third strike, goodbye
			message_admins("[key_name_admin(usr)] has hit clickspam strike 3/3. They have been kicked from the server.")
			to_chat(usr, "<span class='boldannounce'>You have been kicked from the server.</span>")
			log_message("CLICKSPAM", "Hit clickspam strike 3/3 and was autokicked")
			qdel(usr.client) // Nuke their client

/**
  * Vision check handler
  *
  * Called whenever a client clicks an atom. Alerts admins if they click on something which is vision obscured
  *
  * Arguments:
  * * M - The mob who clicked
  * * A - The atom that was clicked
  */
/datum/client_anticheat/proc/handle_vischeck(mob/M, atom/A)
	if(can_see(M, A))
		// They clicked the atom, and they can see it
		return FALSE
	else
		// They clicked the atom, and they cant see it. Oh no.
		// Only alert admins every so often
		if(world.time < vischeck_next_check)
			return TRUE
		message_admins("[key_name_admin(usr)] has clicked an atom they should not be able to see. Potential modified client use, but could also be a misclick into obscured screen area.")
		log_message("VISCHECK", "Clicked an atom they should not be able to see. Potential modified client use, but could also be a misclick into obscured screen area.")
		// Dont spam the admins thanks
		vischeck_next_check = world.time + 30 SECONDS
		return TRUE

/datum/client_anticheat/proc/handle_aimbot(data)
	var/list/param_list = params2list(data)
	message_admins("X: [param_list["icon-x"]] | Y: [param_list["icon-y"]]")
