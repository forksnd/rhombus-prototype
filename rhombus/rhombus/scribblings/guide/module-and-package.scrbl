#lang rhombus/scribble/manual
@(import:
    "common.rhm" open)

@title(~tag: "module-and-package", ~style: #'toc){Modules and Packages}

Modules let you organize Rhombus code into multiple files and reusable
libraries. We introduced some module basics in @secref("Modules"), but
this section goes into more detail.

@local_table_of_contents()

@include_section("module-basics.scrbl")
@include_section("module-syntax.scrbl")
@include_section("module-paths.scrbl")
@include_section("module-import.scrbl")
@include_section("module-export.scrbl")
@include_section("module-set.scrbl")
@include_section("module-macro.scrbl")
