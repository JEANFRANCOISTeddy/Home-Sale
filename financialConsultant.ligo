#include "financierIndice.ligo"

type value is record [ x : int ]

type storage is record [
    func : (value)->bool;
    response: bool;
    financierIndiceContract : address
    //result_execute: 
]

type return is (list(operation) * storage)

type entryPoints is 
    | DemandeAvisAuConseiller of int
    | ReceptionValeurIndice of bool
    | ChangerAlgorithm of (value)->bool

function demandeAvisAuConseiller(const s :storage) : return is block {
    var txs : list(operation) := list end;

    const fic : option(contract(action)) = Tezos.get_contract_opt(s.financierIndiceContract);
    const destination : contract(action) = case fic of 
    | None -> (failwith("This contract doesn t exist !"):contract(action))
    | Some(c) -> c
    end;

    const op : operation = Tezos.transaction(DemandeValeur , 0tz, destination);
    txs := op # txs;
}with (txs, s)

//function receptionValeurIndice(const lambda:(value)->bool; const s: storage) : return is block{ skip }with s

function receptionValeurIndice(const lambda:(value)->bool; const s: storage) : bool is block{
    s.response := True;
}with s.response

function changerAlgorithm(const lambda:(value)->bool; const s : storage): storage is
block{
    test := 0;
    //if fund_value < 10 && fund_value > 2 then 
        //block {

        //}
    //else skip;
}with s

function main (const p : entryPoints; const s: storage) : (list(operation) * storage) is
block { 
    const x : return = case p of
    | DemandeAvisAuConseiller(n) -> demandeAvisAuConseiller(s)
    | ReceptionValeurIndice(n) -> receptionValeurIndice(n, s)
    | ChangerAlgorithm(n) -> changerAlgorithm(x, s)
  end;
} with x

// ligo compile-contract financialConsultant.ligo main
// ligo dry-run financialConsultant.ligo main 'Algortithm(function(const:f value): value is record[x:100])' 'record[func=(function(const v: value):value is record[x:10])]'
