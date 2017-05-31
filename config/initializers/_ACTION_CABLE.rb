ac_params = ::Settings.action_cable

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# APP CONFIG
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
ac_config = Rails.application.config.action_cable

# ActionCable.server.config.mount_path
ac_config.mount_path = ac_params.mount_path

# ActionCable.server.allowed_request_origins
ac_config.allowed_request_origins = ac_params.allowed_request_origins

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# CABLE CONFIG
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cable_config = ActionCable.server.config
cable_config.cable = ac_params.adapter_params.to_h

cable_config.disable_request_forgery_protection = ac_params.disable_request_forgery_protection
cable_config.worker_pool_size  = ac_params.worker_pool_size
