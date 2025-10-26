#lang rhombus/scribble/manual
@(import:
    "common.rhm" open)

@title{Rhombus}

Rhombus is a general-purpose programming language that is easy to use
and uniquely customizable.

@margin_note_block{Rhombus is built on @hyperlink("https://racket-lang.org"){Racket}, and
it is extensible in the same way as Racket, but Rhombus uses a more
conventional expression syntax. No familiarity with Racket is required
to use Rhombus.}

This document is a general guide to the language. For more
documentation, see @docref(getting_started_doc).

@table_of_contents()

@include_section("guide/quick.scrbl")
@include_section("guide/overview.scrbl")
@include_section("guide/datatype.scrbl")
@include_section("guide/class-overview.scrbl")
@include_section("guide/io.scrbl")
@include_section("guide/macro.scrbl")
@include_section("guide/annotation-overview.scrbl")
@include_section("guide/static-overview.scrbl")
@include_section("guide/lang.scrbl")
@include_section("guide/running.scrbl")
@include_section("guide/racket.scrbl")
