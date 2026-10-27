#define GENERATE_JOB_CONFIG_VERB_DESC "为服务器生成职业配置文件（jobconfig.toml）。如果 TOML 文件已存在，将基于现有配置值重新生成。必要时会从旧的 jobs.txt 格式迁移。"

ADMIN_VERB(generate_job_config, R_SERVER, "生成职业配置", GENERATE_JOB_CONFIG_VERB_DESC, ADMIN_CATEGORY_SERVER)
	if(tgui_alert(user, "如果你不是能访问配置文件夹的服务器运营者，这条指令几乎没有用处。你确定要继续吗？", "生成 jobconfig.toml 以供下载", list("Yes", "No")) != "Yes")
		return

	if(SSjob.generate_config(user))
		to_chat(user, span_notice("职业配置文件已生成。下载提示现在应该会出现。"))
	else
		to_chat(user, span_warning("无法生成职业配置文件。请查看服务器日志 / 运行时错误 / 上方的警告信息以获取更多信息。"))

	BLACKBOX_LOG_ADMIN_VERB("Generate Job Configuration")

#undef GENERATE_JOB_CONFIG_VERB_DESC
