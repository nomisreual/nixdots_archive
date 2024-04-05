{
  services.gammastep = {
    enable = true;
    provider = "manual";
    latitude = 52.0;
    longitude = 8.5;
    temperature.day = 5500;
    temperature.night = 3700;
    dawnTime = "6:00-7:45";
    duskTime = "18:35-20:15";
    settings = {
      general = {
        adjustment-method = "wayland";
      };
    };
  };
}
