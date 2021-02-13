#include "financierIndice.ligo"

type value is record [ x : int ]

type storage is record [
    func : (value)->value;
    response: bool;
    financierIndiceContract : address
    //result_execute: 
]

type entryPoints is 
    | DemandeAvisAuConseiller of int
    | ReceptionValeurIndice of bool
    | ChangerAlgorithm of (value)->value

function demandeAvisAuConseiller(const s :storage) : int is block {
    var txs : list(operation) := list end;

    const fic : option(contract(action)) = Tezos.get_contract_opt(s.financierIndiceContract);
    const destination : contract(action) = case fic of 
    | None -> (failwith("This contract doesn t exist !"):contract(action))
    | Some(c) -> c
    end;

    const op : operation = Tezos.transaction(DemandeValeur , 0tz, destination);
    txs := op # txs;
}with (txs ,s)

//function receptionValeurIndice(const lambda:(value)->value; const s: storage) : return is block{ skip }with s

function receptionValeurIndice(const lambda:(value)->value; const s: storage) : bool is block{
    s.response := lambda;
}with s.response

function changerAlgorithm(const lambda:(value)->value; const s : storage): storage is
block{
    test := 0;
    //if fund_value < 10 && fund_value > 2 then 
        //block {

        //}
    //else skip;
}with s

//function execute( const s : storage) : return is block {
    //var txs : list(operation) := list end;
    //const exist : option(proposal) = s.proposals[name];
    //case exist of
    //| None -> failwith("This proposal doesn't exist !")
    //| Some(x) -> 
        //block {
            //const cc : option(contract(action)) = Tezos.get_contract_opt(s.counterContract);
            //const destination : contract(action) = case cc of 
            //| None -> (failwith("This contract doesn't exist !"):contract(action))
            //| Some(cont) -> cont
            //end;
            //const op : operation = Tezos.transaction(x.action, 0tz, destination);
            //txs := op # txs;
        //}
    //end
//} with s


function main (const p : entryPoints; const s: storage) : (list(operation) * storage) is
block { 
    const x : return = case p of
    | DemandeAvisAuConseiller(n) -> demandeAvisAuConseiller(s)
    | ReceptionValeurIndice(n) -> receptionValeurIndice(n, s)
  end;
} with x

// ligo compile-contract financialConsultant.ligo main
// ligo dry-run financialConsultant.ligo main 'Algortithm(function(const:f value): value is record[x:100])' 'record[func=(function(const v: value):value is record[x:10])]'
