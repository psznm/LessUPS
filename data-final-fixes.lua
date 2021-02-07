local mult = 2;

--TODO: animations "animation_speed" increases too much, idk why
--TODO: spidertron is not quite right, it speeds up but not as much as it should
--TODO: name = "atomic-bomb-wave-spawns-nuclear-smoke", (speed_modifier)

--TODO: Later - fire spread
--TODO: Later - day/night
--TODO: Later - player crafting speed
--TODO: Probably not - jetpack


function recursive_crawl ( obj )
	if (type(obj) == "table") then
		for key, value in pairs(obj) do
			if (type(obj[key]) == "table") then
				for i, property in ipairs({
					"consumption", "energy_usage", "energy_consumption", "max_power_output", 
					"production", "energy_per_movement", "energy_per_rotation", "energy_production",
					"braking_power", "input_flow_limit", "output_flow_limit", "drain",
					"max_power", "movement_energy_consumption", "specific_heat", "max_transfer",
					"power"
				}) do
					if obj[key][property] ~= nil and type(obj[key][property]) ~= "table" then
						local number_str = string.match (obj[key][property], "%d+");
						local unit = obj[key][property]:sub(number_str:len()-obj[key][property]:len());
						local units_num = tostring(tonumber(number_str) * mult);
						obj[key][property] = units_num .. unit;
					end
				end

				if key == 'ammo_type' then					
					if obj[key]["energy_consumption"] ~= nil and type(obj[key]["energy_consumption"]) ~= "table" then
						local number_str = string.match (obj[key]["energy_consumption"], "%d+");
						local unit = obj[key]["energy_consumption"]:sub(number_str:len()-obj[key]["energy_consumption"]:len());
						local units_num = tostring(tonumber(number_str) / mult);
						obj[key]["energy_consumption"] = units_num .. unit;
					end
				end
		
				for i, property in ipairs({
					"crafting_speed", "mining_speed", "researching_speed", "pumping_speed",
					"rising_speed", "engine_starting_speed", "flying_speed", "flying_acceleration",
					"extension_speed", "rotation_speed", "opening_speed", "speed", "friction", 
					"turret_rotation_speed", "running_speed", "healing_per_tick", 
					"initial_movement_speed", "movement_acceleration", "opening_speed",
					"emissions_per_minute", "folded_speed", "folded_speed_secondary", 
					"preparing_speed", "prepared_speed", "prepared_speed_secondary",
					"prepared_alternative_speed", "prepared_alternative_speed_secondary",
					"starting_attack_speed", "ending_attack_speed","folding_speed",
					"attacking_speed", "max_speed", "braking_force", "friction_force",
					"lead_target_for_projectile_speed", "acceleration", "turn_speed", 
					"fluid_consumption", "particle_vertical_acceleration",
					"particle_horizontal_speed", "particle_horizontal_speed_deviation",
					"vertical_speed", "horizontal_speed", "vertical_speed_deviation", 
					"horizontal_speed_deviation", "starting_vertical_speed", 
					"starting_vertical_speed_deviation", "vertical_speed_slowdown",
					"scale_increment_per_tick", "movement_speed", "fluid_usage_per_tick",
					"torso_rotation_speed"

					-- "animation_speed"
				}) do	
					if obj[key][property] ~= nil and type(obj[key][property]) ~= "table" then
						obj[key][property] = obj[key][property] * mult;
					end
				end
		
				for i, property in ipairs({
					"turret_return_timeout", "time_to_live", "fade_away_duration", "life_time",
					"ticks_to_keep_gun", "ticks_to_keep_aiming_direction", "ticks_to_stay_in_combat",
					"cooldown", "cooldown_deviation", "spread_duration", "duration", "fade_in_duration",
					"time_to_live_deviation", "time_before_start", "time_before_start_deviation",
					"fade_out_duration", "scale_out_duration", "scale_in_duration", "distraction_cooldown",
					"min_pursue_time", "max_pursue_distance"
					
		
				}) do	
					if obj[key][property] ~= nil and type(obj[key][property]) ~= "table" then
						obj[key][property] = obj[key][property] / mult;
					end
				end

				if (key == "fluid_box") then
					if obj[key]["height"] ~= nil then
						obj[key]["height"] = obj[key]["height"] * mult;
					else
						obj[key]["height"] =mult;
					end
				else
					recursive_crawl(obj[key])
				end
			end
		end
	  else
		-- do other stuff instead
	  end
end

recursive_crawl(data.raw)
