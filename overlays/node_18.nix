final: prev: {
  nodejs-18_x = prev.nodejs-18_x.overrideAttrs (old: rec {
    version = "18.17.0";
    src = prev.fetchurl {
      url = "https://nodejs.org/dist/v${version}/node-v${version}.tar.xz";
      sha256 = "sha256-gMD6rfXqOcITzLmqXCQyl3oPG1oLdmhSq9DeBvJ3BAY=";
    };
  });
}