# with import <nixpkgs> {};
{ stdenv, fetchFromGitHub, postgresql }:

let
  name = "pg-spgist_hamming";
  repo = fetchFromGitHub {
    owner  = "fake-name";
    repo   = name;
    rev    = "9fa70b08e0f0108de6a6673ce095c86a987d261d";
    sha256 = "0rh1l2saw2cnrn4mbawx42wx4a1343fjg3qxlcrgcs6aig7cpgfi";
  };

in

stdenv.mkDerivation rec {
    pname = name;

    version = "1.0";

    buildInputs = [
      postgresql
    ];

    patches = [
      ./op_symbol.patch
    ];

    src = "${repo}/bktree";

    installPhase = ''
      mkdir -p $out/{lib,share/postgresql/extension}

      cp *.so      $out/lib
      cp *.sql     $out/share/postgresql/extension
      cp *.control $out/share/postgresql/extension
    '';
}
