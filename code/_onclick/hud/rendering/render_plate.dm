/*!
 * Custom rendering solution to allow for advanced effects
 * We (ab)use plane masters and render source/target to cheaply render 2+ planes as 1
 * if you want to read more read the _render_readme.md
 */


/**
 * Render relay object assigned to a plane master to be able to relay its render onto other planes that are not its own
 */
/atom/movable/render_plane_relay
	screen_loc = "CENTER"
	layer = -1
	plane = 0
	appearance_flags = PASS_MOUSE | NO_CLIENT_COLOR | KEEP_TOGETHER
	/// If we render into a critical plane master, or not
	var/critical_target = FALSE

/**
 * ## Rendering plate
 *
 * Acts like a plane master, but for plane masters
 * Renders other planes onto this plane, through the use of render objects
 * Any effects applied onto this plane will act on the unified plane
 * IE a bulge filter will apply as if the world was one object
 * remember that once planes are unified on a render plate you cant change the layering of them!
 */
/atom/movable/screen/plane_master/rendering_plate
	name = "默认渲染板"
	multiz_scaled = FALSE

// Blackness renders weird when you view down openspace, because of transforms and borders and such
// This is a consequence of not using lummy's grouped transparency, but I couldn't get that to work without totally fucking up
// Sight flags, and shooting vis_contents usage to the moon. So we're doin it different.
// If image vis contents worked (it should in 515), and we were ok with a maptick cost (wait for threaded maptick) this could be fixed
/atom/movable/screen/plane_master/rendering_plate/transparent
	name = "透明渲染板"
	documentation = "下方偏移层的主渲染板会镜像到此平面，从而实现堆叠效果。\
		<br>此平面将主渲染板提升到当前 Z 层绘制顺序中的正确位置。"
	plane = RENDER_PLANE_TRANSPARENT
	appearance_flags = PLANE_MASTER

/atom/movable/screen/plane_master/rendering_plate/transparent/Initialize(mapload, datum/hud/hud_owner, datum/plane_master_group/home, offset)
	. = ..()
	// Don't display us if we're below everything else yeah?
	AddComponent(/datum/component/plane_hide_highest_offset)
	color = list(0.9,0,0,0, 0,0.9,0,0, 0,0,0.9,0, 0,0,0,1, 0,0,0,0)

///Contains most things in the game world
/atom/movable/screen/plane_master/rendering_plate/game_world
	name = "游戏世界渲染板"
	documentation = "包含世界中的大多数对象，如生物、机器等。投影能营造良好的纵深效果。"
	plane = RENDER_PLANE_GAME_WORLD
	appearance_flags = PLANE_MASTER //should use client color
	blend_mode = BLEND_OVERLAY

/atom/movable/screen/plane_master/rendering_plate/game_world/show_to(mob/mymob)
	. = ..()
	if(!.)
		return
	remove_filter("AO")
	if(istype(mymob) && mymob.canon_client?.prefs?.read_preference(/datum/preference/toggle/ambient_occlusion))
		add_filter("AO", 1, drop_shadow_filter(x = 0, y = -2, size = 4, color = "#04080FAA"))

/atom/movable/screen/plane_master/rendering_plate/unlit_game_plate
	name = "未照明游戏渲染板"
	documentation = "将游戏渲染板中需要受到光照影响的部分送入 RENDER_PLANE_GAME 和自发光泛光处理流程。"
	plane = RENDER_PLANE_UNLIT_GAME
	render_relay_planes = list(RENDER_PLANE_GAME)

/atom/movable/screen/plane_master/rendering_plate/unlit_game_plate/Initialize(mapload, datum/hud/hud_owner)
	. = ..()
	add_relay_to(GET_NEW_PLANE(RENDER_PLANE_EMISSIVE_BLOOM, offset), blend_override = BLEND_MULTIPLY)

/atom/movable/screen/plane_master/rendering_plate/particle_weather
	name = "粒子天气承载板"
	documentation = "用于绘制粒子天气的平面，受 WEATHER_MASK_PLANE 遮罩。 \
		它必须是平面主控对象才能正确接受天气遮罩，不能使用单个普通屏幕对象。"
	plane = RENDER_PLANE_PARTICLE_WEATHER
	start_hidden = TRUE
	critical = PLANE_CRITICAL_DISPLAY

/atom/movable/screen/plane_master/rendering_plate/particle_weather/Initialize(mapload, datum/hud/hud_owner, datum/plane_master_group/home, offset)
	. = ..()
	// We can actually do this just fine as we do not render anything onto ourselves but our particles
	add_filter("weather_mask", 1, alpha_mask_filter(render_source = OFFSET_RENDER_TARGET(WEATHER_MASK_RENDER_TARGET, offset)))

/atom/movable/screen/plane_master/rendering_plate/particle_weather/set_home(datum/plane_master_group/home)
	. = ..()
	if(!.)
		return
	home.AddComponent(/datum/component/hide_weather_planes, src)
	AddComponent(/datum/component/connect_perspective, home, list(COMSIG_MOVABLE_Z_CHANGED = PROC_REF(z_changed)))
	RegisterSignal(home, COMSIG_PLANE_GROUP_HUD_CHANGED, PROC_REF(hud_changed))
	RegisterSignal(home, COMSIG_PLANE_GROUP_PERSPECTIVE_CHANGED, PROC_REF(perspective_changed))
	update_state()

/atom/movable/screen/plane_master/rendering_plate/particle_weather/proc/z_changed(datum/source)
	SIGNAL_HANDLER
	update_state()

/atom/movable/screen/plane_master/rendering_plate/particle_weather/proc/hud_changed(datum/source)
	SIGNAL_HANDLER
	update_state()

/atom/movable/screen/plane_master/rendering_plate/particle_weather/proc/perspective_changed(datum/source)
	SIGNAL_HANDLER
	update_state()

/// Updates ourselves based on our mob's preferences state
/atom/movable/screen/plane_master/rendering_plate/particle_weather/proc/update_state()
	vis_contents.Cut()

	var/mob/mymob = home?.our_hud?.mymob
	if(!istype(mymob) || !mymob.canon_client?.prefs?.read_preference(/datum/preference/toggle/particle_weather))
		return
	// Lobby HUDs, we don't care about weather during init anyways
	if(!SSmapping.initialized)
		return

	var/list/stack_levels = SSmapping.get_connected_levels(get_turf(home.get_perspective()))
	var/max_z = max(stack_levels)
	var/our_z = max_z - offset
	if(!(our_z in stack_levels))
		return

	vis_contents += SSweather.z_particles[our_z][plane]

/atom/movable/screen/plane_master/rendering_plate/particle_weather/emissive
	name = "自发光粒子天气承载板"
	documentation = "用于天气自发光部分的辅助粒子天气平面，经过遮罩后还会绘制到自发光平面。"
	plane = RENDER_PLANE_EMISSIVE_PARTICLE_WEATHER

/atom/movable/screen/plane_master/rendering_plate/particle_weather/emissive/Initialize(mapload, datum/hud/hud_owner, datum/plane_master_group/home, offset)
	. = ..()
	// Render a copy of ourselves onto the emissive plane encoded into the bloom channel
	add_relay_to(GET_NEW_PLANE(EMISSIVE_PLANE, offset), relay_color = GLOB.emissive_color)

/atom/movable/screen/plane_master/rendering_plate/turf_lighting
	name = "地块光照后处理板"
	documentation = "供叠加光照及其他可能使用的渲染板遮罩地块光照。"
	plane = RENDER_PLANE_TURF_LIGHTING
	render_relay_planes = list(RENDER_PLANE_LIGHTING)
	blend_mode = BLEND_ADD
	critical = PLANE_CRITICAL_DISPLAY

/atom/movable/screen/plane_master/rendering_plate/turf_lighting/Initialize(mapload, datum/hud/hud_owner, datum/plane_master_group/home, offset)
	. = ..()
	/// We get affected by cutoff but not by the contrast that overlay lights get
	/// So flashlights seem to reflect "better"
	add_relay_to(GET_NEW_PLANE(RENDER_PLANE_SPECULAR, offset), relay_color = list(
		1, 0, 0, 0,
		0, 1, 0, 0,
		0, 0, 1, 0,
		0, 0, 0, 1,
		-SPECULAR_EMISSIVE_CUTOFF, -SPECULAR_EMISSIVE_CUTOFF, -SPECULAR_EMISSIVE_CUTOFF, 0,
	))

/atom/movable/screen/plane_master/rendering_plate/emissive_slate
	name = "自发光渲染板"
	documentation = "此系统利用 BYOND 的颜色矩阵滤镜，通过分层处理自发光遮挡物。\
		<br>自发光叠加图像使用对象颜色统一转换为某种特定颜色。\
		<br>自发光遮挡物则统一转换为另一种颜色。\
		<br>自发光叠加图像和遮挡物都放在此平面上。\
		<br>它们按照图层顺序相互遮挡，方式与普通 BYOND 对象相同。\
		<br>随后对自发光平面应用颜色矩阵滤镜，遮去所有非自发光颜色的部分。\
		<br>最终结果用作光照平面的透明度遮罩。"
	plane = RENDER_PLANE_EMISSIVE
	appearance_flags = PLANE_MASTER|NO_CLIENT_COLOR
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	render_target = EMISSIVE_RENDER_TARGET
	render_relay_planes = list()
	critical = PLANE_CRITICAL_DISPLAY

/atom/movable/screen/plane_master/rendering_plate/emissive_slate/Initialize(mapload, datum/hud/hud_owner, datum/plane_master_group/home, offset)
	. = ..()
	add_filter("em_block_masking", 2, color_matrix_filter(GLOB.em_mask_matrix))
	if(offset != 0)
		add_relay_to(GET_NEW_PLANE(RENDER_PLANE_EMISSIVE, offset - 1), relay_layer = EMISSIVE_Z_BELOW_LAYER)

/atom/movable/screen/plane_master/rendering_plate/emissive_bloom_mask
	name = "自发光泛光遮罩板"
	documentation = "此承载板仅用于对自发光内容进行纯白泛光处理，然后将其作为自发光泛光板的遮罩。"
	plane = RENDER_PLANE_EMISSIVE_BLOOM_MASK
	appearance_flags = PLANE_MASTER|NO_CLIENT_COLOR
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	render_relay_planes = list()
	render_target = EMISSIVE_BLOOM_MASK_RENDER_TARGET
	critical = PLANE_CRITICAL_DISPLAY

/atom/movable/screen/plane_master/rendering_plate/emissive_bloom
	name = "自发光泛光板"
	documentation = "此板先对自发光内容施加泛光，再将其加入叠加光照平面。实现方式是将游戏渲染板与全亮自发光内容进行正片叠底混合，\
		再以自发光颜色进行透明度遮罩，从而处理独立存在或被自发光内容覆盖的遮挡物。"
	plane = RENDER_PLANE_EMISSIVE_BLOOM
	appearance_flags = PLANE_MASTER|NO_CLIENT_COLOR
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	blend_mode = BLEND_ADD
	render_relay_planes = list(RENDER_PLANE_O_LIGHTING)
	critical = PLANE_CRITICAL_DISPLAY

/atom/movable/screen/plane_master/rendering_plate/emissive_bloom/Initialize(mapload, datum/hud/hud_owner, datum/plane_master_group/home, offset)
	. = ..()
	add_filter("emissive_mask", 1, alpha_mask_filter(render_source = OFFSET_RENDER_TARGET(EMISSIVE_BLOOM_MASK_RENDER_TARGET, offset)))
	var/bloom_scale = hud_owner?.mymob?.client?.prefs?.read_preference(/datum/preference/numeric/emissive_bloom)
	if (isnull(bloom_scale))
		bloom_scale = DEFAULT_EMISSIVE_BLOOM_SIZE
	// 0 disables the bloom
	if (bloom_scale)
		add_filter("emissive_bloom", 2, bloom_filter(threshold = COLOR_BLACK, size = bloom_scale, offset = ceil(bloom_scale / 2)))

/atom/movable/screen/plane_master/rendering_plate/specular_mask
	name = "镜面反射遮罩板"
	documentation = "用于为镜面反射板效果生成镜面反射遮罩。"
	plane = RENDER_PLANE_SPECULAR_MASK
	appearance_flags = PLANE_MASTER|NO_CLIENT_COLOR
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	render_target = SPECULAR_MASK_RENDER_TARGET
	render_relay_planes = list()
	critical = PLANE_CRITICAL_DISPLAY

/atom/movable/screen/plane_master/rendering_plate/overlay_light
	name = "叠加光照板"
	documentation = "将叠加光照与自发光内容合并。\
		<br>绘制到通用光照板，并处理地块光照以留出所需空间，同时处理镜面反射。"
	plane = RENDER_PLANE_O_LIGHTING
	appearance_flags = PLANE_MASTER|NO_CLIENT_COLOR
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	blend_mode = BLEND_ADD
	render_relay_planes = list(RENDER_PLANE_LIGHTING)
	critical = PLANE_CRITICAL_DISPLAY

/atom/movable/screen/plane_master/rendering_plate/overlay_light/Initialize(mapload, datum/hud/hud_owner, datum/plane_master_group/home, offset)
	. = ..()
	// I'd love for this to be HSL but filters don't work with blend modes
	add_relay_to(GET_NEW_PLANE(RENDER_PLANE_TURF_LIGHTING, offset), BLEND_MULTIPLY, relay_color = list(
		-1, -1, -1, 0,
		-1, -1, -1, 0,
		-1, -1, -1, 0,
		0, 0, 0, OVERLAY_LIGHTING_WEIGHT,
		1, 1, 1, 0,
	))
	add_relay_to(GET_NEW_PLANE(RENDER_PLANE_SPECULAR, offset), relay_color = list(
		SPECULAR_EMISSIVE_OVERLAY_CONTRAST, 0, 0, 0,
		0, SPECULAR_EMISSIVE_OVERLAY_CONTRAST, 0, 0,
		0, 0, SPECULAR_EMISSIVE_OVERLAY_CONTRAST, 0,
		0, 0, 0, 1,
		-SPECULAR_EMISSIVE_CUTOFF, -SPECULAR_EMISSIVE_CUTOFF, -SPECULAR_EMISSIVE_CUTOFF, 0,
	))

/atom/movable/screen/plane_master/rendering_plate/specular
	name = "镜面反射板"
	documentation = "人为提高特定像素的亮度，粗略模拟光亮表面。"
	plane = RENDER_PLANE_SPECULAR
	appearance_flags = PLANE_MASTER|NO_CLIENT_COLOR
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	blend_mode = BLEND_ADD
	render_relay_planes = list(RENDER_PLANE_GAME)
	critical = PLANE_CRITICAL_DISPLAY

/atom/movable/screen/plane_master/rendering_plate/specular/Initialize(mapload, datum/hud/hud_owner, datum/plane_master_group/home, offset)
	. = ..()
	add_filter("specular_mask", 1, alpha_mask_filter(render_source = OFFSET_RENDER_TARGET(SPECULAR_MASK_RENDER_TARGET, offset)))

///Contains all lighting objects
/atom/movable/screen/plane_master/rendering_plate/lighting
	name = "光照板"
	documentation = "此平面的所有内容会与绘制目标平面（通常为游戏平面）进行<b>正片叠底</b>混合。\
		<br>这是光照的基本原理。由于使用 BLEND_MULTIPLY，有时还会使用颜色矩阵，因此需要黑色背景。\
		<br>参见<a href=\"https://secure.byond.com/forum/?post=2141928\">这篇 BYOND 论坛帖子</a>。\
		<br>自发光平面会对此平面进行遮罩，使对象能在黑暗中发光。\
		<br>叠加光照平面也会对此平面进行遮罩。它包含游戏中的所有叠加光源，同时绘制到此平面和游戏平面。\
		<br>遮罩会为叠加光照效果留出作用空间。\
		<br>此外，经常通过调整此平面的透明度来实现夜视等效果。"
	plane = RENDER_PLANE_LIGHTING
	blend_mode_override = BLEND_MULTIPLY
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	critical = PLANE_CRITICAL_DISPLAY
	render_relay_planes = list(RENDER_PLANE_GAME)
	/// A list of light cutoffs we're actively using, (mass, r, g, b) to avoid filter churn
	var/list/light_cutoffs

/*!
 * This system works by exploiting BYONDs color matrix filter to use layers to handle emissive blockers.
 *
 * Emissive overlays are pasted with an atom color that converts them to be entirely some specific color.
 * Emissive blockers are pasted with an atom color that converts them to be entirely some different color.
 * Emissive overlays and emissive blockers are put onto the same plane.
 * The layers for the emissive overlays and emissive blockers cause them to mask eachother similar to normal BYOND objects.
 * A color matrix filter is applied to the emissive plane to mask out anything that isn't whatever the emissive color is.
 * This is then used to alpha mask the lighting plane.
 */
/atom/movable/screen/plane_master/rendering_plate/lighting/Initialize(mapload, datum/hud/hud_owner)
	. = ..()
	add_filter("emissives", 1, alpha_mask_filter(render_source = OFFSET_RENDER_TARGET(EMISSIVE_RENDER_TARGET, offset), flags = MASK_INVERSE))
	set_light_cutoff(10)

/atom/movable/screen/plane_master/rendering_plate/lighting/set_home(datum/plane_master_group/home)
	. = ..()
	if(home)
		RegisterSignal(home, COMSIG_PLANE_GROUP_OFFSET_CHANGED, PROC_REF(on_offset_change))
		offset_change(home.active_offset || 0)

/atom/movable/screen/plane_master/rendering_plate/lighting/show_to(mob/mymob)
	. = ..()
	if(!.)
		return
	// This applies a backdrop to our lighting plane
	// Why do plane masters need a backdrop sometimes? Read https://secure.byond.com/forum/?post=2141928
	// Basically, we need something to brighten
	// unlit is perhaps less needed rn, it exists to provide a fullbright for things that can't see the lighting plane
	// but we don't actually use invisibility to hide the lighting plane anymore, so it's pointless
	var/atom/movable/screen/backdrop = mymob.overlay_fullscreen("lighting_backdrop_lit_[home.key]#[offset]", /atom/movable/screen/fullscreen/lighting_backdrop/lit)
	// Need to make sure they're on our plane, ALL the time. We always need a backdrop
	SET_PLANE_EXPLICIT(backdrop, PLANE_TO_TRUE(backdrop.plane), src)
	backdrop = mymob.overlay_fullscreen("lighting_backdrop_unlit_[home.key]#[offset]", /atom/movable/screen/fullscreen/lighting_backdrop/unlit)
	SET_PLANE_EXPLICIT(backdrop, PLANE_TO_TRUE(backdrop.plane), src)

	set_light_cutoff(mymob.lighting_cutoff, mymob.lighting_color_cutoffs)

/atom/movable/screen/plane_master/rendering_plate/lighting/hide_from(mob/oldmob)
	. = ..()
	oldmob.clear_fullscreen("lighting_backdrop_lit_[home.key]#[offset]")
	oldmob.clear_fullscreen("lighting_backdrop_unlit_[home.key]#[offset]")

/atom/movable/screen/plane_master/rendering_plate/lighting/proc/on_offset_change(datum/source, old_offset, new_offset)
	SIGNAL_HANDLER
	offset_change(new_offset)

/atom/movable/screen/plane_master/rendering_plate/lighting/proc/offset_change(mob_offset)
	// Offsets stack down remember. This implies that we're above the mob's view plane, and shouldn't render
	if(offset < mob_offset)
		disable_alpha()
	else
		enable_alpha()

/atom/movable/screen/plane_master/rendering_plate/lighting/proc/set_light_cutoff(light_cutoff, list/color_cutoffs)
	var/list/new_cutoffs = list(light_cutoff)
	new_cutoffs += color_cutoffs
	if(new_cutoffs ~= light_cutoffs)
		return

	remove_filter(list("light_cutdown", "light_cutup"))

	var/ratio = light_cutoff/100
	if(!color_cutoffs)
		color_cutoffs = list(0, 0, 0)

	var/red = color_cutoffs[1] / 100
	var/green = color_cutoffs[2] / 100
	var/blue = color_cutoffs[3] / 100
	add_filter("light_cutdown", 3, color_matrix_filter(list(1,0,0,0, 0,1,0,0, 0,0,1,0, 0,0,0,1, -(ratio + red),-(ratio+green),-(ratio+blue),0)))
	add_filter("light_cutup", 4, color_matrix_filter(list(1,0,0,0, 0,1,0,0, 0,0,1,0, 0,0,0,1, ratio+red,ratio+green,ratio+blue,0)))

/atom/movable/screen/plane_master/rendering_plate/light_mask
	name = "光照遮罩"
	documentation = "此平面的透明部分会让其下方游戏渲染板的对应位置变黑。\
		<br>这样可以防止自发光和叠加光照穿过光照平面底部通常存在的黑暗，照亮后面的对象。\
		<br>太空、地板和墙壁平面的副本被中继到此处作为遮罩，再将现有不透明度提高到 100%。\
		<br>如果视野设置只显示生物而不显示地板等内容，则仅遮罩叠加光照和自发光。\
		<br>这样能避免错误透视，同时保留热成像等功能。"
	plane = RENDER_PLANE_LIGHT_MASK
	appearance_flags = PLANE_MASTER|NO_CLIENT_COLOR
	// Fullwhite where there's anything, no color otherwise
	color = list(255,255,255,255, 255,255,255,255, 255,255,255,255, 255,255,255,255, 0,0,0,0)
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	render_target = LIGHT_MASK_RENDER_TARGET
	// We blend against the game plane, so she's gotta multiply!
	blend_mode = BLEND_MULTIPLY
	render_relay_planes = list(RENDER_PLANE_GAME)

/atom/movable/screen/plane_master/rendering_plate/light_mask/show_to(mob/mymob)
	. = ..()
	if(!.)
		return

	RegisterSignal(mymob, COMSIG_MOB_SIGHT_CHANGE, PROC_REF(handle_sight), override = TRUE)
	handle_sight(mymob, mymob.sight, NONE)

/atom/movable/screen/plane_master/rendering_plate/light_mask/hide_from(mob/oldmob)
	. = ..()
	var/atom/movable/screen/plane_master/emissive = home.get_plane(GET_NEW_PLANE(RENDER_PLANE_EMISSIVE, offset))
	emissive.remove_filter("lighting_mask")
	remove_relay_from(GET_NEW_PLANE(RENDER_PLANE_GAME, offset))
	UnregisterSignal(oldmob, COMSIG_MOB_SIGHT_CHANGE)

/atom/movable/screen/plane_master/rendering_plate/light_mask/proc/handle_sight(datum/source, new_sight, old_sight)
	// If we can see something that shows "through" blackness, and we can't see turfs, disable our draw to the game plane
	// And instead mask JUST the overlay lighting plane, since that will look fuckin wrong
	var/atom/movable/screen/plane_master/emissive = home.get_plane(GET_NEW_PLANE(RENDER_PLANE_EMISSIVE, offset))
	if(new_sight & SEE_AVOID_TURF_BLACKNESS && !(new_sight & SEE_TURFS))
		remove_relay_from(GET_NEW_PLANE(RENDER_PLANE_GAME, offset))
		emissive.add_filter("lighting_mask", 1, alpha_mask_filter(render_source = OFFSET_RENDER_TARGET(LIGHT_MASK_RENDER_TARGET, offset)))
	// If we CAN'T see through the black, then draw er down brother!
	else
		emissive.remove_filter("lighting_mask")
		// We max alpha here, so our darkness is actually.. dark
		// Can't do it before cause it fucks with the filter
		add_relay_to(GET_NEW_PLANE(RENDER_PLANE_GAME, offset), relay_color = list(1,0,0,0, 0,1,0,0, 0,0,1,0, 0,0,0,1, 0,0,0,1))

///renders in character game objects
/atom/movable/screen/plane_master/rendering_plate/game_plate
	name = "游戏渲染板"
	documentation = "包含角色所处游戏世界中的所有对象。\
		<br>还会应用引力脉冲平面的置换效果，以扭曲游戏世界。\
		<br>启用视野限制时，会将其中继到两个不同的渲染板，只对部分画面施加视野效果；否则直接绘制到主渲染板。\
		<br>光照也在这一阶段最终合入渲染流程。"
	plane = RENDER_PLANE_GAME
	render_relay_planes = list(RENDER_PLANE_MASTER)
	critical = PLANE_CRITICAL_DISPLAY

/atom/movable/screen/plane_master/rendering_plate/game_plate/Initialize(mapload, datum/hud/hud_owner, datum/plane_master_group/home, offset)
	. = ..()
	RegisterSignal(GLOB, SIGNAL_ADDTRAIT(TRAIT_DISTORTION_IN_USE(offset)), PROC_REF(distortion_enabled))
	RegisterSignal(GLOB, SIGNAL_REMOVETRAIT(TRAIT_DISTORTION_IN_USE(offset)), PROC_REF(distortion_disabled))
	if(HAS_TRAIT(GLOB, TRAIT_DISTORTION_IN_USE(offset)))
		distortion_enabled()

/atom/movable/screen/plane_master/rendering_plate/game_plate/proc/distortion_enabled(datum/source)
	SIGNAL_HANDLER
	add_filter("displacer", 1, displacement_map_filter(render_source = OFFSET_RENDER_TARGET(DISPLACEMENT_RENDER_TARGET, offset), size = 10))

/atom/movable/screen/plane_master/rendering_plate/game_plate/proc/distortion_disabled(datum/source)
	SIGNAL_HANDLER
	remove_filter("displacer")

/atom/movable/screen/plane_master/rendering_plate/game_plate/show_to(mob/mymob)
	. = ..()
	if(!. || !mymob)
		return .
	RegisterSignal(mymob, SIGNAL_ADDTRAIT(TRAIT_FOV_APPLIED), PROC_REF(fov_enabled), override = TRUE)
	RegisterSignal(mymob, SIGNAL_REMOVETRAIT(TRAIT_FOV_APPLIED), PROC_REF(fov_disabled), override = TRUE)
	if(HAS_TRAIT(mymob, TRAIT_FOV_APPLIED))
		fov_enabled(mymob)
	else
		fov_disabled(mymob)

/atom/movable/screen/plane_master/rendering_plate/game_plate/proc/fov_enabled(mob/source)
	SIGNAL_HANDLER
	add_relay_to(GET_NEW_PLANE(RENDER_PLANE_GAME_UNMASKED, offset))
	add_relay_to(GET_NEW_PLANE(RENDER_PLANE_GAME_MASKED, offset))
	remove_relay_from(GET_NEW_PLANE(RENDER_PLANE_MASTER, offset))

/atom/movable/screen/plane_master/rendering_plate/game_plate/proc/fov_disabled(mob/source)
	SIGNAL_HANDLER
	remove_relay_from(GET_NEW_PLANE(RENDER_PLANE_GAME_UNMASKED, offset))
	remove_relay_from(GET_NEW_PLANE(RENDER_PLANE_GAME_MASKED, offset))
	add_relay_to(GET_NEW_PLANE(RENDER_PLANE_MASTER, offset))

///renders the parts of the plate unmasked by fov
/atom/movable/screen/plane_master/rendering_plate/unmasked_game_plate
	name = "无遮罩游戏渲染板"
	documentation = "包含游戏渲染板中不受视野限制影响的部分。\
		<br>使用透明度遮罩剔除将在其他位置处理的部分。"
	plane = RENDER_PLANE_GAME_UNMASKED
	render_relay_planes = list(RENDER_PLANE_MASTER)

/atom/movable/screen/plane_master/rendering_plate/unmasked_game_plate/Initialize(mapload, datum/hud/hud_owner, datum/plane_master_group/home, offset)
	. = ..()
	add_filter("fov_handled", 1, alpha_mask_filter(render_source = OFFSET_RENDER_TARGET(FIELD_OF_VISION_BLOCKER_RENDER_TARGET, offset), flags = MASK_INVERSE))

/atom/movable/screen/plane_master/rendering_plate/unmasked_game_plate/show_to(mob/mymob)
	. = ..()
	if(!. || !mymob)
		return .
	RegisterSignal(mymob, SIGNAL_ADDTRAIT(TRAIT_FOV_APPLIED), PROC_REF(fov_enabled), override = TRUE)
	RegisterSignal(mymob, SIGNAL_REMOVETRAIT(TRAIT_FOV_APPLIED), PROC_REF(fov_disabled), override = TRUE)
	if(HAS_TRAIT(mymob, TRAIT_FOV_APPLIED))
		fov_enabled(mymob)
	else
		fov_disabled(mymob)

/atom/movable/screen/plane_master/rendering_plate/unmasked_game_plate/proc/fov_enabled(mob/source)
	SIGNAL_HANDLER
	if(force_hidden == FALSE)
		return
	unhide_plane(source)

/atom/movable/screen/plane_master/rendering_plate/unmasked_game_plate/proc/fov_disabled(mob/source)
	SIGNAL_HANDLER
	hide_plane(source)

///renders the parts of the plate masked by fov
/atom/movable/screen/plane_master/rendering_plate/masked_game_plate
	name = "视野限制游戏渲染板"
	documentation = "包含游戏渲染板中被某种视野限制遮挡的部分。\
		<br>应用颜色矩阵压暗画面、增加对比，并施加模糊，使这些内容只能被隐约看见。"
	plane = RENDER_PLANE_GAME_MASKED
	render_relay_planes = list(RENDER_PLANE_MASTER)

/atom/movable/screen/plane_master/rendering_plate/masked_game_plate/Initialize(mapload, datum/hud/hud_owner, datum/plane_master_group/home, offset)
	. = ..()
	add_filter("fov_blur", 1, gauss_blur_filter(1.8))
	add_filter("fov_handled_space", 2, alpha_mask_filter(render_source = OFFSET_RENDER_TARGET(FIELD_OF_VISION_BLOCKER_RENDER_TARGET, offset)))
	add_filter("fov_matrix", 3, color_matrix_filter(list(0.5,-0.15,-0.15,0, -0.15,0.5,-0.15,0, -0.15,-0.15,0.5,0, 0,0,0,1, 0,0,0,0)))

/atom/movable/screen/plane_master/rendering_plate/masked_game_plate/show_to(mob/mymob)
	. = ..()
	if(!. || !mymob)
		return .
	RegisterSignal(mymob, SIGNAL_ADDTRAIT(TRAIT_FOV_APPLIED), PROC_REF(fov_enabled), override = TRUE)
	RegisterSignal(mymob, SIGNAL_REMOVETRAIT(TRAIT_FOV_APPLIED), PROC_REF(fov_disabled), override = TRUE)
	if(HAS_TRAIT(mymob, TRAIT_FOV_APPLIED))
		fov_enabled(mymob)
	else
		fov_disabled(mymob)

/atom/movable/screen/plane_master/rendering_plate/masked_game_plate/proc/fov_enabled(mob/source)
	SIGNAL_HANDLER
	if(force_hidden == FALSE)
		return
	unhide_plane(source)

/atom/movable/screen/plane_master/rendering_plate/masked_game_plate/proc/fov_disabled(mob/source)
	SIGNAL_HANDLER
	hide_plane(source)

///render plate for OOC stuff like ghosts, hud-screen effects, etc
/atom/movable/screen/plane_master/rendering_plate/non_game
	name = "非游戏渲染板"
	documentation = "绘制角色所处世界之外的内容，与游戏渲染板相对应。"
	plane = RENDER_PLANE_NON_GAME
	render_relay_planes = list(RENDER_PLANE_MASTER)

///this plate renders the final screen to show to the player
/atom/movable/screen/plane_master/rendering_plate/master
	name = "主渲染板"
	documentation = "所有平面主控对象的最终输出位置，可视为最终绘制的画面。\
		<br>偏移量非 0 时，它会绘制到上一层的透明平面；否则不绘制到其他位置，或直接显示给玩家。"
	plane = RENDER_PLANE_MASTER
	render_relay_planes = list()

/atom/movable/screen/plane_master/rendering_plate/master/set_home(datum/plane_master_group/home)
	. = ..()
	// Non 0 offset render plates will relay up to the transparent plane above them, assuming they're not on the same z level as their target of course
	if(offset == 0)
		return
	if(home)
		RegisterSignal(home, COMSIG_PLANE_GROUP_OFFSET_CHANGED, PROC_REF(on_offset_change))
		offset_change(home.active_offset || 0)

/atom/movable/screen/plane_master/rendering_plate/master/proc/on_offset_change(datum/source, old_offset, new_offset)
	SIGNAL_HANDLER
	offset_change(new_offset)

/atom/movable/screen/plane_master/rendering_plate/master/proc/offset_change(new_offset)
	if(new_offset == offset) // If we're on our own z layer, relay to nothing, just draw
		remove_relay_from(GET_NEW_PLANE(RENDER_PLANE_TRANSPARENT, offset - 1))
	else // Otherwise, regenerate the relay
		add_relay_to(GET_NEW_PLANE(RENDER_PLANE_TRANSPARENT, offset - 1))

/**
 * Plane master proc called in Initialize() that creates relay objects, and sets them up as needed
 * Sets:
 * * layer from plane to avoid z-fighting
 * * planes to relay the render to
 * * render_source so that the plane will render on these objects
 * * mouse opacity to ensure proper mouse hit tracking
 * * name for debugging purposes
 * Other vars such as alpha will automatically be applied with the render source
 */
/atom/movable/screen/plane_master/proc/generate_render_relays()
	var/relay_loc = home?.relay_loc || "1,1"
	// If we're using a submap (say for a popup window) make sure we draw onto it
	if(home?.map)
		relay_loc = "[home.map]:[relay_loc]"

	var/list/generated_planes = list()
	for(var/atom/movable/render_plane_relay/relay as anything in relays)
		generated_planes += relay.plane

	for(var/relay_plane in (render_relay_planes - generated_planes))
		generate_relay_to(relay_plane, relay_loc)

	if(blend_mode != BLEND_MULTIPLY)
		blend_mode = BLEND_DEFAULT
	relays_generated = TRUE

/// Creates a connection between this plane master and the passed in plane
/// Helper for out of system code, shouldn't be used in this file
/// Build system to differenchiate between generated and non generated render relays
/atom/movable/screen/plane_master/proc/add_relay_to(target_plane, blend_override, relay_layer, relay_color)
	if(get_relay_to(target_plane))
		return
	if(!offset_already_updated)
		CRASH("Attempted to draw a render relay before our offset has been applied, this WILL break")
	render_relay_planes += target_plane
	var/client/display_lad = home?.our_hud?.mymob?.canon_client
	var/atom/movable/render_plane_relay/relay = generate_relay_to(target_plane, show_to = display_lad, blend_override = blend_override, relay_layer = relay_layer)
	relay.color = relay_color

/proc/get_plane_master_render_base(name)
	return "*[name]: AUTOGENERATED RENDER TGT"

/atom/movable/screen/plane_master/proc/generate_relay_to(target_plane, relay_loc, client/show_to, blend_override, relay_layer)
	if(!length(relays) && !initial(render_target))
		render_target = OFFSET_RENDER_TARGET(get_plane_master_render_base(name), offset)
	if(!relay_loc)
		relay_loc = "1,1"
		// If we're using a submap (say for a popup window) make sure we draw onto it
		if(home?.map)
			relay_loc = "[home.map]:[relay_loc]"
	var/blend_to_use = blend_override
	if(isnull(blend_to_use))
		blend_to_use = blend_mode_override || initial(blend_mode)

	var/atom/movable/render_plane_relay/relay = new()
	relay.render_source = render_target
	relay.plane = target_plane
	relay.screen_loc = relay_loc
	// There are two rules here
	// 1: layer needs to be positive (negative layers are treated as float layers)
	// 2: lower planes (including offset ones) need to be layered below higher ones (because otherwise they'll render fucky)
	// By multiplying LOWEST_EVER_PLANE by 30, we give 30 offsets worth of room to planes before they start going negative
	// Bet
	// We allow for manuel override if requested. careful with this
	relay.layer = relay_layer || (plane + abs(LOWEST_EVER_PLANE * 30)) //layer must be positive but can be a decimal
	relay.blend_mode = blend_to_use
	relay.mouse_opacity = mouse_opacity
	relay.name = render_target
	relay.critical_target = PLANE_IS_CRITICAL(target_plane)
	relays += relay
	// Relays are sometimes generated early, before huds have a mob to display stuff to
	// That's what this is for
	if(show_to)
		show_to.screen += relay
	if(offsetting_flags & OFFSET_RELAYS_MATCH_HIGHEST && home.our_hud)
		offset_relay(relay, home.active_offset)
	return relay

/// Breaks a connection between this plane master, and the passed in place
/atom/movable/screen/plane_master/proc/remove_relay_from(target_plane)
	render_relay_planes -= target_plane
	var/atom/movable/render_plane_relay/existing_relay = get_relay_to(target_plane)
	if(!existing_relay)
		return
	relays -= existing_relay
	if(!length(relays) && !initial(render_target))
		render_target = null
	var/client/lad = home?.our_hud?.mymob?.canon_client
	if(lad)
		lad.screen -= existing_relay

/// Gets the relay atom we're using to connect to the target plane, if one exists
/atom/movable/screen/plane_master/proc/get_relay_to(target_plane)
	for(var/atom/movable/render_plane_relay/relay in relays)
		if(relay.plane == target_plane)
			return relay

	return null

/**
 * Offsets our relays in place using the given parameter by adjusting their plane and
 * layer values, avoiding changing the layer for relays with custom-set layers.
 *
 * Used in [proc/build_planes_offset] to make the relays for non-offsetting planes
 * match the highest rendering plane that matches the target, to avoid them rendering
 * on the highest level above things that should be visible.
 *
 * Parameters:
 * - new_offset: the offset we will adjust our relays to
 */
/atom/movable/screen/plane_master/proc/offset_relays_in_place(new_offset)
	for(var/atom/movable/render_plane_relay/rpr in relays)
		offset_relay(rpr, new_offset)

/**
 * Offsets a given render relay using the given parameter by adjusting its plane and
 * layer values, avoiding changing the layer if it has a custom-set layer.
 *
 * Parameters:
 * - rpr: the render plane relay we will offset
 * - new_offset: the offset we will adjust it by
 */
/atom/movable/screen/plane_master/proc/offset_relay(atom/movable/render_plane_relay/rpr, new_offset)
	var/base_relay_plane = PLANE_TO_TRUE(rpr.plane)
	var/old_offset = PLANE_TO_OFFSET(rpr.plane)
	rpr.plane = GET_NEW_PLANE(base_relay_plane, new_offset)

	var/old_offset_plane = real_plane - (PLANE_RANGE * old_offset)
	var/old_layer = (old_offset_plane + abs(LOWEST_EVER_PLANE * 30))
	if(rpr.layer != old_layer) // Avoid overriding custom-set layers
		return

	var/offset_plane = real_plane - (PLANE_RANGE * new_offset)
	var/new_layer = (offset_plane + abs(LOWEST_EVER_PLANE * 30))
	rpr.layer = new_layer
