(*#directory "/home/crex/MEGA/Bureau/Etudes/UE1_AP/#/Les\ fichiers\ bytecode\ des\ modules-20201110/4.08.1";;*)
#directory "./";;
#load "bst.cmo";;
open Bst;;
#show Bst;;

(*~~~~~~~~~~~~~~~~~~~~~~~~~ Ex. ~~~~~~~~~~~~~~~~~~~~~~~~~*)

let bst1 : 'a t_btree = rooting(4,
                                rooting(2,
                                        rooting(1, empty(), empty()),
                                        rooting(3, empty(), empty())
                                  ),
                                rooting(6,
                                        rooting(5, empty(), empty()),
                                        rooting(7, empty(), empty())
                                  )
                          );;

let bst2 : 'a t_btree = rooting(5,
                                rooting(3,
                                        rooting(2,
                                                rooting(1, empty(), empty()),
                                                empty()
                                          ),
                                          rooting(4, empty(), empty())
                                  ),
                                rooting(6, empty(), empty())
                          );;

let t1 : 'a t_btree = rooting(1,
                              rooting(2, empty(), empty()),
                              rooting(3, empty(), empty())
                        );;

let empty_t : 'a t_btree = empty();;

(*~~~~~~~~~~~~~~~~~~~~~~~~~ (1) ~~~~~~~~~~~~~~~~~~~~~~~~~*)

(*let rec bst_seek(t, e : 'a t_btree * 'a) : bool =

  if(isEmpty(t))
  then false

  else
    (
      let v : 'a = root(t) in
      let l : 'a t_btree = lson(t) in
      let r : 'a t_btree = rson(t) in
      
      if(e = v)
      then true
      
      else if(e > v)
      then bst_seek(r, e)

      else
        (
          bst_seek(l, e)
        )
    )
;;*)

(* type 'a bst = 'a t_btree ;; *)

(*let rec bst_seek(b,v : 'a bst * 'a) : 'a bst =

  if(isEmpty(b))
  then b

  else
    (
      let (r,fg,fd) : ('a * 'a bst * 'a bst) = (root(b),lson(b),rson(b))
      in

      if(v = r)
      then b

      else if(v < r)
      then bst_seek(fg, v)

      else bst_seek(fd, v)
    )
;;*)


(* ============ *)
(* TESTING ZONE *)
(* ============ *)

bst_seek(bst1, 4);;
bst_seek(bst1, 3);;
bst_seek(bst1, 7);;
bst_seek(bst1, 8);;

bst_seek(bst2, 5);;
bst_seek(bst2, 3);;
bst_seek(bst2, 1);;
bst_seek(bst2, 8);;

bst_seek(t1, 1);;
bst_seek(t1, 3);;
bst_seek(t1, 2);;
bst_seek(t1, 8);;

(* ============ *)
(* ============ *)
(* ============ *)


(*let rec bst_linsert(t, e : 'a t_btree * 'a) : 'a t_btree =

  if(isEmpty(t))
  then rooting(e, empty(), empty())

  else
    (
      let v : 'a = root(t) in
      let l : 'a t_btree = lson(t) in
      let r : 'a t_btree = rson(t) in
      
      if(e <= v)
      then
        (
          rooting(v, bst_linsert(l, e), r)
        )

      else
        (
          rooting(v, l, bst_linsert(r, e))
        )
    )
;;*)

(*let rec bst_linsert(b, v : 'a bst * 'a) : 'a bst =

  if(isEmpty(b))
  then rooting(v,empty(),empty())

  else
    (
      let (r,fg,fd) : ('a * 'a bst * 'a bst) = (root(b),lson(b),rson(b))
      in

      if(v <= r)
      then rooting(r, bst_linsert(fg,v), fd)

      else rooting(r, fg, bst_linsert(fd,v))
    )
;;*)

(* ============ *)
(* TESTING ZONE *)
(* ============ *)

show_int_btree(bst_linsert(bst1, 8));;
show_int_btree(bst_linsert(bst1, 3));;
show_int_btree(bst_linsert(bst1, 9));;
show_int_btree(bst_linsert(bst1, 10));;

show_int_btree(bst_linsert(bst2, 5));;
show_int_btree(bst_linsert(bst2, 11));;
show_int_btree(bst_linsert(bst2, 9));;
show_int_btree(bst_linsert(bst2, 0));;

show_int_btree(bst_linsert(empty_t, 1));;

show_int_btree(bst_linsert(t1, 10));;
show_int_btree(bst_linsert(t1, 3));;
show_int_btree(bst_linsert(t1, 0));;
show_int_btree(bst_linsert(t1, 4));;

(* ============ *)
(* ============ *)
(* ============ *)


(*let rec bst_lbuild_aux(l, t : 'a list * 'a t_btree) : 'a t_btree =

  if(l = [])
  then t

  else
    (
      let e : 'a = List.hd(l) in
      let new_l : 'a list = List.tl(l) in
      
      bst_lbuild_aux(new_l, bst_linsert(t, e))
    )
;;

let bst_lbuild(l : 'a list) : 'a t_btree =

  if(l = [])
  then empty()

  else
    (
      let res : 'a t_btree = empty() in
      bst_lbuild_aux(l, res)
    )
;;*)

let bst_lbuild (l : 'a list) =
  
  let rec build_rec(l,t : 'a list * 'a bst) =
    match l with
    | [] -> t
    | hd::tl -> build_rec(tl, bst_linsert(t,hd))
  in

  build_rec(l,empty())
;;



(* ============ *)
(* TESTING ZONE *)
(* ============ *)


let l1 : int list = [];;
let l2 : int list = [1; 2; 3; 4; 5; 6; 7; 8];;
let l3 : int list = [2; 1; 8; 3; 6; 4; 7; 5];;
let l4 : int list = [5; 2; 7; 4; 1; 6; 3; 8];;
let l5 : int list = [8; 7; 6; 5; 4; 3; 2; 1];;

show_int_btree(bst_lbuild(l1));;
show_int_btree(bst_lbuild(l2));;
show_int_btree(bst_lbuild(l3));;
show_int_btree(bst_lbuild(l4));;
show_int_btree(bst_lbuild(l5));;

(* ============ *)
(* ============ *)
(* ============ *)


(* let rec bst_delete(t, e : 'a t_btree * 'a) : 'a t_btree =

  if(isEmpty(t))
  then empty()

  else
    (
      let v : 'a = root(t) in
      let l : 'a t_btree = lson(t) in
      let r : 'a t_btree = rson(t) in

      if(e = v)
      then
        (
          empty()
        )

      else if(e < v)
      then
        (
          rooting(v, bst_delete(l, e), r)
        )

      else
        (
          rooting(v, l, bst_delete(r, e))
        )
    )
;;*)

(*let isLeaf(t : 'a t_btree) : bool =
  isEmpty(lson(t)) && isEmpty(rson(t))
;;

(* Inspiré de la table de vérité du XOR: *)
let isOneSubTree(t : 'a t_btree) : bool =

  if(isEmpty(t))
  then false

  else
    (
      let a : 'a t_btree = lson(t) in
      let b : 'a t_btree = rson(t) in

      ((not(isEmpty(a)) && isEmpty(b)) || (isEmpty(a) && not(isEmpty(b))))
    )
;;

let rec get_max(t : 'a t_btree) : 'a =

  if(isEmpty(t))
  then failwith("Tree is empty, can't search value in it")

  else if(isEmpty(rson(t)))
  then root(t)

  else
    (
      get_max(rson(t))
    )
;;

let rec bst_delete(t, e : 'a t_btree * 'a) : 'a t_btree =

  if(isEmpty(t))
  then empty()

  else
    (
      let v : 'a = root(t) in
      let l : 'a t_btree = lson(t) in
      let r : 'a t_btree = rson(t) in

      if(e = v)
      then
        (
          if(isLeaf(t))
          then empty()

          else if(isOneSubTree(t))
          then
            (
              if(isEmpty(l))
              then r

              else l
            )

          else
            (
              let max : 'a = get_max(l) in
              rooting(max, bst_delete(l, max), r)
            )
        )

      else if(e < v)
      then
        (
          rooting(v, bst_delete(l, e), r)
        )

      else
        (
          rooting(v, l, bst_delete(r, e))
        )
    )
;;*)

(*
let rec bst_delete(t, v : 'a bst * 'a) : 'a bst * bool =
  
  if isEmpty(t)
  then (t, false)

  else
    
    let (r, lst, rst) : 'a * 'a bst * 'a bst = (root(t), lson(t), rson(t))
    in
    
    if v < r
    then
      let (newlst, found) : 'a bst * bool = bst_delete(lst, v)
      in
      (rooting(r, newlst, rst), found)

    else if v > r
    then
      let (newrst, found) : 'a bst * bool = bst_delete(rst, v)
      in
      (rooting(r, lst, newrst), found)
      
    else (bst_delete_root(r, lst, rst), true)
;;


let bst_delete_root(r, lst, rst : 'a * 'a bst * 'a bst) : 'a bst =
  
  if isEmpty(lst)
  then
    if isEmpty(rst)
    then empty()
    else rst

  else if isEmpty(rst)
  then lst

  else
    let (newr, newlst) : 'a * 'a bst = bst_delete_max(lst)
    in
    rooting(newr, newlst, rst)
;;


let rec bst_delete_max(t : 'a bst) : 'a * 'a bst =
  
  if isEmpty(rson(t))
  then (root(t), lson(t))
  
  else
    let (v, newrst) : 'a * 'a bst = bst_delete_max(rson(t))
    in
    (v, rooting(root(t), lson(t), newrst))
;;
*)


(* ============ *)
(* TESTING ZONE *)
(* ============ *)

show_int_btree(bst_delete(bst1, 8));;
show_int_btree(bst_delete(bst1, 3));;
show_int_btree(bst_delete(bst1, 2));;
show_int_btree(bst_delete(bst1, 1));;

show_int_btree(bst_delete(bst2, 5));;
show_int_btree(bst_delete(bst2, 1));;
show_int_btree(bst_delete(bst2, 9));;
show_int_btree(bst_delete(bst2, 4));;

show_int_btree(bst_delete(empty_t, 1));;

show_int_btree(bst_delete(t1, 2));;
show_int_btree(bst_delete(t1, 3));;
show_int_btree(bst_delete(t1, 1));;
show_int_btree(bst_delete(t1, 4));;

(* ============ *)
(* ============ *)
(* ============ *)

let rec bst_isBstaux(t : 'a bst) : 'a * 'a * bool =
  
  let (r, g, d) : 'a * 'a bst * 'a bst = (root(t), lson(t), rson(t)) in

  if(isEmpty(g))
  then
    (
      if(isEmpty(d))
      then (r, r, true)

      else
        (
          let (min, max, b) : 'a * 'a * bool = bst_isBstaux(d)
          in (r, max, (r <= min) && b)
        )
    )

  else if(isEmpty(d))
  then
    (
      let (min, max, b) : 'a * 'a * bool = bst_isBstaux(g)
      in (min, r, (max <= r) && b)
    )

  else
    (
      let (ming, maxg, bg) : 'a * 'a * bool = bst_isBstaux(g)
      and (mind, maxd, bd) : 'a * 'a * bool = bst_isBstaux(d)
      in (ming, maxd, (maxg <= r) && (r <= mind) && bg && bd)
    )
;;


let rec bst_isBst(t : 'a bst) : bool =
  if( isEmpty(t) )
  then true

  else let (min, max, isbst) : 'a * 'a * bool = bst_isBstaux(t) in isbst
;;


bst_isBst(bst1);;
bst_isBst(bst2);;
bst_isBst(t1);;
bst_isBst(empty_t);;
