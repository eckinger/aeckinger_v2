{
    inputs = {
        ihp.url = "github:digitallyinduced/ihp/v1.3";
        nixpkgs.follows = "ihp/nixpkgs";
        flake-parts.follows = "ihp/flake-parts";
        devenv.follows = "ihp/devenv";
        systems.follows = "ihp/systems";
    };

    outputs = inputs@{ self, nixpkgs, ihp, flake-parts, systems, ... }:
        flake-parts.lib.mkFlake { inherit inputs; } {

            systems = import systems;
            imports = [ ihp.flakeModules.default ];

            perSystem = { pkgs, system, config, ... }: {
                ihp = {
                    # appName = "app"; # Available with v1.4 or latest master
                    enable = true;
                    projectPath = ./.;
                    packages = with pkgs; [
                        # Native dependencies, e.g. imagemagick
                        (nodePackages.tailwindcss.overrideAttrs
                            (_: {
                                plugins = [
                                    nodePackages."@tailwindcss/aspect-ratio"
                                    nodePackages."@tailwindcss/forms"
                                    nodePackages."@tailwindcss/language-server"
                                    nodePackages."@tailwindcss/line-clamp"
                                    nodePackages."@tailwindcss/typography"
                                ];
                            })
                        )
                    ];
                    haskellPackages = p: with p; [
                        # Haskell dependencies go here
                        p.ihp
                        cabal-install
                        base
                        wai
                        text

                        # Uncomment on local development for testing
                        # hspec
                    ];
                };

                # Custom configuration that will start with `devenv up`
                devenv.shells.default = {
                    # Start Mailhog on local development to catch outgoing emails
                    # services.mailhog.enable = true;

                    # Custom processes that don't appear in https://devenv.sh/reference/options/
                    processes = {
                        # Uncomment if you use tailwindcss.
                        tailwind.exec = "tailwindcss -c tailwind/tailwind.config.js -i ./tailwind/app.css -o static/app.css --watch=always";
                    };
                };



            packages.appStylesheet =
                let
                    tailwind = with pkgs; (nodePackages.tailwindcss.overrideAttrs
                        (_: {
                            plugins = [
                                nodePackages."@tailwindcss/aspect-ratio"
                                nodePackages."@tailwindcss/forms"
                                nodePackages."@tailwindcss/language-server"
                                nodePackages."@tailwindcss/typography"
                                ];
                        })
                    );
                    filter = ihp.inputs.nix-filter.lib;
                in pkgs.stdenv.mkDerivation {
                    name = "${config.ihp.appName}-appStylesheet";
                    src = filter {
                        root = ./tailwind;
                        include = [(filter.matchExt "css") (filter.matchExt "js")];
                        exclude = [];
                    };
                    nativeBuildInputs = [tailwind];
                    allowedReferences = [];
                    buildPhase = ''
                        ${tailwind}/bin/tailwindcss -c tailwind.config.js -i app.css -o $out
                    '';
                };
            };


            # Adding the new NixOS configuration for "qa"
            # See https://ihp.digitallyinduced.com/Guide/deployment.html#deploying-with-deploytonixos for more info
            # Used to deploy the IHP application to AWS.
            #
            # Change the `CHANGE-ME` to your correct config.
            flake.nixosConfigurations."aeckinger.com" = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                specialArgs = inputs;
                modules = [
                    "${nixpkgs}/nixos/modules/virtualisation/amazon-image.nix"
                    ihp.nixosModules.appWithPostgres
                    ({ lib, pkgs, ... }: {

                        networking.firewall = {
                            enable = true;
                            allowedTCPPorts = [ 22 80 443 ];
                        };

                        # Enable the Let's encrypt certificate
                        security.acme.defaults.email = "alexandereckinger@gmail.com";

                        # Accept the terms of service of the Let's encrypt provider.
                        security.acme.acceptTerms = true;

                        services.nginx = {
                            virtualHosts."aeckinger.com" =  {
                                # Uncomment to have http auth with username `foo` and password `bar`.
                                basicAuth = { foo = "bar"; };
                            };
                        };

                        # Logging to AWS CloudWatch
                        # services.vector = {
                        #     enable = true;
                        #     journaldAccess = true;
                        #     settings = {
                        #         sources.journald = {
                        #             type = "journald";
                        #             # Log only the services we care about
                        #             include_units = ["app.service" "nginx.service" "worker.service"];
                        #         };

                        #         sinks.out = {
                        #             group_name = "CHANGE-ME";
                        #             stream_name = "CHANGE-ME";
                        #             # Change the region to the correct one, e.g. `us-east-1`
                        #             region = "CHANGE-ME";
                        #             auth = {
                        #                 access_key_id = "CHANGE-ME";
                        #                 secret_access_key = "CHANGE-ME";
                        #             };
                        #             inputs  = ["journald"];
                        #             type = "aws_cloudwatch_logs";
                        #             compression = "gzip";
                        #             encoding.codec = "json";
                        #         };
                        #     };
                        # };

                        services.ihp = {
                            domain = "aeckinger.com";
                            migrations = ./Application/Migration;
                            schema = ./Application/Schema.sql;
                            fixtures = ./Application/Fixtures.sql;
                            sessionSecret = "xxx";
                            # Uncomment to use a custom database URL
                            # databaseUrl = lib.mkForce "postgresql://postgres:...CHANGE-ME";
                        };
                        # Add swap to avoid running out of memory during builds
                        # Useful if your server have less than 4GB memory
                        swapDevices = [ { device = "/swapfile"; size = 8192; } ];
                        # As we use a pre-built AMI on AWS,
                        # it is essential to enable automatic updates.
                        # @see https://nixos.wiki/wiki/Automatic_system_upgrades
                        system.autoUpgrade.enable = true;
                        # Keep as is. See https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
                        system.stateVersion = "23.05";
                    })
                ];
            };

        };
}
