#lang rhombus/scribble/manual
@(import:
    "common.rhm" open
    meta_label:
      rhombus/measure
      rhombus/measure open)

@title(~tag: "module-paths"){Module Paths}

A @deftech{module path} is a reference to a module, as used with
@rhombus(import) or as the language module path after @rhombus(~lang)
in a @rhombus(module, ~decl) form. It can be any of several forms.

@doc(
  grammar_case "module path":
    $string
){

 A string @tech{module path} is a relative path using Unix-style
 conventions: @litchar{/} is the path separator, @litchar{..} refers to
 the parent directory, and @litchar{.} refers to the same directory. The
 string must not start or end with a path separator.

 The path is relative to the enclosing file, if any, or it is relative to
 the current directory.

 @secref("module-basics") shows examples using relative paths.

}

@doc(
  ~nonterminal:
    id: block
  grammar_case "module path":
    $collection_module_path
  grammar collection_module_path
  | $id
  | $id #,(@rhombus(/, ~impo)) $collection_module_path
){

 A @tech{module path} that is an identifier or
 @rhombus(/, ~impo)-separated sequence of identifiers refers to an
 installed library. The identifiers are constrained to contain only ASCII
 letters, ASCII numbers, @litchar{+}, @litchar{-}, and @litchar{_}. The
 identifiers in such a collection path refer to @tech{collections} and
 subcollections, instead of directories and subdirectories.

 An example of this form is @rhombusmodname(rhombus/measure). It refers
 to the module whose source is the @filepath{measure.rhm} file in the
 @filepath{rhombus} collection, which is installed as part of Rhombus.
 The @filepath{.rhm} suffix is added automatically.

@rhombusblock(
  #,(@hash_lang()) #,(@rhombuslangname(rhombus))

  import:
    #,(@rhombusmodname(rhombus/measure))

  measure.cpu_milliseconds()
)

}

@doc(
  grammar_case "module path":
    #,(@rhombus(lib, ~impo))($rel_string)
){

 A @rhombus(lib, ~impo) path is like an identifier path, but expressed as
 a string instead of @rhombus(/, ~impo)-separated identifiers. A
 @rhombus(rel_string, ~var) can end with a file suffix, in which case
 @filepath{.rhm} is not automatically added. If
 @rhombus(rel_string, ~var) does not contain @litchar{/}, then
 @filepath{/main.rhm} is appended to the string when forming the module
 file path.

 To refer to a Racket module, use a @rhombus(lib, ~impo) path with a
 @filepath{.rkt} suffix.

@rhombusblock(
  #,(@hash_lang()) #,(@rhombuslangname(rhombus))

  import:
    lib("racket/math.rkt") as rkt_math

  rkt_math.pi  // prints 3.141592653589793
)

}


@doc(
  grammar_case "module path":
    #,(@rhombus(file, ~impo))($string)
){

 A @rhombus(file, ~impo) path refers to a file, where
 @rhombus(string, ~var) is a relative or absolute path using the current
 platform's conventions. This form is not portable, and it should
 @italic{not} be used when a plain, portable string suffices.

}

@doc(
  ~nonterminal:
    id: block
  grammar_case "module path":
    $module_path #,(@rhombus(!, ~impo)) $id
){

 A path with @rhombus(!, ~impo) refers to the @tech{submodule} named
 @rhombus(id) of the module referenced by
 @rhombus(module_path). Multiple uses of @rhombus(!, ~impo) can be
 chained to reach more deeply nested submodules.

@rhombusblock(
  module zoo ~lang #,(@rhombuslangname(rhombus)):
    module monkey_house ~lang #,(@rhombuslangname(rhombus)):
      export:
        monkey
      def monkey = "Curious George"

  import self!zoo!monkey_house open
  monkey
)

}

@doc(
  grammar_case "module path":
    #,(@rhombus(self, ~impo))
  grammar_case "module path":
    #,(@rhombus(parent, ~impo))
){

 The @rhombus(self, ~impo) module path form
 can be used only with @rhombus(!, ~impo) to refer to a @tech{submodule}.
 The form @rhombus(self!, ~impo)@rhombus(id, ~var) refers to a
 @tech{submodule} named @rhombus(id, ~var) of the enclosing module.
 Additional uses of @rhombus(!, ~impo) refer to more deeply nested
 submodules within that one. In an interactive context such as a
 @tech{REPL}, @rhombus(self!, ~impo)@rhombus(id, ~var) refers to a module
 declared interactively with name @rhombus(id, ~var).

 The form @rhombus(parent, ~impo) refers to the parent of an enclosing
 submodule. A @rhombus(parent, ~impo) form may be followed by
 @rhombus(!, ~impo)@rhombus(id, ~var) to access a sibling submodule.
 Additional @rhombus(!, ~impo) operators immediately after
 @rhombus(parent!, ~impo) reach further up the enclosing-module chain.

@rhombusblock(
  module zoo ~lang #,(@rhombuslangname(rhombus)):
    module monkey_house ~lang #,(@rhombuslangname(rhombus)):
      export:
        monkey
      def monkey = "Curious George"
    module crocodile_house ~lang #,(@rhombuslangname(rhombus)):
      import:
        parent!monkey_house open
      export:
        dinner
      def dinner = monkey

  import self!zoo!crocodile_house open
  dinner
)

}

@doc(
  ~nonterminal:
    id: block
    id_or_op: block
  grammar_case "module path":
    . $id
  grammar_case "module path":
    $module_path . $id_or_op
){

 A prefix @rhombus(., ~impo) refers to an import prefix or a namespace
 @rhombus(id) in the enclosing environment, not to a separate
 module. An infix @rhombus(., ~impo) refers to an exported
 @rhombus(id, ~var) (or operator @rhombus(op, ~var)) provided by a
 @rhombus(module_path). When the last @rhombus(id) in a
 dotted sequence is not itself a namespace, the dotted form is a
 shorthand for exposing just that binding from
 @rhombus(module_path).

@rhombusblock(
  import:
    #,(@rhombusmodname(rhombus/measure)).cpu_milliseconds

  cpu_milliseconds()
)

}
