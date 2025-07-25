self: super:

{
  supabase-cli = super.supabase-cli.overrideAttrs (old: rec {
    version = "2.22.8";

    src = fetchFromGitHub {
      owner = "supabase";
      repo = "cli";
      rev = "v${version}";
      hash = "sha256-faW/1oBbYRq+8vQbipYXNTVIftXkKM3uGPbNNPeZivY=";
    };

    # # 如果解压后的文件名有变化可能需要添加安装步骤
    # installPhase = ''
    #   install -D supabase $out/bin/supabase
    # '';
  });
}