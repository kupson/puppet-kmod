(* Linevars module for Augeas
 Author: Rafal Kupka <kupson@kupson.fdns.net>

*)

module Linevars =
  autoload xfm

(************************************************************************
 *                           USEFUL PRIMITIVES
 *************************************************************************)

let eol     = Util.eol
let comment = Util.comment
let empty   = Util.empty

(************************************************************************
 *                               ENTRIES
 *************************************************************************)

let line = [ label "entry" . store /.+/ . eol ]

(************************************************************************
 *                                LENS
 *************************************************************************)

let lns = ( comment | empty | line ) *

(* configuration files that can be parsed without customizing the lens *)
let filter = Util.stdexcl
           . incl "/etc/modules"

let xfm = transform lns filter
