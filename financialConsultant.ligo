#include "financierIndice_type.ligo"
#include "financialConsultant_type.ligo"

function demandeAvisAuConseiller(const s :storage) : return is block {
    const proposed_destination : contract(action) = get_contract(s.financierIndiceContract);
    const proposedTransaction: operation = Tezos.transaction(DemandeValeur, 0tz, proposed_destination);

    const txs : list(operation) = list 
        proposedTransaction
    end;

}with (txs, s)

function receptionValeurIndice(const indice_value: int; const s: storage) : return is block{
    s.response := s.func(indice_value);
    //const result_execute : int = receptionValeurIndice(value);
}with ((nil : list(operation)), s)

function changerAlgorithm(const lambda:(value)->bool; const s : storage): return is block{
    s.func := lambda;
    //if fund_value < 10 && fund_value > 2 then 
        //block {

        //}
    //else skip;
}with ((nil : list(operation)), s)

function main (const p : entryPoints; const s: storage) : (list(operation) * storage) is
block { 
    const x : return = case p of
    | DemandeAvisAuConseiller(n) -> demandeAvisAuConseiller(s)
    | ReceptionValeurIndice(n) -> receptionValeurIndice(n, s)
    | ChangerAlgorithm(n) -> changerAlgorithm(n, s)
    end;
} with ((nil : list(operation)), s)

// ligo compile-contract financialConsultant.ligo main
// ligo dry-run financialConsultant.ligo main 'Algortithm(function(const:f value): value is record[x:100])' 'record[func=(function(const v: value):value is record[x:10])]'

//if value < 10 then s.response := True else s.response := False
