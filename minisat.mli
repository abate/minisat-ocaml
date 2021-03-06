
(** For more information http://minisat.se/MiniSat.html
 * and in particular to this paper : 
 * http://minisat.se/downloads/MiniSat.ps.gz
 *)

type minisat

(** variables are integers. They should be created with the method new_var *)
type var = int

type lit

(** the value of a literal can be either True, False or Unknown *)
type lbool = True | False | Unknown
type clause = lit array

class solver :
  object
    val solver : minisat

    (** add a clause to the set of problem constraints. A clause is 
     * a conjunction of positive and negative literals *)
    method add_clause : clause -> bool

    (** create a new variable *)
    method new_var : var

    (** Removes already satisfied clauses. *)
    method simplify : unit

    (** Search for a model without assumptions *)
    method solve : bool

    (** Search for a model that respects a given set of assumptions. *)
    method solve_with_assumption : clause -> bool

    (** The value of a variable in the last model. The last call to solve must
        have been satisfiable *)
    method value_of : var -> lbool

    (** If problem is satisfiable, this vector contains the model (if any). *)
    method model : lbool array

    (** If problem is unsatisfiable (possibly under assumptions),
         this vector represent the final conflict clause expressed in the
         assumptions. *)
    method conflict : clause

    (** The current number of variables. *)
    (* method nvar : int *)
  end

(** convert a value to a string *)
val string_of_lbool : lbool -> string

external mklit : var -> bool -> lit = "minisat_mklit"

(** given a variable, returns a positive literal *)
external pos_lit : var -> lit = "minisat_pos_lit"

(** given a variable, returns a negative literal *)
external neg_lit : var -> lit = "minisat_neg_lit"

external lit_to_var : lit -> var = "minisat_lit_to_var"

external lit_sign : lit -> bool = "minisat_lit_sign"
