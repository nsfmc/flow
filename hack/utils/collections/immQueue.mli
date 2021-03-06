(**
 * Copyright (c) 2017, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the "hack" directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 *
 *)

(*
 * Immutable queue implementation. Modeled loosely after the mutable stdlib
 * Queue. push, pop, etc. are amortized O(1).
 *)

type 'a t

exception Empty

val empty: 'a t

val push: 'a t -> 'a -> 'a t

val pop: 'a t -> ('a option * 'a t)

(* Raises Empty if the queue is empty *)
val pop_unsafe: 'a t -> ('a * 'a t)

val is_empty: 'a t -> bool

val length: 'a t -> int

val iter: 'a t -> f:('a -> unit) -> unit
