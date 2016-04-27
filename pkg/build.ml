#!/usr/bin/env ocaml
(* Copyright (c) 2015-present, Facebook, Inc. All rights reserved. *)
#directory "pkg"
#use "topkg.ml"
let trace = try let _ = Sys.getenv "trace" in true with | Not_found -> false

let menhir_options = "'menhir --fixed-exception --table " ^ (if trace then "--trace" else "") ^ " '"
let menhir_command = "-menhir " ^ menhir_options

(* ; "-menhir 'menhir --trace'" *)
let () =
  Pkg.describe "reason" ~builder:(`OCamlbuild ["-use-menhir"; menhir_command ]) [
    Pkg.lib "pkg/META";
    (* The .mllib *)
    (* So much redundancy - this should be implicit in the mllib! *)
    Pkg.lib ~exts:Exts.library "src/reason";
    Pkg.lib ~exts:[`Ext ".cmo"; `Ext ".cmx";`Ext ".cmi"; `Ext ".cmt";`Ext ".mli"] "src/reason_parser";
    Pkg.lib ~exts:[`Ext ".cmo"; `Ext ".cmx";`Ext ".cmi";] "src/reason_lexer";
    Pkg.lib ~exts:[`Ext ".cmo"; `Ext ".cmx";`Ext ".cmi"; `Ext ".cmt"] "src/reason_pprint_ast";
    Pkg.lib ~exts:[`Ext ".cmo"; `Ext ".cmx";`Ext ".cmi"; `Ext ".cmt"] "src/reason_oprint";
    Pkg.lib ~exts:[`Ext ".cmo"; `Ext ".cmx";`Ext  ".cmi"; `Ext ".cmt"] "src/reason_config";
    Pkg.lib ~exts:[`Ext ".cmo"; `Ext ".cmx";`Ext  ".cmi"; `Ext ".cmt"] "src/reason_utils";
    Pkg.lib ~exts:[`Ext ".cmo"] "src/reason_toploop";
    Pkg.lib ~exts:[`Ext ".cmx"; `Ext ".o"] "src/reasonbuild";
    Pkg.bin ~auto:true "src/refmt_impl" ~dst:"refmt";
    Pkg.bin  "src/reopt.sh" ~dst:"reopt";
    Pkg.bin  "src/rebuild.sh" ~dst:"rebuild";
    Pkg.bin  "src/reup.sh" ~dst:"reup";
    Pkg.bin "_reasonbuild/_build/myocamlbuild" ~dst:"reasonbuild";
    Pkg.bin  ~auto:true "src/reason_error_reporter" ~dst:"refmterr";
    Pkg.bin  ~auto:true "src/reason_format_type" ~dst:"refmttype";

    Pkg.doc "README.md";
    Pkg.doc "LICENSE.txt";
    Pkg.doc "CHANGELOG.md";
  ]
