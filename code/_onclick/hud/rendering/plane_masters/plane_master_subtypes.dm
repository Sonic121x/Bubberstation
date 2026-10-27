/atom/movable/screen/plane_master/field_of_vision_blocker
	name = "视野遮挡层"
	documentation = "此平面仅用作滤镜。它截取游戏渲染板的一部分并对其应用效果。"
	plane = FIELD_OF_VISION_BLOCKER_PLANE
	appearance_flags = PLANE_MASTER|NO_CLIENT_COLOR
	render_target = FIELD_OF_VISION_BLOCKER_RENDER_TARGET
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	render_relay_planes = list()
	// We do NOT allow offsetting, because there's no case where you would want to block only one layer, at least currently
	offsetting_flags = BLOCKS_PLANE_OFFSETTING
	// We mark as multiz_scaled FALSE so transforms don't effect us, and we draw to the planes below us as if they were us.
	// This is safe because we will ALWAYS be on the top z layer, so it DON'T MATTER
	multiz_scaled = FALSE

/atom/movable/screen/plane_master/field_of_vision_blocker/show_to(mob/mymob)
	. = ..()
	if(!. || !mymob)
		return .
	RegisterSignal(mymob, SIGNAL_ADDTRAIT(TRAIT_FOV_APPLIED), PROC_REF(fov_enabled), override = TRUE)
	RegisterSignal(mymob, SIGNAL_REMOVETRAIT(TRAIT_FOV_APPLIED), PROC_REF(fov_disabled), override = TRUE)
	if(HAS_TRAIT(mymob, TRAIT_FOV_APPLIED))
		fov_enabled(mymob)
	else
		fov_disabled(mymob)

/atom/movable/screen/plane_master/field_of_vision_blocker/proc/fov_enabled(mob/source)
	SIGNAL_HANDLER
	if(force_hidden == FALSE)
		return
	unhide_plane(source)

/atom/movable/screen/plane_master/field_of_vision_blocker/proc/fov_disabled(mob/source)
	SIGNAL_HANDLER
	hide_plane(source)

/atom/movable/screen/plane_master/clickcatcher
	name = "点击捕获层"
	documentation = "包含用作背景的屏幕对象，用于捕获屏幕空白区域的点击。 \
		<br>始终位于几乎所有其他内容下方。"
	plane = CLICKCATCHER_PLANE
	appearance_flags = PLANE_MASTER|NO_CLIENT_COLOR
	multiz_scaled = FALSE
	critical = PLANE_CRITICAL_DISPLAY

/atom/movable/screen/plane_master/clickcatcher/Initialize(mapload, datum/hud/hud_owner, datum/plane_master_group/home, offset)
	. = ..()
	RegisterSignal(SSmapping, COMSIG_PLANE_OFFSET_INCREASE, PROC_REF(offset_increased))
	offset_increased(SSmapping, 0, SSmapping.max_plane_offset)

/atom/movable/screen/plane_master/clickcatcher/proc/offset_increased(datum/source, old_off, new_off)
	SIGNAL_HANDLER
	// We only want need the lowest level
	// If my system better supported changing PM plane values mid op I'd do that, but I do NOT so
	if(new_off > offset)
		hide_plane(home?.our_hud?.mymob)

/atom/movable/screen/plane_master/parallax_white
	name = "视差白色底层"
	documentation = "本质上是视差平面的背景。它在视差平面正下方渲染，再与视差效果进行正片叠底混合。\
		<br>如果希望某个对象呈现视差效果，请将其绘制到此平面。"
	plane = PLANE_SPACE
	appearance_flags = PLANE_MASTER|NO_CLIENT_COLOR
	render_relay_planes = list(RENDER_PLANE_UNLIT_GAME, RENDER_PLANE_LIGHT_MASK)
	critical = PLANE_CRITICAL_FUCKO_PARALLAX // goes funny when touched. no idea why I don't trust byond

/atom/movable/screen/plane_master/parallax_white/Initialize(mapload, datum/hud/hud_owner, datum/plane_master_group/home, offset)
	. = ..()
	add_relay_to(GET_NEW_PLANE(RENDER_PLANE_EMISSIVE, offset), relay_layer = EMISSIVE_SPACE_LAYER)

/atom/movable/screen/plane_master/parallax_white/set_home(datum/plane_master_group/home)
	. = ..()
	if(home)
		RegisterSignal(home, COMSIG_GROUP_HUD_CHANGED, PROC_REF(hud_changed))
		hud_changed(null, null, home.our_hud)

/atom/movable/screen/plane_master/parallax_white/proc/hud_changed(datum/source, datum/hud/old_hud, datum/hud/new_hud)
	SIGNAL_HANDLER
	if(old_hud)
		UnregisterSignal(old_hud, list(SIGNAL_ADDTRAIT(TRAIT_PARALLAX_DISPLAYED), SIGNAL_REMOVETRAIT(TRAIT_PARALLAX_DISPLAYED)), PROC_REF(parallax_updated))
	if(new_hud)
		RegisterSignals(new_hud, list(SIGNAL_ADDTRAIT(TRAIT_PARALLAX_DISPLAYED), SIGNAL_REMOVETRAIT(TRAIT_PARALLAX_DISPLAYED)), PROC_REF(parallax_updated))
		parallax_updated(new_hud)

/atom/movable/screen/plane_master/parallax_white/proc/parallax_updated(datum/source)
	SIGNAL_HANDLER
	if(isnull(home.our_hud?.mymob))
		return
	if(HAS_TRAIT(home.our_hud, TRAIT_PARALLAX_DISPLAYED))
		// Gives parallax a fullwhite backdrop to multiply against
		color = list(
			0, 0, 0, 0,
			0, 0, 0, 0,
			0, 0, 0, 0,
			1, 1, 1, 1,
			0, 0, 0, 0
			)
	else
		color = initial(color)

///Contains space parallax
/atom/movable/screen/plane_master/parallax
	name = "视差"
	documentation = "包含视差效果，准确地说是承载视差效果的屏幕对象。\
		<br>请注意 BLEND_MULTIPLY。此平面的数值很低，因此绘制在几乎所有游戏内容下方。\
		<br>这样可以确保它与视差白色底层或太空平面进行正片叠底混合。底层设为纯白色，因此视差只出现在合适的位置。\
		<br>父视差平面也会向下镜像到所有子平面，以支持同时查看所有 Z 层的视差。"
	plane = PLANE_SPACE_PARALLAX
	appearance_flags = PLANE_MASTER|NO_CLIENT_COLOR
	blend_mode = BLEND_MULTIPLY
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	multiz_scaled = FALSE

/atom/movable/screen/plane_master/parallax/Initialize(mapload, datum/hud/hud_owner, datum/plane_master_group/home, offset)
	. = ..()
	if(offset != 0)
		// You aren't the source? don't change yourself
		critical = PLANE_CRITICAL_FUCKO_PARALLAX
		return
	RegisterSignal(SSmapping, COMSIG_PLANE_OFFSET_INCREASE, PROC_REF(on_offset_increase))
	RegisterSignal(SSdcs, COMSIG_NARSIE_SUMMON_UPDATE, PROC_REF(narsie_modified))
	if(GLOB.narsie_summon_count >= 1)
		narsie_start_midway(GLOB.narsie_effect_last_modified) // We assume we're on the start, so we can use this number
	offset_increase(0, SSmapping.max_plane_offset)

/atom/movable/screen/plane_master/parallax/set_home(datum/plane_master_group/home)
	. = ..()
	if(home)
		RegisterSignal(home, COMSIG_GROUP_HUD_CHANGED, PROC_REF(hud_changed))
		hud_changed(null, null, home.our_hud)

/atom/movable/screen/plane_master/parallax/proc/hud_changed(datum/source, datum/hud/old_hud, datum/hud/new_hud)
	SIGNAL_HANDLER
	if(old_hud)
		UnregisterSignal(old_hud, list(SIGNAL_ADDTRAIT(TRAIT_PARALLAX_DISPLAYED), SIGNAL_REMOVETRAIT(TRAIT_PARALLAX_DISPLAYED)), PROC_REF(parallax_updated))
	if(new_hud)
		RegisterSignals(new_hud, list(SIGNAL_ADDTRAIT(TRAIT_PARALLAX_DISPLAYED), SIGNAL_REMOVETRAIT(TRAIT_PARALLAX_DISPLAYED)), PROC_REF(parallax_updated))
		parallax_updated(new_hud)

/atom/movable/screen/plane_master/parallax/proc/parallax_updated(datum/source)
	SIGNAL_HANDLER
	if(isnull(home.our_hud?.mymob))
		return
	if(HAS_TRAIT(home.our_hud, TRAIT_PARALLAX_DISPLAYED))
		show_to(home.our_hud.mymob)
	else
		hide_from(home.our_hud.mymob)

/atom/movable/screen/plane_master/parallax/proc/on_offset_increase(datum/source, old_offset, new_offset)
	SIGNAL_HANDLER
	offset_increase(old_offset, new_offset)

/atom/movable/screen/plane_master/parallax/proc/offset_increase(old_offset, new_offset)
	// Parallax will be mirrored down to any new planes that are added, so it will properly render across mirage borders
	for(var/offset in old_offset to new_offset)
		if(offset != 0)
			// Overlay so we don't multiply twice, and thus fuck up our rendering
			add_relay_to(GET_NEW_PLANE(plane, offset), BLEND_OVERLAY)

// Hacky shit to ensure parallax works in perf mode
/atom/movable/screen/plane_master/parallax/outside_bounds(mob/relevant)
	if(offset == 0)
		remove_relay_from(GET_NEW_PLANE(RENDER_PLANE_UNLIT_GAME, 0))
		is_outside_bounds = TRUE // I'm sorry :(
		return
	// If we can't render, and we aren't the bottom layer, don't render us
	// This way we only multiply against stuff that's not fullwhite space
	var/atom/movable/screen/plane_master/parent_parallax = home.our_hud.get_plane_master(PLANE_SPACE_PARALLAX)
	var/turf/viewing_turf = get_turf(relevant)
	if(!viewing_turf || offset != GET_LOWEST_STACK_OFFSET(viewing_turf.z))
		parent_parallax.remove_relay_from(plane)
	else
		parent_parallax.add_relay_to(plane, BLEND_OVERLAY)
	return ..()

/atom/movable/screen/plane_master/parallax/inside_bounds(mob/relevant)
	if(offset == 0)
		add_relay_to(GET_NEW_PLANE(RENDER_PLANE_UNLIT_GAME, 0))
		is_outside_bounds = FALSE
		return
	// Always readd, just in case we lost it
	var/atom/movable/screen/plane_master/parent_parallax = home.our_hud.get_plane_master(PLANE_SPACE_PARALLAX)
	parent_parallax.add_relay_to(plane, BLEND_OVERLAY)
	return ..()

// Needs to handle rejoining on a lower z level, so we NEED to readd old planes
/atom/movable/screen/plane_master/parallax/check_outside_bounds()
	// If we're outside bounds AND we're the 0th plane, we need to show cause parallax is hacked to hell
	return offset != 0 && is_outside_bounds

/// Starts the narsie animation midway, so we can catch up to everyone else quickly
/atom/movable/screen/plane_master/parallax/proc/narsie_start_midway(start_time)
	var/time_elapsed = world.time - start_time
	narsie_summoned_effect(max(16 SECONDS - time_elapsed, 0))

/// Starts the narsie animation, make us grey, then red
/atom/movable/screen/plane_master/parallax/proc/narsie_modified(datum/source, new_count)
	SIGNAL_HANDLER
	if(new_count >= 1)
		narsie_summoned_effect(16 SECONDS)
	else
		narsie_unsummoned()

/atom/movable/screen/plane_master/parallax/proc/narsie_summoned_effect(animate_time)
	if(GLOB.narsie_summon_count >= 2)
		var/static/list/nightmare_parallax = list(255,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,1, -130,0,0,0)
		animate(src, color = nightmare_parallax, time = animate_time)
		return

	var/static/list/grey_parallax = list(0.4,0.4,0.4,0, 0.4,0.4,0.4,0, 0.4,0.4,0.4,0, 0,0,0,1, -0.1,-0.1,-0.1,0)
	// We're gonna animate ourselves grey
	// Then, once it's done, about 40 seconds into the event itself, we're gonna start doin some shit. see below
	animate(src, color = grey_parallax, time = animate_time)

/atom/movable/screen/plane_master/parallax/proc/narsie_unsummoned()
	animate(src, color = null, time = 8 SECONDS)

/atom/movable/screen/plane_master/displacement
	name = "置换"
	documentation = "此平面用于在引力异常等现象附近扭曲游戏画面。\
		<br>所需图案绘制到此平面后，会作为游戏平面上扭曲滤镜的渲染目标。\
		<br>请注意其混合模式以及没有中继目标这一点。此平面仅用于扭曲，不会直接绘制到任何地方。"
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	plane = DISPLACEMENT_PLANE
	appearance_flags = PLANE_MASTER|NO_CLIENT_COLOR
	blend_mode = BLEND_ADD
	render_target = DISPLACEMENT_RENDER_TARGET
	render_relay_planes = list()
	// We start out hidden as we do not need to render when there's no distortion on our level
	start_hidden = TRUE

/atom/movable/screen/plane_master/displacement/Initialize(mapload, datum/hud/hud_owner, datum/plane_master_group/home, offset)
	. = ..()
	RegisterSignal(GLOB, SIGNAL_ADDTRAIT(TRAIT_DISTORTION_IN_USE(offset)), PROC_REF(distortion_enabled))
	RegisterSignal(GLOB, SIGNAL_REMOVETRAIT(TRAIT_DISTORTION_IN_USE(offset)), PROC_REF(distortion_disabled))
	if(HAS_TRAIT(GLOB, TRAIT_DISTORTION_IN_USE(offset)))
		distortion_enabled()

/atom/movable/screen/plane_master/displacement/proc/distortion_enabled(datum/source)
	SIGNAL_HANDLER
	var/mob/our_mob = home?.our_hud?.mymob
	unhide_plane(our_mob)

/atom/movable/screen/plane_master/displacement/proc/distortion_disabled(datum/source)
	SIGNAL_HANDLER
	hide_plane()

/// Contains just the floor
/atom/movable/screen/plane_master/floor
	name = "地板"
	documentation = "地板平面。主要用于排序，也能在游戏世界平面周围建立边界，使投影效果正常生效。"
	plane = FLOOR_PLANE
	render_relay_planes = list(RENDER_PLANE_UNLIT_GAME, RENDER_PLANE_LIGHT_MASK)

/atom/movable/screen/plane_master/transparent_floor
	name = "透明地板"
	documentation = "实际上就是开放空间，即没有任何颜色或不透明度的地块。\
		<br>它只绘制到光照遮罩平面；缺少它会导致开放空间上出现黑色空洞。"
	plane = TRANSPARENT_FLOOR_PLANE
	render_relay_planes = list(RENDER_PLANE_LIGHT_MASK)
	// Needs to be critical or it uh, it'll look white
	critical = PLANE_CRITICAL_DISPLAY|PLANE_CRITICAL_NO_RELAY

/atom/movable/screen/plane_master/floor/Initialize(mapload, datum/hud/hud_owner, datum/plane_master_group/home, offset)
	. = ..()
	add_relay_to(GET_NEW_PLANE(RENDER_PLANE_EMISSIVE, offset), relay_layer = EMISSIVE_FLOOR_LAYER, relay_color = GLOB.em_block_color)

/atom/movable/screen/plane_master/wall
	name = "墙壁"
	documentation = "包含所有墙壁，并绘制到游戏世界。单独设置此平面，以便结合太空和地板平面判断哪些位置不属于 BYOND 的黑暗区域。"
	plane = WALL_PLANE
	render_relay_planes = list(RENDER_PLANE_GAME_WORLD, RENDER_PLANE_LIGHT_MASK)

/atom/movable/screen/plane_master/wall/Initialize(mapload, datum/hud/hud_owner, datum/plane_master_group/home, offset)
	. = ..()
	add_relay_to(GET_NEW_PLANE(RENDER_PLANE_EMISSIVE, offset), relay_layer = EMISSIVE_WALL_LAYER, relay_color = GLOB.em_block_color)

/atom/movable/screen/plane_master/game
	name = "游戏"
	documentation = "包含地板和墙壁之外的大多数内容。此平面上的对象需要根据位置相互交错分层。"
	plane = GAME_PLANE
	render_relay_planes = list(RENDER_PLANE_GAME_WORLD)

/atom/movable/screen/plane_master/game_world_above
	name = "游戏上层"
	documentation = "用于按游戏平面的方式绘制、但始终位于其内容之上的对象。"
	plane = ABOVE_GAME_PLANE
	render_relay_planes = list(RENDER_PLANE_GAME_WORLD)

/atom/movable/screen/plane_master/seethrough
	name = "透视"
	documentation = "包含大型对象的透视版本，通过图像覆盖实现。鼠标点击可穿透这些对象。"
	plane = SEETHROUGH_PLANE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	render_relay_planes = list(RENDER_PLANE_GAME_WORLD)
	start_hidden = TRUE

/**
 * Plane master that byond will by default draw to
 * Shouldn't be used, exists to prevent people using plane 0
 * NOTE: If we used SEE_BLACKNESS on a map format that wasn't SIDE_MAP, this is where its darkness would land
 * This would allow us to control it and do fun things. But we can't because side map doesn't support it, so this is just a stub
 */
/atom/movable/screen/plane_master/default
	name = "默认"
	documentation = "BYOND 默认将所有游戏内容绘制到平面 0，即默认平面。 \
		<br>由于我们已将可控制的内容移出平面 0，此处只剩下 BYOND 内部绘制的内容。 \
		<br>原本希望通过赋予生物 SEE_BLACKNESS 视野标志来捕获 BYOND 的黑暗区域。 \
		<br>但 SEE_BLACKNESS 与当前渲染格式不兼容，因此暂时无法实现。"
	plane = DEFAULT_PLANE
	multiz_scaled = FALSE
	start_hidden = TRUE // Doesn't DO anything, exists to hold this place

/atom/movable/screen/plane_master/area
	name = "区域"
	documentation = "包含区域本身，也就是施加于区域的叠加图像和效果。不包括暴雪或辐射风暴，它们位于光照上方。"
	plane = AREA_PLANE

/atom/movable/screen/plane_master/weather
	name = "非粒子天气"
	documentation = "包含天气的主要 32×32 平铺图像，并使用天气效果边缘的墙壁作为遮罩。玩家禁用粒子天气时使用。"
	plane = WEATHER_PLANE
	start_hidden = TRUE
	critical = PLANE_CRITICAL_DISPLAY
	/// Is this a particle variant?
	var/particle_weather = FALSE

/atom/movable/screen/plane_master/weather/set_home(datum/plane_master_group/home)
	. = ..()
	if(!.)
		return
	home.AddComponent(/datum/component/hide_weather_planes, src)
	RegisterSignal(home, COMSIG_GROUP_HUD_CHANGED, PROC_REF(hud_changed))
	update_state(home.our_hud?.mymob)

/atom/movable/screen/plane_master/weather/proc/hud_changed(datum/source, datum/hud/old_hud, datum/hud/new_hud)
	SIGNAL_HANDLER
	update_state(new_hud?.mymob)

/atom/movable/screen/plane_master/weather/proc/update_state(mob/mymob)
	if(!istype(mymob))
		return

	// If the client wants particle weather, only show the PARTICLE_WEATHER_PLANE, otherwise only show the normal WEATHER_PLANE
	if (mymob.canon_client?.prefs?.read_preference(/datum/preference/toggle/particle_weather) == particle_weather)
		set_alpha(255)
	else
		set_alpha(0)

/atom/movable/screen/plane_master/weather/particle
	name = "粒子天气"
	documentation = "包含天气的主要 32×32 平铺图像。玩家启用粒子天气时使用。"
	plane = PARTICLE_WEATHER_PLANE
	particle_weather = TRUE

/atom/movable/screen/plane_master/weather_mask
	name = "天气遮罩"
	documentation = "用于遮罩粒子天气效果，排除不受天气影响的区域。"
	plane = WEATHER_MASK_PLANE
	appearance_flags = PLANE_MASTER | NO_CLIENT_COLOR
	render_target = WEATHER_MASK_RENDER_TARGET
	render_relay_planes = list()
	start_hidden = TRUE
	critical = PLANE_CRITICAL_DISPLAY

/atom/movable/screen/plane_master/weather_mask/set_home(datum/plane_master_group/home)
	. = ..()
	if(!.)
		return
	home.AddComponent(/datum/component/hide_weather_planes, src)

/atom/movable/screen/plane_master/massive_obj
	name = "巨大物体"
	documentation = "巨大物体需要绘制在游戏平面的所有其他内容之上，否则会被裁切，失去巨大的观感。此平面负责实现这一点。"
	plane = MASSIVE_OBJ_PLANE

/atom/movable/screen/plane_master/point
	name = "指示"
	documentation = "指示标记绘制在几乎所有其他内容之上，因此使用独立平面。渲染中继通过分层，使各平面按正确顺序绘制到渲染板。"
	plane = POINT_PLANE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

///Contains all turf lighting
/atom/movable/screen/plane_master/turf_lighting
	name = "地块光照"
	documentation = "包含绘制到地块上的全部光照，直接绘制到光照渲染板。"
	plane = LIGHTING_PLANE
	appearance_flags = PLANE_MASTER|NO_CLIENT_COLOR
	render_relay_planes = list(RENDER_PLANE_TURF_LIGHTING)
	blend_mode_override = BLEND_ADD
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	critical = PLANE_CRITICAL_DISPLAY

/// This will not work through multiz, because of a byond bug with BLEND_MULTIPLY
/// Bug report is up, waiting on a fix
/atom/movable/screen/plane_master/o_light_visual
	name = "叠加光照图像"
	documentation = "包含叠加光照对象，即附着于其他对象上的光照叠加图像。\
		<br>设置此平面是因为光照更新较慢，而移动需要保持流畅；使用叠加图像也更便于调整。"
	plane = O_LIGHTING_VISUAL_PLANE
	appearance_flags = PLANE_MASTER|NO_CLIENT_COLOR
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	blend_mode = BLEND_ADD
	render_relay_planes = list(RENDER_PLANE_O_LIGHTING)
	critical = PLANE_CRITICAL_DISPLAY

/atom/movable/screen/plane_master/above_lighting
	name = "光照上方"
	plane = ABOVE_LIGHTING_PLANE
	documentation = "包含游戏平面中需要绘制在光照平面上方的内容。\
		<br>主要是小型提示和效果，有时也包含需要呈现发光效果的对象。"
	render_relay_planes = list(RENDER_PLANE_GAME)

/atom/movable/screen/plane_master/weather_glow
	name = "天气辉光"
	documentation = "包含天气主要 32×32 平铺图像中的发光部分。"
	plane = WEATHER_GLOW_PLANE
	start_hidden = TRUE
	critical = PLANE_CRITICAL_DISPLAY
	render_relay_planes = list(RENDER_PLANE_GAME)

/atom/movable/screen/plane_master/weather_glow/set_home(datum/plane_master_group/home)
	. = ..()
	if(!.)
		return
	home.AddComponent(/datum/component/hide_weather_planes, src)

/**
 * Handles emissive overlays and emissive blockers.
 */
/atom/movable/screen/plane_master/emissive
	name = "自发光"
	documentation = "包含后续用于遮罩光照平面的内容。自发光遮罩平面会遮挡此层，避免光从墙壁下方透出。\
		<br>它被中继到自发光渲染平面以执行光照遮罩，因为自身和其他自发光内容都需要进行变换。\
		<br>这样可以避免重复缩放。"
	plane = EMISSIVE_PLANE
	appearance_flags = PLANE_MASTER|NO_CLIENT_COLOR
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	render_relay_planes = list()
	critical = PLANE_CRITICAL_DISPLAY

/atom/movable/screen/plane_master/emissive/Initialize(mapload, datum/hud/hud_owner, datum/plane_master_group/home, offset)
	. = ..()
	/// Okay, so what we're doing here is making all emissives convert to white for actual emissive masking (i.e. adding light so objects glow)
	add_relay_to(GET_NEW_PLANE(RENDER_PLANE_EMISSIVE, offset), relay_color = list(1,1,1,0, 1,1,1,0, 0,0,0,0, 0,0,0,1, 0,0,0,0))
	/// But for the bloom plate we convert only the red color into full white, this way we can have emissives in green channel unaffected by bloom
	/// which allows us to selectively bloom only a part of our emissives
	add_relay_to(GET_NEW_PLANE(RENDER_PLANE_EMISSIVE_BLOOM, offset), relay_color = list(255,255,255,0, 0,0,0,0, 0,0,0,0, 0,0,0,1, 0,0,0,0))
	add_relay_to(GET_NEW_PLANE(RENDER_PLANE_EMISSIVE_BLOOM_MASK, offset), relay_color = list(1,1,1,1, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0))
	// Blue channel is dedicated to specular, i.e. our bootleg implementation of shiny objects
	// We map it onto alpha so we can use the mask plate in an alpha mask filter to cut out only the shiny bits
	add_relay_to(GET_NEW_PLANE(RENDER_PLANE_SPECULAR_MASK, offset), relay_color = list(0,0,0,0, 0,0,0,0, 0,0,0,1, 0,0,0,0, 1,1,1,0))

/atom/movable/screen/plane_master/pipecrawl
	name = "管道爬行"
	documentation = "包含在管道爬行时生成的图像。\
		<br>使用若干效果和颜色矩阵，使画面更容易辨认。"
	plane = PIPECRAWL_IMAGES_PLANE
	start_hidden = TRUE
	render_relay_planes = list(RENDER_PLANE_GAME)

/atom/movable/screen/plane_master/pipecrawl/Initialize(mapload, datum/hud/hud_owner)
	. = ..()
	// Makes everything on this plane slightly brighter
	// Has a nice effect, makes thing stand out
	color = list(1.2,0,0,0, 0,1.2,0,0, 0,0,1.2,0, 0,0,0,1, 0,0,0,0)
	// This serves a similar purpose, I want the pipes to pop
	add_filter("pipe_dropshadow", 1, drop_shadow_filter(x = -1, y= -1, size = 1, color = COLOR_HALF_TRANSPARENT_BLACK))
	mirror_parent_hidden()

/atom/movable/screen/plane_master/camera_static
	name = "摄像头雪花"
	documentation = "包含摄像头雪花图像，通常只有能看到雪花画面的观察者才能看见。\
		<br>使用图像而非 vis_contents，以减少地图更新的性能开销。"
	plane = CAMERA_STATIC_PLANE
	render_relay_planes = list(RENDER_PLANE_GAME)

/atom/movable/screen/plane_master/camera_static/set_home(datum/plane_master_group/home)
	. = ..()
	if(home)
		RegisterSignal(home, COMSIG_GROUP_HUD_CHANGED, PROC_REF(hud_changed))
		hud_changed(null, null, home.our_hud)

/atom/movable/screen/plane_master/camera_static/proc/hud_changed(datum/source, datum/hud/old_hud, datum/hud/new_hud)
	SIGNAL_HANDLER
	if(old_hud)
		UnregisterSignal(old_hud, COMSIG_HUD_EYE_CHANGED, PROC_REF(eye_changed))
	if(new_hud)
		RegisterSignal(new_hud, COMSIG_HUD_EYE_CHANGED, PROC_REF(eye_changed))
		eye_changed(new_hud, null, new_hud.mymob?.canon_client?.eye)

/atom/movable/screen/plane_master/camera_static/proc/eye_changed(datum/hud/source, atom/old_eye, atom/new_eye)
	SIGNAL_HANDLER

	if(istype(new_eye, /obj/effect/landmark/ai_multicam_room))
		if(force_hidden)
			unhide_plane(source.mymob)
		return

	if(!iscameramob(new_eye))
		if(!force_hidden)
			hide_plane(source.mymob)
		return

	if(force_hidden)
		unhide_plane(source.mymob)

/atom/movable/screen/plane_master/high_game
	name = "游戏高层"
	documentation = "包含需要显示在游戏平面其他内容之上、且不能被点击的对象。 \
		<br>包括大气调试叠加图像、盲人声音图像和采矿扫描仪效果。 \
		<br>此平面仅用于分层，不用于施加视觉特效。"
	plane = HIGH_GAME_PLANE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	render_relay_planes = list(RENDER_PLANE_GAME)

/atom/movable/screen/plane_master/ghost
	name = "幽灵"
	documentation = "幽灵在此处绘制，避免与游戏世界的画面混在一起。此平面不负责向玩家隐藏幽灵；隐藏由 invisible 和 see_invisible 实现。"
	plane = GHOST_PLANE
	render_relay_planes = list(RENDER_PLANE_NON_GAME)

/atom/movable/screen/plane_master/fullscreen
	name = "全屏"
	documentation = "包含作用于整个屏幕或其上方的内容。 \
		<br>它仍绘制在 HUD 对象下方，用于控制死亡、受伤等效果的绘制顺序。"
	plane = FULLSCREEN_PLANE
	appearance_flags = PLANE_MASTER|NO_CLIENT_COLOR
	render_relay_planes = list(RENDER_PLANE_NON_GAME)
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	offsetting_flags = BLOCKS_PLANE_OFFSETTING|OFFSET_RELAYS_MATCH_HIGHEST

/atom/movable/screen/plane_master/runechat
	name = "头顶聊天"
	documentation = "包含头顶聊天图像，即角色说话时弹出的文字。使用投影改善观感。"
	plane = RUNECHAT_PLANE
	render_relay_planes = list(RENDER_PLANE_NON_GAME)

/atom/movable/screen/plane_master/runechat/show_to(mob/mymob)
	. = ..()
	if(!.)
		return
	remove_filter("AO")
	if(istype(mymob) && mymob.canon_client?.prefs?.read_preference(/datum/preference/toggle/ambient_occlusion))
		// We use outlines instead of drop shadow due to how extremely expensive it is, and there's no reason to use it for runechat
		// which already has high drop shadow transparency at just 32 alpha, so outline does the job good enough
		add_filter("AO", 1, outline_filter(size = 2, color = "#04080F20", flags = OUTLINE_SQUARE))

/atom/movable/screen/plane_master/balloon_chat
	name = "气泡提示"
	documentation = "包含气泡提示图像，即执行某些操作时短暂出现的小文字条，不是头顶聊天文字。"
	plane = BALLOON_CHAT_PLANE
	appearance_flags = PLANE_MASTER|NO_CLIENT_COLOR
	render_relay_planes = list(RENDER_PLANE_NON_GAME)

/atom/movable/screen/plane_master/hud
	name = "HUD"
	documentation = "包含需要绘制到 HUD 上的内容，通常就是屏幕界面元素。"
	plane = HUD_PLANE
	appearance_flags = PLANE_MASTER|NO_CLIENT_COLOR
	render_relay_planes = list(RENDER_PLANE_NON_GAME)
	offsetting_flags = BLOCKS_PLANE_OFFSETTING|OFFSET_RELAYS_MATCH_HIGHEST

/atom/movable/screen/plane_master/above_hud
	name = "HUD 上方"
	documentation = "包含需要绘制在 HUD 其余内容之上的对象，通常是关闭按钮等必须始终可见的元素，以免被可拖动的动作按钮遮挡。"
	plane = ABOVE_HUD_PLANE
	appearance_flags = PLANE_MASTER|NO_CLIENT_COLOR
	render_relay_planes = list(RENDER_PLANE_NON_GAME)
	offsetting_flags = BLOCKS_PLANE_OFFSETTING|OFFSET_RELAYS_MATCH_HIGHEST

/atom/movable/screen/plane_master/splashscreen
	name = "开场画面"
	documentation = "过场动画和开场画面。"
	plane = SPLASHSCREEN_PLANE
	appearance_flags = PLANE_MASTER|NO_CLIENT_COLOR
	render_relay_planes = list(RENDER_PLANE_NON_GAME)
	offsetting_flags = BLOCKS_PLANE_OFFSETTING|OFFSET_RELAYS_MATCH_HIGHEST

/atom/movable/screen/plane_master/escape_menu
	name = "退出菜单"
	documentation = "与退出菜单相关的全部内容。"
	plane = ESCAPE_MENU_PLANE
	appearance_flags = PLANE_MASTER|NO_CLIENT_COLOR
	render_relay_planes = list(RENDER_PLANE_MASTER)
	offsetting_flags = BLOCKS_PLANE_OFFSETTING|OFFSET_RELAYS_MATCH_HIGHEST

/atom/movable/screen/plane_master/escape_menu/show_to(mob/mymob)
	. = ..()
	if(!.)
		return

	var/datum/hud/our_hud = home.our_hud
	if(!our_hud)
		return

	RegisterSignal(our_hud, SIGNAL_ADDTRAIT(TRAIT_ESCAPE_MENU_OPEN), PROC_REF(escape_opened), override = TRUE)
	RegisterSignal(our_hud, SIGNAL_REMOVETRAIT(TRAIT_ESCAPE_MENU_OPEN), PROC_REF(escape_closed), override = TRUE)
	if(!HAS_TRAIT(our_hud, TRAIT_ESCAPE_MENU_OPEN))
		escape_closed()

/atom/movable/screen/plane_master/escape_menu/proc/escape_opened(datum/source)
	SIGNAL_HANDLER
	var/mob/our_mob = home?.our_hud?.mymob
	unhide_plane(our_mob)

/atom/movable/screen/plane_master/escape_menu/proc/escape_closed(datum/source)
	SIGNAL_HANDLER
	var/mob/our_mob = home?.our_hud?.mymob
	hide_plane(our_mob)
