type storage is record 
    admin : address;
    count : int;
end 

type action is
| Increment of int
| Decrement of int
| Reset of unit

function add (const a : storage ; const b : int) : int is
  block { skip } with a.count + b

function subtract (const a : storage ; const b : int) : int is
  block { skip } with a.count - b

function reset (const s : storage) : int is
  block { 
      if 
        Tezos.sender =/= s.admin
      then
        failwith("Vous n'avez pas les droits")
      else
        skip 
   } with 0

function main (const p : action ; const s : storage) : list(operation) * storage is
  block { 
    const ret : int = case p of
    | Increment(n) -> add(s, n)
    | Decrement(n) -> subtract(s, n)
    | Reset(n) -> reset(s)
    end;
    s.count := ret;
  } with ((nil : list(operation)), s)

// ligo compile-contract counter.ligo main