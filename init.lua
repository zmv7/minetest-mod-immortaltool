local selected_objects = {}
minetest.register_tool("immortaltool:tool", {
	description = "Immortal tool" .."\n"..
		"Toogle immortal of enitities" .."\n"..
		"Punch object: toggle object" .."\n"..
		"Shift+Punch : toggle yourself",
	inventory_image = "immortaltool.png",
	groups = {not_in_creative_inventory=1},
	on_use = function(itemstack, user, pointed_thing)
		if not minetest.check_player_privs(user, "immortaltool") then
			return {name = ""}
		end
		local name = user:get_player_name()
local ctrl = user:get_player_control()
if pointed_thing.type == "object" then
	selected_objects[name] = pointed_thing.ref
	elseif ctrl.sneak then
	selected_objects[name] = user
	else return end
		local armor = selected_objects[name]:get_armor_groups()
if armor.immortal then
minetest.show_formspec(name,"setfleshy","size[3,1.5]background[0,0;3,2;immtool_bg.png;true]field[0.3,0.5;3,1;fleshy;Fleshy:;100]button_exit[0.5,1;2,1;submit;Submit]")
else
selected_objects[name]:set_armor_groups({immortal=1})
if selected_objects[name] == user then
	minetest.chat_send_player(name,minetest.colorize('#FF0','You immortal now')) end
end
end,
})

minetest.register_on_player_receive_fields(function(user, formname, fields)
if formname == "setfleshy" then
	local name = user:get_player_name()
	local fleshy = tonumber(fields.fleshy)
	if not fleshy or fleshy <-5 then minetest.chat_send_player(name,"Invalid value / out of range") return
	else
	selected_objects[name]:set_armor_groups({fleshy=fields.fleshy})	
	if selected_objects[name] == user then
	minetest.chat_send_player(name,minetest.colorize('#FF0','Your fleshy now is '..fleshy)) end
	end
end 
end)

minetest.register_alias("immtool", "immortaltool:tool")
minetest.register_privilege("immortaltool", {description = "Ability to wield immortal tool",give_to_singleplayer = false})
