#lang rhombus/scribble/manual
@(import:
    "common.rhm" open
    "nonterminal.rhm" open)

@(def var_term = @rhombus(term, ~var))
@(def var_id = @rhombus(id, ~var))

@title{Matching}

@doc(
  ~nonterminal:
    target_expr: block expr
    result_body: block body
    result_expr: block expr

  expr.macro 'match $target_expr:
                $maybe_arity_decl
              | $values_bind:
                  $result_body
                  ...
              | ...'
  expr.macro 'match $target_expr:
                $maybe_arity_decl
              | $values_bind:
                  $result_body
                  ...
              | ...
              | ~else:
                  $result_body
                  ...'
  expr.macro 'match $target_expr:
                $maybe_arity_decl
              | $values_bind:
                  $result_body
                  ...
              | ...
              | ~else $result_expr'

  grammar maybe_arity_decl:
    ~arity: $given_arity_num
    ~arity $given_arity_num
    #,(epsilon)
){

 Tries matching the results of @rhombus(target_expr) against each
 @rhombus(values_bind) in sequence, and as soon as one matches, returns the
 result of the corresponding @rhombus(result_body) block. The keyword
 @rhombus(~else) can be used as a synonym for a pattern that always
 matches without binding any identifiers in the last clause.

 Typically, a @nontermref(bind) in @rhombus(values_bind) imposes requirement on a value and binds
 some number of identifiers as a result of a successful match. For
 example, a literal number works as a @nontermref(bind) pattern, but it
 binds zero identifiers. An identifier as a @nontermref(bind) pattern
 matches any value and binds the identifier to the matching value. A
 list form is a @nontermref(bind) pattern with subpatterns as its
 elements, and it matches a list with the right number of elements that
 match the corresponding pattern. A @rhombus(when, ~bind) or
 @rhombus(unless, ~bind) can impose a side condition on a match.
 The set of @nontermref(bind) forms is extensible, so it cannot be
 completely enumerated here.

@examples(
  match 1+2
  | 3: "three"
  | ~else: "not three"

  match [1+2, 3+4]
  | [x, y]: x+y

  ~error:
    match 'go ~slow'
    | 'go ~fast': "ok"

  ~error:
    match 1+2
    | n when n > 4: "ok"
)

 If no @rhombus(values_bind) matches the values and there is no
 @rhombus(~else) clause, a run-time exception is thrown. In that case,
 when all of the @rhombus(values_bind) forms are single-value syntax-object patterns, the
 generated exception's message may be specialized to report the expected
 pattern, instead of just reporting that no cases matched.

@examples(
  ~error:
    match 1+2
    | 4: "four"
  ~error:
    match '1+2'
    | '4': "four"
)

 If an initial segment of single-value @rhombus(values_bind) patterns are ``literal-like''
 or combinations of such patterns with @rhombus(||, ~bind), then the
 match is implemented as a case dispatch, and a match is found with
 logarithmic rather than linear time complexity in the number of
 literals. ``Literal-like'' patterns include (usually implicitly used)
 @rhombus(#%literal, ~bind), @rhombus(#', ~bind),
 @rhombus(Char, ~bind), and @rhombus(Byte, ~bind). The remaining
 patterns are handled as usual.

@examples(
  ~defn:
    fun classify_efficiently(n):
      match n
      | 1: "one"
      | 2: "two"
      | 3 || 4: "some"
      | ~else: "more"
)

 Since each clause is allowed to use a multiple-value
 @rhombus(values_bind) pattern, @rhombus(target_expr) is also allowed
 to produce multiple values. All clauses in a @rhombus(match) form
 must match the same number of values, otherwise a syntax error is
 reported. When no clause or only @rhombus(~else) clause is present,
 @rhombus(target_expr) is expected to produce one value, but this can
 be overridden by an optional @rhombus(maybe_arity_decl)
 declaration. The @rhombus(given_arity_num) number must be a literal
 nonnegative integer.@margin_note{If a macro expands into a
 @rhombus(match) form that matches a known number of multiple values,
 and the expansion can produce no clauses, it is recommended that you
 should explicitly include the @rhombus(maybe_arity_decl), so that a
 proper fallthrough error is thrown instead of an arity error.}

@examples(
  match values(1, 2)
  | (1, 1): "both one"
  | (1, 2): "one and two"
  | (2, 2): "both two"
  match 1
  | ~else: "one value"
  match 1
  | _: "one value"
  ~error:
    match 1:
      ~arity: 2
    | ~else: "two values"
  match values(1, 2):
    ~arity: 2
  | ~else: "two values"
  match values(1, 2)
  | (_, _): "two values"
  ~error:
    match values(1, 2)
    | ~else: "one value"
)

 Static information for @rhombus(target_expr) is propagated to each
 @rhombus(values_bind).

@examples(
  use_static
  match (["apple", "banana"] :: List.of(String))
  | [s, ...]: [s.length(), ...]
  match values(["apple", "banana"] :: List.of(String),
               [1, 2] :: List.of(Int))
  | ([s, ...], [i, j]):
      values([s.length(), ...], i < j)
)

}


@doc(
  expr.macro '$expr matches $bind'
  repet.macro '$repet matches $bind'
  non_target:
    expr.macro '$expr !matches $bind'
  non_target:
    repet.macro '$repet !#,(@rhombus(matches, ~repet)) $bind'
  operator_order:
    ~order: equivalence
){

 Produces @rhombus(#true) if the value of @rhombus(expr) matches
 @nontermref(bind), @rhombus(#false) otherwise. Equivalent to
 @rhombus(expr is_a matching(bind)). The operator combination
 @rhombus(!matches) inverts the test. Either form works as a
 @tech{repetition} given a repetition to match.

@examples(
  [1, 2, 3] matches [_, _, _]
  [1, 2, 3] is_a matching([_, _, _])
)

}

@doc(
  bind.macro '_'
){

 Matches any value without binding any identifiers.

@examples(
  match 1+2
  | 0: "zero"
  | _: "nonzero"
)

}


@doc(
  expr.macro '_'
){

 As an expression by itself, @rhombus(_) is a syntax error, but
 @rhombus(_) is recognized by @rhombus(#%parens) and @rhombus(#%call) in
 expression-like positions to trigger a function-shorthand conversion.

 The @rhombus(#%parens) conversion applies when @parens are used in an
 expression position, and at least one @rhombus(_) appears immediately
 within the parentheses as in
 @rhombus((#,(var_term) ... _ #,(var_term) ...)). An @defterm{immediate}
 @rhombus(_) is one that is not more deeply nested in a term within the
 parentheses. A single immediate @rhombus(_) is replaced by a fresh
 identifier @var_id as an expression, and then the parenthesized sequence
 is placed in the body of a function that uses the identifier as an
 argument, as in
 @rhombus((fun (#,(var_id)): #,(var_term) ... #,(var_id) #,(var_term) ...)).
 If multiple immediate @rhombus(_)s are present, each one is replaced by
 a distinct identifier, the identifiers are used as the arguments of the
 generated function, and the arguments match the order of the
 corresponding @rhombus(_). Moreover, static information is gathered
 from the parenthesized sequence, by parsing it as an expression, and
 propagated as result information.

@examples(
  ~repl:
    def subtract = (_ - _)
    subtract(2, 1)
    [1, 2, 3].map((_ + 1))
)

 The @rhombus(#%call) conversion applies when @parens are used after an
 expression, at least one @rhombus(_) appears by itself as an argument,
 and no argument uses @rhombus(&) or is a repetition followed by a
 @rhombus(...). Each @rhombus(_) argument is converted as in the
 @rhombus(#%parens) conversion, but the conversion applies only for a
 @rhombus(_) that appears by itself in the group for function-call
 argument. Moreover, result information is gathered from the inner
 function and propagated to the outer function.

@examples(
  ~repl:
    def low_bits = bits.field(_, 0, 3)
    low_bits(15)
    [1.25, 2.75, 3.0].map(math.round(_))
)

 A @rhombus(_) combined with other terms as a function-call
 argument @emph{does not} trigger a function-shorthand conversion.

@examples(
  ~error:
    [1, 2, 3].map(_ + 1)
)

}

@doc(
  ~nonterminal:
    left_bind: def bind ~defn
    right_bind: def bind ~defn

  bind.macro '$left_bind where $right_bind = $expr'
  bind.macro '$left_bind where:
                $right_bind_and_expr
                ...'

  grammar right_bind_and_expr:
    $right_bind = $expr
    $right_bind:
      $body
      ...
){

 Creates a binding that matches only when both @rhombus(left_bind)
 matches and when each @rhombus(right_bind) matches the value of the
 corresponding @rhombus(expr) or @rhombus(body) sequence. Names bound by
 @rhombus(left_bind) and each @rhombus(right_bind) are visible in
 @rhombus(expr)s and @rhombus(body) sequences for subsequent
 @rhombus(right_bind)s.

 The @rhombus(where) form should generally be used with parentheses
 around it, since parsing is otherwise likely to interact badly with the
 enclosing context, such as conflicting interpretations of a @rhombus(=)
 by @rhombus(where) and @rhombus(def).

 See also @rhombus(when, ~bind) and @rhombus(unless, ~bind).

@examples(
  ~repl:
    def ([x, y, z] where sum = x+y+z) = [1, 2, 3]
    '$x $y $z'
    sum
  ~defn:
    fun
    | f(([x, y, z] where sum = x+y+z) when sum == 6):
        '$x $y $z = $sum'
    | f(_):
        "something else"
  ~repl:
    f([1, 2, 3])
    f([0, 2, 3])
  ~repl:
    def ([x, y, z] where:
           partial_sum = x+y
           sum = partial_sum+z):
      [1, 2, 3]
    sum
  ~repl:
    def ([xs] where [x, ...] = xs) = [[1, 2, 3]]
    '$x ...'
  ~repl:
    ~error:
      def ([xs] where [x, ...] = xs) = ["oops"]
)

}


@doc(
  expr.macro 'where'
  expr.macro '$expr where'
){

 As an expression operator, @rhombus(where) always reports a syntax
 error.

}
