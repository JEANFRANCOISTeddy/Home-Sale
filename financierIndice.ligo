#include "financierIndice_type.ligo"
#include "financialConsultant_type.ligo"

// Compile --> ligo compile-parameter financierIndice.ligo main 'Increment(5)'
// Test --> ligo dry-run financierIndice.ligo main 'Increment(1)' 'record[fund_value=10; financialConsultantContract="tz1TGu6TN5GSez2ndXXeDX6LgUDvLzPLqgYV"]'
function add (const i : indice_storage ; const b : int) : int is
  block { skip } with i.fund_value + b

// Compile --> ligo compile-parameter financierIndice.ligo main 'Decrement(5)'
// Test --> ligo dry-run financierIndice.ligo main 'Decrement(1)' 'record[fund_value=10; financialConsultantContract="tz1TGu6TN5GSez2ndXXeDX6LgUDvLzPLqgYV"]'
function subtract (const i : indice_storage ; const b : int) : int is
  block { skip } with i.fund_value - b

// Compile --> ligo compile-parameter financierIndice.ligo main 'DemandeValeur(5)'
// Test --> ligo dry-run financierIndice.ligo main 'DemandeValeur(5)' 'record[fund_value=10]'
function demandeValeur (const i : indice_storage) : int is block {
  const fcc : option(contract(entryPoints)) = Tezos.get_entrypoint_opt("%receptionValeurIndice", financialConsultantContractAddress);
  const destination : contract(entryPoints) = case fcc of 
  | None -> (failwith("Entrypoint ReceptionValeurIndice not found in contract financialConsultant"):contract(entryPoints))
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
    | DemandeValeur(n) -> demandeValeur(i)
    end;
    i.fund_value := ret;
  } with ((nil : list(operation)), i)

// ligo compile-contract financierIndice.ligo main
