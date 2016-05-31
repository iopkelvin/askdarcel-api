unless Rails.env.production?
  Rails.application.configure do
    config.after_initialize do
      Bullet.enable = Rails.env.test? # Only enable Bullet during testing.
      Bullet.bullet_logger = true
      Bullet.raise = true
    end
  end
end
