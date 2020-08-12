/datum/precise_rod_handler
	var/turf/start_loc
	var/turf/end_loc

/datum/precise_rod_handler/proc/show_report()
	if(start_loc)
		to_chat(usr, "Current Start Pos: [start_loc.x],[start_loc.y],[start_loc.z] | <a href=?src=[UID()];set=start>Set</a>")
	else
		to_chat(usr, "Current Start Pos: <b>Unset</b> | <a href=?src=[UID()];set=start>Set</a>")

	if(end_loc)
		to_chat(usr, "Current End Pos: [end_loc.x],[end_loc.y],[end_loc.z] | <a href=?src=[UID()];set=end>Set</a>")
	else
		to_chat(usr, "Current End Pos: <b>Unset</b> | <a href=?src=[UID()];set=end>Set</a>")

	if(start_loc && end_loc)
		if(start_loc.z != end_loc.z)
			to_chat(usr, "Launch: <b>Unable, Z-level between points differs</b>")
		else
			to_chat(usr, "Launch: <a href=?src=[UID()];launch=1>LAUNCH</a>")
	else
		to_chat(usr, "Launch: <b>Missing start or end position</b>")

/datum/precise_rod_handler/Topic(href, href_list)
	if(href_list["set"])
		switch(href_list["set"])
			if("start")
				if(isturf(usr.loc))
					start_loc = usr.loc
					to_chat(usr, "Start position set to [start_loc.x],[start_loc.y],[start_loc.z]")
				else
					to_chat(usr, "Start position not a turf")
			if("end")
				if(isturf(usr.loc))
					end_loc = usr.loc
					to_chat(usr, "End position set to [end_loc.x],[end_loc.y],[end_loc.z]")
				else
					to_chat(usr, "End position not a turf")
	if(href_list["launch"])
		message_admins("[key_name_admin(usr)] launched a precise rod starting at [ADMIN_VERBOSEJMP(start_loc)] and ending at [ADMIN_VERBOSEJMP(end_loc)]")
		new /obj/effect/immovablerod/admin(start_loc, end_loc)

/client/proc/precise_rod()
	set name = "Precise Rod"
	set category = "Event"

	if(!check_rights(R_EVENT))
		return

	holder.prh.show_report()
