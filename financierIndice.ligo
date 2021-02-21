#include "financierIndice_type.ligo"
#include "financialConsultant_type.ligo"

function add (const i : indice_storage ; const b : int) : int is
  block { skip } with i.fund_value + b

function subtract (const i : indice_storage ; const b : int) : int is
  block { skip } with i.fund_value - b

function reset (const i : indice_storage) : int is
  block { 
      if 
        Tezos.sender =/= i.admin
      then
        failwith("Vous n avez pas les droits")
      else
        skip 
   } with 0

function demandeValeur (const i : indice_storage) : int is block {
  //const financierIndiceAddress : address = ("tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx" : address);
  const fcc : option(contract(entryPoints)) = Tezos.get_entrypoint_opt("%receptionValeurIndice", i.financialConsultantContract);
  const destination : contract(entryPoints) = case fcc of 
  | None -> (failwith("Entrypoint not found in contract financialConsultant"):contract(entryPoints))
  | Some(c) -> c
  end;

  const sendbackOperation: operation = Tezos.transaction(ReceptionValeurIndice(i.fund_value), 0tz, destination);

  const txs : list(operation) = list 
    sendbackOperation
  end;
}with i.fund_value

function main (const p : action ; const i : indice_storage) : list(operation) * indice_storage is block { 
    const ret : int = case p of
    | Increment(n) -> add(i, n)
    | Decrement(n) -> subtract(i, n)
    | Reset(n) -> reset(i)
    | DemandeValeur(n) -> demandeValeur(i)
    end;
    i.fund_value := ret;
  } with ((nil : list(operation)), i)

// ligo compile-contract financierIndice.ligo main
