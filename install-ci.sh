#!/bin/bash
# Copyright (c) 2015-present, Facebook, Inc. All rights reserved.

OCAML=`which ocaml`
BIN=$(dirname $OCAML)

INSTALL_FILES=_build/src/*.[aco]*
INSTALL_FILES="_build/pkg/META $INSTALL_FILES"

install _build/_reasonbuild/_build/myocamlbuild $BIN/reasonbuild
install _build/src/rebuild.sh $BIN/rebuild
install _build/src/refmt_impl.native $BIN/refmt
install _build/src/reopt.sh  $BIN/reopt

ocamlfind install reason $INSTALL_FILES



