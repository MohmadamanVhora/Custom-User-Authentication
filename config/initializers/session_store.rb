Rails.application.config.session_store :cookie_store,
                                       key: 'user_id',
                                       expire_after: 1.hour
