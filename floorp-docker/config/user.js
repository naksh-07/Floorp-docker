// Disable Telemetry & Background Services
user_pref("app.shield.optoutstudies.enabled", false);
user_pref("browser.discovery.enabled", false);
user_pref("browser.newtabpage.activity-stream.feeds.telemetry", false);
user_pref("browser.newtabpage.activity-stream.telemetry", false);
user_pref("toolkit.telemetry.enabled", false);
user_pref("toolkit.telemetry.server", "");
user_pref("toolkit.telemetry.unified", false);
user_pref("toolkit.telemetry.archive.enabled", false);
user_pref("toolkit.telemetry.bhrPing.enabled", false);
user_pref("toolkit.telemetry.firstShutdownPing.enabled", false);
user_pref("toolkit.telemetry.newProfilePing.enabled", false);
user_pref("toolkit.telemetry.shutdownPingSender.enabled", false);
user_pref("toolkit.telemetry.updatePing.enabled", false);

// Limit RAM Usage to 2GB
user_pref("dom.ipc.processCount", 1);
user_pref("dom.ipc.processCount.web", 1);
user_pref("browser.cache.memory.capacity", 524288);
user_pref("image.mem.max_decoded_image_kb", 102400);
user_pref("browser.tabs.unloadOnLowMemory", true);
user_pref("browser.tabs.unload.threshold_low_memory", 2000000000); // 2GB Limit

// Reduce Media Buffering to Save RAM
user_pref("media.memory_cache_max_size", 65536);
user_pref("media.cache_readahead_limit", 30);
user_pref("media.cache_resume_threshold", 15);

// Reduce CPU Usage for Rendering
user_pref("gfx.webrender.all", false);
user_pref("gfx.canvas.accelerated", false);
user_pref("media.hardware-video-decoding.enabled", false);

// Optimize JavaScript Execution
user_pref("javascript.options.baselinejit", true);
user_pref("javascript.options.ion", false);
