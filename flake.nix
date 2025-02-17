{
  description = "
      Yggdrasil provider flakes:
        - Go : go1.23.0
        - Git : git (Use system git)
        - Oh My Zsh : enabled
  ";

  inputs = {
      nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
      flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        go = pkgs.go_1_23;  # Go 1.23 버전 지정
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            go        # Go 1.23
            pkgs.zsh  # Zsh
            pkgs.oh-my-zsh  # Oh My Zsh
          ];

        shellHook = ''
          # Go 환경 설정
          export GOROOT="${go}"
          export GOPATH="$HOME/go"
          export PATH="$GOPATH/bin:$PATH"

          # Oh My Zsh 설정
          export ZSH="${pkgs.oh-my-zsh}/share/oh-my-zsh"
          export SHELL=$(which zsh)

          echo "======================================"
          echo "✅ Go 개발 환경 + Oh My Zsh 활성화 완료!"
          echo "   - Go 버전: $(go version)"
          echo "   - GOROOT: $GOROOT"
          echo "   - GOPATH: $GOPATH"
          echo "   - 사용 셸: $SHELL"
          echo "======================================"
        '';


        };
      });
}
