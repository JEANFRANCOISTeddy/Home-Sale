type storage is record 
    admin : address;
    fund_value : int;
end 

type action is
| Increment of int
| Decrement of int
| Reset of unit
| DemandeValeur of unit

function add (const s : storage ; const b : int) : int is
  block { skip } with s.fund_value + b

function subtract (const s : storage ; const b : int) : int is
  block { skip } with s.fund_value - b

function reset (const s : storage) : int is
  block { 
      if 
        Tezos.sender =/= s.admin
      then
        failwith("Vous n avez pas les droits")
      else
        skip 
   } with 0

function demandeValeur (const s : storage) : int is
  block { skip } with s.fund_value

function main (const p : action ; const s : storage) : list(operation) * storage is
  block { 
    const ret : int = case p of
    | Increment(n) -> add(s, n)
    | Decrement(n) -> subtract(s, n)
    | Reset(n) -> reset(s)
    | DemandeValeur(n) -> demandeValeur(s)
    end;
    s.fund_value := ret;
  } with ((nil : list(operation)), s)

// ligo compile-contract financierIndice.ligo main
