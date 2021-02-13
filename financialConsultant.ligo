#include "financierIndice.ligo"

//type value is record [ x : int ]

type storage is record [
    //func : (value)->value;
    //response: bool,
    financierIndiceContract : address
    //result_execute: 
]

//type parameter is Algorithm of (value)->value

type parameter is DemandeAvisAuConseiller of unit

function demandeAvisAuConseiller(const s :storage) : int is block {
    const fic : option(contract(action)) = Tezos.get_contract_opt(s.financierIndiceContract);
    const destination : contract(action) = case fic of 
    | None -> (failwith("This contract doesn't exist !"):contract(action))
    | Some(c) -> c
    end;

    Tezos.transaction(demandeValeur , 0tz, destination);

} with s

//function ReceptionValeurIndice(const lambda:(value)->value, const s: storage): storage is block{
    
//}with s

//function executeRequest() : storage is block{

//}with s

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
block { skip } with case action of
    DemandeAvisAuConseiller(x) -> demandeAvisAuConseiller(s)
  end

// ligo compile-contract financialConsultant.ligo main
// ligo dry-run financialConsultant.ligo main 'Algortithm(function(const:f value): value is record[x:100])' 'record[func=(function(const v: value):value is record[x:10])]'
