#define SPACE_SIGNAL_GPSTAG "远方信号"
#define SPACE_SIGNAL_GPSTAG_WHITE_SHIP "求救信号"

/// Every mob in the game will have a screen object sitting inside them with a reference matching this
/// So you can render_source against it and never need to update it again
#define SPACE_OVERLAY_RENDER_TARGET(offset) "*space_overlay_target[offset]"
