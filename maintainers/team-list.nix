/* List of maintainer teams.
    name = {
      # Required
      members = [ maintainer1 maintainer2 ];
      scope = "Maintain foo packages.";
    };

  where

  - `members` is the list of maintainers belonging to the group,
  - `scope` describes the scope of the group.

  More fields may be added in the future.

  Please keep the list alphabetically sorted.
  */

{ lib }:
with lib.maintainers; {
  acme = {
    members = [
      aanderse
      andrew-d
      arianvp
      emily
      flokli
      m1cr0man
    ];
    scope = "Maintain ACME-related packages and modules.";
  };

  cinnamon = {
    members = [
      mkg20001
    ];
    scope = "Maintain Cinnamon desktop environment and applications made by the LinuxMint team.";
  };

  freedesktop = {
    members = [ jtojnar worldofpeace ];
    scope = "Maintain Freedesktop.org packages for graphical desktop.";
  };

  gnome = {
    members = [
      dasj19
      hedning
      jtojnar
      worldofpeace
    ];
    scope = "Maintain GNOME desktop environment and platform.";
  };

  golang = {
    members = [
      c00w
      cstrahan
      Frostman
      kalbasit
      mdlayher
      mic92
      orivej
      rvolosatovs
      zowoq
    ];
    scope = "Maintain Golang compilers.";
  };

  jitsi = {
    members = [
      mmilata
      petabyteboy
      prusnak
      ryantm
    ];
    scope = "Maintain Jitsi.";
  };

  matrix = {
    members = [
      ekleog
      fadenb
      ma27
      mguentner
      pacien
      ralith
    ];
    scope = "Maintain the ecosystem around Matrix, a decentralized messenger.";
  };

  php = {
    members = [
      aanderse
      etu
      globin
      ma27
      talyz
    ];
    scope = "Maintain PHP related packages and extensions.";
  };

  podman = {
    members = [
      adisbladis
      saschagrunert
      vdemeester
      zowoq
    ];
    scope = "Maintain Podman and CRI-O related packages and modules.";
  };
}
