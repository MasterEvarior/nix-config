{
  lib,
  config,
  osConfig,
  pkgs-unstable,
  ...
}:

{
  options.homeModules.applications.ollama =
    let
      gpuType = osConfig.modules.hardwareInfo.gpu;
    in
    {
      enable = lib.mkEnableOption "Ollama";
      package = lib.mkPackageOption pkgs-unstable "ollama" {
        default = [
          (
            if gpuType == "none" then
              "ollama-cpu"
            else if gpuType == "nvidia" then
              "ollama-cuda"
            else if gpuType == "amd" then
              "ollama-rocm"
            else
              "ollama-vulkan"
          )
        ];
      };
      contextWindow = lib.mkOption {
        default = 32 * 1024;
        example = 16 * 1024;
        type = lib.types.int;
        description = "How big the context window should be";
      };
      loadModels = lib.mkOption {
        default = [
          {
            name = "llama3.2:1b";
            tools = true;
          }
          {
            name = "lfm2.5-thinking:1.2b";
            tools = true;
          }
          {
            name = "granite3.3:8b";
            tools = true;
            requiresGPU = true;
          }
        ];
        example = [
          {
            name = "codegemma:2b";
            tools = true;
          }
        ];
        type = lib.types.listOf (
          lib.types.submodule {
            options = {
              name = lib.mkOption {
                example = "codegemma:2b";
                type = lib.types.str;
                description = "Name of the model";
              };
              tools = lib.mkOption {
                default = true;
                example = true;
                type = lib.types.bool;
                description = "Wether or not the model is capable of using tools in OpenCode";
              };
              requiresGPU = lib.mkOption {
                default = false;
                example = true;
                type = lib.types.bool;
                description = "Only install this model if a GPU is present";
              };
            };
          }
        );
        description = "List of models to (pre-)load";
      };
    };

  config =
    let
      cfg = config.homeModules.applications.ollama;
      gpuType = osConfig.modules.hardwareInfo.gpu;
      allowedModels =
        if gpuType != "none" then
          cfg.loadModels
        else
          builtins.filter (m: m.requiresGPU == false) cfg.loadModels;
      modelNames = map (m: m.name) allowedModels;
    in
    lib.mkIf config.homeModules.applications.ollama.enable {
      services.ollama = {
        enable = true;
        package = cfg.package;
        environmentVariables = {
          OLLAMA_CONTEXT_LENGTH = (toString cfg.contextWindow);
        };
      };

      systemd.user.services."ollama-pre-load" = lib.mkIf (allowedModels != [ ]) {
        Unit = {
          Description = "Load Ollama Models declaratively";
          After = [ "ollama.service" ];
          Requires = [ "ollama.service" ];
        };

        Service = {
          Type = "oneshot";

          ExecStart =
            let
              script = pkgs-unstable.writeShellScript "ollama-pre-load-script" ''
                # Wait for the Ollama API to be ready (timeout after ~60s)
                attempts=0
                echo "Waiting for Ollama API to become responsive..."
                until ${pkgs-unstable.curl}/bin/curl -s http://${config.services.ollama.host}:${toString config.services.ollama.port}/api/tags > /dev/null; do
                  attempts=$((attempts+1))
                  if [ $attempts -ge 30 ]; then
                    echo "Ollama API did not respond in time. Exiting."
                    exit 1
                  fi
                  sleep 2
                done

                echo "Ollama API is ready. Proceeding to pull models."

                ${lib.getExe pkgs-unstable.parallel} --tag ${lib.getExe cfg.package} pull ::: ${lib.escapeShellArgs modelNames}

                echo "All models successfully loaded."
              '';
            in
            "${script}";
        };

        Install = {
          WantedBy = [ "default.target" ];
        };
      };
    };
}
