#include "financierIndice.ligo"

type value is record [ x : int ]

type storage is record [
    func : (value)->value;
    response: bool;
    financierIndiceContract : address
    //result_execute: 
]

//type parameter is Algorithm of (value)->value

type parameter is 
    | DemandeAvisAuConseiller of unit
    | ReceptionValeurIndice of bool

function demandeAvisAuConseiller(const s :storage) : int is block {
    var txs : list(operation) := list end;

    const fic : option(contract(action)) = Tezos.get_contract_opt(s.financierIndiceContract);
    const destination : contract(action) = case fic of 
    | None -> (failwith("This contract doesn t exist !"):contract(action))
    | Some(c) -> c
    end;

    const op : operation = Tezos.transaction(demandeValeur , 0tz, destination);
    txs := op # txs;

} with (txs, s)

function receptionValeurIndice(const lambda:(value)->value; const s: storage) : bool is block{
    //variable pour pas que la fonction reste vide
    test := 0;

    //reçoit fund_value
    //vérifier si fund_value < 10 
    //alors Vrai 

    //sinon Faux
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


function main (const action : parameter; const s: storage) : return is
block { 
    const x : return = case p of
    | DemandeAvisAuConseiller(x) -> demandeAvisAuConseiller(s)
    | ReceptionValeurIndice(x) -> receptionValeurIndice(x, s)
  end;
} with x

// ligo compile-contract financialConsultant.ligo main
// ligo dry-run financialConsultant.ligo main 'Algortithm(function(const:f value): value is record[x:100])' 'record[func=(function(const v: value):value is record[x:10])]'
