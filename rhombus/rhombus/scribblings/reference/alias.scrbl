#lang rhombus/scribble/manual
@(import:
    "common.rhm" open
    "nonterminal.rhm" open)

@(def dollar = @rhombus($))

@title{Aliases}

@doc(
  ~nonterminal:
    new_id_or_op_name: namespace id_or_op_name ~defn
    orig_id_or_op_name: namespace id_or_op_name ~defn

  defn.macro '«alias '$new_id_or_op_name':
                 $option
                 '$orig_id_or_op_name'»'

  grammar option
  | ~only_space $space ...
  | ~only_space:
      $space ...
      ...
  | ~except_space $space ...
  | ~except_space:
      $space ...
      ...
){

 Defines @rhombus(new_id_or_op_name) to be an alias for
 @rhombus(orig_id_or_op_name). By default, the new name is bound in all
 @tech(~doc: meta_doc){spaces} where the original name is bound (before
 the @rhombus(alias, ~defn) form). The original name must be bound in
 some space.

 If @rhombus(~only_space) is provided, then the new name is bound only
 in the listed spaces, and the original name must be bound in each of
 those spaces. If @rhombus(~except_space) is provided, then the new name
 is not bound in any of the listed spaces. Only one of
 @rhombus(~only_space) or @rhombus(~except_space) can be provided.

@examples(
  ~repl:
    alias 'Roster': 'List'
    Roster[1, 2, 3]
    [1, 2, 3] is_a Roster
  ~repl:
    alias '%': 'mod'
    5 % 2
)

}
