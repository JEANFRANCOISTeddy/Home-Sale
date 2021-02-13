#include "financierIndice_type.ligo"
#include "financialConsultant_type.ligo"

function demandeAvisAuConseiller(const s :storage) : return is block {
    const fic : option(contract(action)) = Tezos.get_contract_opt(s.financierIndiceContract);
    const destination : contract(action) = case fic of 
    | None -> (failwith("This contract doesn t exist !"):contract(action))
    | Some(c) -> c
    end;

    const proposed_destination : contract(action) = get_contract(destination);
    const proposedTransaction: operation = Tezos.transaction(DemandeValeur, 0tz, destination);

    const txs : list(operation) = list 
        proposedTransaction
    end;

}with (txs, s)

function receptionValeurIndice(const lambda:(value)->bool; const s: storage) : bool is block{
    const result_execute: int = s.fund_value;
}with result_execute

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
    | ChangerAlgorithm(n) -> changerAlgorithm(n, s)
  end;
} with x

// ligo compile-contract financialConsultant.ligo main
// ligo dry-run financialConsultant.ligo main 'Algortithm(function(const:f value): value is record[x:100])' 'record[func=(function(const v: value):value is record[x:10])]'
