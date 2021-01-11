#load "btree.cmo";;
#load "bst.cmo";;
open Bst;;
open Btree;;
#show Bst;;
#show Btree;;

(* =========================================================================================== *)
(* ======================================== Exercice 1 ======================================= *)
(* =========================================================================================== *)


(* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ (1) ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ *)

let bst_rnd_create(bound, treeSize : int * int) : int bst =

  Random.self_init();

  let empty_tree : int bst = empty() in
  let randABR : int bst ref = ref empty_tree in
  
  for i=1 to treeSize do
    let randInt : int = Random.int bound in
    randABR := bst_linsert(!randABR, randInt);
  done;

  !randABR
;;

show_int_btree(bst_rnd_create(100, 10));;

(* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ *)




let isLeaf(tree: 'a t_btree) : bool =
  isEmpty(lson(tree)) && isEmpty(rson(tree))
;;

let max(a, b : int * int) : int =

  if(a > b)
  then a

  else b
;;

let rec height(tree : 'a t_btree) : int =

  if(isEmpty(tree) || isLeaf(tree))
  then 0

  else
    (
      let l : 'a t_btree = lson(tree) in
      let r : 'a t_btree = rson(tree) in
      1 + max(height(l), height(r))
    )
;;

let desequilibre(tree : 'a t_btree) : int =
  height(lson(tree)) - height(rson(tree))
;;


(* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ (2) ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ *)

let avgDesequilibre(sampleSize, treeSize : int * int) : float =

  let sum : float ref = ref 0. in

  for i=1 to sampleSize do
    sum := !sum +. float_of_int(desequilibre(bst_rnd_create(100, treeSize)))
  done;

  !sum /. float_of_int(sampleSize)
;;

avgDesequilibre(1000, 10);;

(* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ *)




let rec size(tree : 'a t_btree) : int =

  if(isEmpty(tree))
  then 0

  else
    (
      let l : 'a t_btree = lson(tree) in
      let r : 'a t_btree = rson(tree) in
      1 + size(l) + size(r);
    )
;;

(* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ (3) ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ *)

let createSeries(len : int) : int list =

  Random.self_init();

  if(len<=0)
  then
    (
      let randLowerBound : int = Random.int 1000 in
      let res : int list ref = ref [] in

      for i=1 to Random.int 100 do
        res := (randLowerBound+(i-1))::!res
      done;

      !res
    )

  else
    (
      let randLowerBound : int = Random.int 1000 in
      let res : int list ref = ref [] in

      for i=1 to len do
        res := (randLowerBound+(i-1))::!res
      done;

      !res
    )
;;


let bst_rndSeries_create(treeSize, seriesLen : int * int) : int bst =

  Random.self_init();

  let empty_tree : int bst = empty() in
  let randABR : int bst ref = ref empty_tree in
  let deltaSizes : int ref = ref treeSize in

  while(!deltaSizes != 0) do
    let rndSeries : int list = createSeries(seriesLen) in

    for i=0 to List.length(rndSeries)-1 do
      if(!deltaSizes > 0)
      then (
        randABR := bst_linsert(!randABR, List.nth rndSeries i);
        deltaSizes := !deltaSizes - 1;
      )
    done;

  done;

  !randABR
;;

let avgSeriesDesequilibre(sampleSize, treeSize, seriesLenMode : int * int * char) : float =

  let sum : float ref = ref 0. in

  for i=1 to sampleSize do
    match seriesLenMode with
    | 'r' -> sum := !sum +. float_of_int(desequilibre(bst_rndSeries_create(treeSize, -1)))
    | 'f' -> sum := !sum +. float_of_int(desequilibre(bst_rndSeries_create(treeSize, 10)))
    | 'a' -> sum := !sum +. float_of_int(desequilibre(bst_rndSeries_create(treeSize, 1+i)))
    | 'd' -> sum := !sum +. float_of_int(desequilibre(bst_rndSeries_create(treeSize, sampleSize-i)))
    | _ -> failwith("Wrong mode for series length... 'r' for random lengths, 'f' for fixed lengths, 'a' for ascending lengths, and 'd' for descending lengths."); 
  done;

  !sum /. float_of_int(sampleSize)
;;


(*show_int_btree(bst_rndSeries_create(100, 100));;
desequilibre(bst_rndSeries_create(10, 1));;*)
avgSeriesDesequilibre(1000, 100, 'r');;
avgSeriesDesequilibre(1000, 100, 'f');;
avgSeriesDesequilibre(1000, 100, 'a');;
avgSeriesDesequilibre(1000, 100, 'd');;
avgSeriesDesequilibre(1000, 100, 'e');;
(* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ *)




(* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ (4) ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ *)

(* 
   Compte-rendu d'expérimentation : 
   https://fr.overleaf.com/project/5ffc59b4685334742908ab9d 
 *)

(* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ *)
