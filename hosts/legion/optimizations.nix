{ pkgs, config, lib, ... }:

{
  # ============================================================================
  # Power Management & Battery Optimization for Legion i9-14900HX + RTX 4080
  # ============================================================================

  # CPU Power Management - Intel 14900HX optimization
  boot.kernelParams = [
    # Enable Intel P-State driver for better frequency scaling
    "intel_pstate=active"

    # Aggressive CPU power saving
    "i915.enable_fbc=1"           # Framebuffer compression
    "i915.enable_psr=2"           # Panel Self Refresh
    "i915.fastboot=1"             # Faster boot with less power draw

    # Reduce CPU C-state latency for better battery
    # "intel_idle.max_cstate=5"

    # Disable unnecessary features for battery life
    "nmi_watchdog=0"              # Reduces timer interrupts
  ];

  # Advanced power management
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "powersave"; # Use powersave governor by default
    powertop.enable = true;        # Auto-tune power settings
  };

  # Enhanced TLP configuration for Legion laptop
  services.tlp = {
    enable = true;
    settings = {
      # CPU Settings
      CPU_DRIVER_OPMODE_ON_AC = "active";
      CPU_DRIVER_OPMODE_ON_BAT = "active";

      CPU_SCALING_GOVERNOR_ON_AC = "powersave";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      # Energy Performance Preference (EPP) - key for 14900HX
      CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

      # Intel CPU HWP (Hardware P-States) optimization
      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;  # Disable turbo boost on battery for quietness

      # Frequency scaling - 14900HX base: 2.2GHz, boost: 5.8GHz
      CPU_SCALING_MIN_FREQ_ON_AC = 800000;    # 800 MHz minimum
      CPU_SCALING_MAX_FREQ_ON_AC = 5800000;   # Allow full turbo on AC
      CPU_SCALING_MIN_FREQ_ON_BAT = 800000;   # 800 MHz minimum
      CPU_SCALING_MAX_FREQ_ON_BAT = 2200000;  # Limit to base clock on battery

      # Platform profiles (if supported by ACPI)
      PLATFORM_PROFILE_ON_AC = "balanced";
      PLATFORM_PROFILE_ON_BAT = "low-power";

      # Processor Performance Settings
      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 30;  # Limit to 30% on battery

      # GPU Power Management
      RUNTIME_PM_ON_AC = "auto";
      RUNTIME_PM_ON_BAT = "auto";

      # PCIe Active State Power Management
      PCIE_ASPM_ON_AC = "default";
      PCIE_ASPM_ON_BAT = "powersupersave";

      # PCIe Runtime PM for all devices (aggressive power saving)
      RUNTIME_PM_DRIVER_DENYLIST = "mei_me nouveau";  # Exclude problematic drivers

      # Disk Settings
      DISK_DEVICES = "nvme0n1";
      DISK_APM_LEVEL_ON_AC = "254 254";
      DISK_APM_LEVEL_ON_BAT = "128 128";

      # SATA link power management
      SATA_LINKPWR_ON_AC = "med_power_with_dipm";
      SATA_LINKPWR_ON_BAT = "min_power";

      # NVMe power saving
      AHCI_RUNTIME_PM_ON_AC = "auto";
      AHCI_RUNTIME_PM_ON_BAT = "auto";

      # Network Power Management
      WIFI_PWR_ON_AC = "off";
      WIFI_PWR_ON_BAT = "on";

      # Disable Wake-on-LAN
      WOL_DISABLE = "Y";

      # Sound Power Saving
      SOUND_POWER_SAVE_ON_AC = 0;
      SOUND_POWER_SAVE_ON_BAT = 1;
      SOUND_POWER_SAVE_CONTROLLER = "Y";

      # USB Autosuspend (be careful with peripherals)
      USB_AUTOSUSPEND = 1;
      USB_EXCLUDE_BTUSB = 1;  # Don't suspend Bluetooth
      USB_EXCLUDE_PHONE = 1;  # Don't suspend phones

      # Battery Care (if supported - limits charge to extend battery life)
      START_CHARGE_THRESH_BAT0 = 75;  # Start charging at 75%
      STOP_CHARGE_THRESH_BAT0 = 80;   # Stop charging at 80%

      # Restore previous charge thresholds on reboot
      RESTORE_THRESHOLDS_ON_BAT = 1;
    };
  };

  # Auto-cpufreq alternative (commented out - use either TLP or auto-cpufreq, not both)
  # services.auto-cpufreq = {
  #   enable = true;
  #   settings = {
  #     battery = {
  #       governor = "powersave";
  #       turbo = "never";
  #     };
  #     charger = {
  #       governor = "powersave";
  #       turbo = "auto";
  #     };
  #   };
  # };

  # Additional power-saving packages
  environment.systemPackages = with pkgs; [
    powertop            # Power consumption monitoring
    intel-gpu-tools     # Intel GPU monitoring
    nvtopPackages.full  # NVIDIA GPU monitoring
    lm_sensors          # Hardware monitoring (fan speeds, temps)
    stress              # CPU stress testing for thermal testing
  ];

  # Reduce journal size to reduce disk writes
  services.journald.extraConfig = ''
    SystemMaxUse=100M
    MaxFileSec=7day
  '';

  # Optimize systemd services
  systemd.settings.Manager = {
    DefaultTimeoutStopSec = "10s";
  };

  # Disable services that might wake the system
  services.logind = {
    settings.Login = {
      HandleLidSwitch = "suspend";
      HandleLidSwitchExternalPower = "lock";
      HandlePowerKey = "suspend";
      IdleAction = "suspend";
      IdleActionSec = "15min";
    };
  };

  # Kernel patches and modules for better power management
  boot.kernelModules = [
    "acpi_call"  # For advanced power management
    "msr"        # CPU MSR access for monitoring
  ];

  boot.extraModulePackages = with config.boot.kernelPackages; [
    acpi_call
  ];
}
