(**
 * Copyright (c) 2017, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the "hack" directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 *
 *)

(* A line break map is created for a given string. It contains the offsets (in
 * said string) of the first character of a line (i.e. the offset after a line
 * break) allowing binary search from an offset to a line number (the index in
 * the map itself + 1).
 *)
type t

(* Creates a line break map from/for the given string. *)
val make : string -> t

(* Take a zero-based offset, produce a one-based (line, column) pair.
 *
 * When cyclic_index is set, negative offsets are taken from the end, i.e. -1
 * points to the last position in the original string. For a string of length l,
 * an offset x where x < -l defaults to offset 0, i.e. offsets only wrap around\
 * once.
 *)
val offset_to_position : ?cyclic_index:bool -> t -> int -> int * int

(* Take a one-based (line, column) pair, produce a zero-based offset.
 *
 * By setting existing to true (it's false by default), Not_found is raised for
 * a position outside of the range of valid line/column numbers from the
 * original string.
 *
 * Setting cyclic_index translates negative line numbers as offsets from the
 * last line in the original string. Without cyclic_index, Invalid_argument is
 * raised with an array-out-of-bounds message.
 *)
val position_to_offset :
  ?cyclic_index:bool -> ?existing:bool -> t -> int * int -> int

(* Does what it says on the tin. *)
val offset_to_line_start_offset : ?cyclic_index:bool -> t -> int -> int
