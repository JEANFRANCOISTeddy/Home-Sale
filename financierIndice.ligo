#include "financierIndice_type.ligo"
#include "financialConsultant_type.ligo"

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

function demandeValeur (const s : storage) : return is block {
  const fcc : option(contract(entryPoints)) = Tezos.get_entrypoint_opt("%receptionValeurIndice", s.financialConsultantContract);
  const destination : contract(entryPoints) = case fcc of 
  | None -> (failwith("Entrypoint not found in contract financialConsultant"):contract(entryPoints))
  | Some(c) -> c
  end;

  const sendbackOperation: operation = Tezos.transaction(ReceptionValeurIndice, 0tz, destination);

  const txs : list(operation) = list 
    sendbackOperation
  end;
}with txs

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
