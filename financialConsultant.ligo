#include "financierIndice_type.ligo"
#include "financialConsultant_type.ligo"

// Compile --> ligo compile-parameter financierIndice.ligo main 'DemandeAvisAuConseiller()'
function demandeAvisAuConseiller(const s : storage) : return is block {
    const proposed_destination : contract(action) = get_contract(financialIndiceContractAddress);
    const proposedTransaction: operation = Tezos.transaction(DemandeValeur(0), 0tz, proposed_destination);

    const txs : list(operation) = list 
        proposedTransaction
    end;

}with (txs, s)


function receptionValeurIndice(const indice_value: int; const s: storage) : return is block{
    s.response := s.func(indice_value);
}with ((nil : list(operation)), s)

//if value < 10 then s.response := True else s.response := False
function changerAlgorithm(const lambda:(value)->bool; const s : storage): return is block{
    s.func := lambda;
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
