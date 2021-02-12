#include "counter.ligo"

type proposal is record [
    proposer : address;
    action : action
]

type proposals is  map (string, proposal)

type storage is record [
    proposals : proposals;
    counterContract : address
]

type return is (list(operation) * storage)

type createProposalParameter is record [
    name : string;
    proposal : proposal
]

type algorithmParameter is int
type action is Algorithm of algorithmParameter

function algorithm(const lambda: int; const s: storage): storage is block{
    
}with //int

function executeRequest() : storage is block{

    //return result_execute
}with s

function execute( const s : storage) : return is block {
    var txs : list(operation) := list end;
    const exist : option(proposal) = s.proposals[name];
    case exist of
    | None -> failwith("This proposal doesn't exist !")
    | Some(x) -> 
        block {
            const cc : option(contract(action)) = Tezos.get_contract_opt(s.counterContract);
            const destination : contract(action) = case cc of 
            | None -> (failwith("This contract doesn't exist !"):contract(action))
            | Some(cont) -> cont
            end;
            const op : operation = Tezos.transaction(x.action, 0tz, destination);
            txs := op # txs;
        }
    end
} with s


function main (const action : parameter; const s: storage) : return is
block { skip } with case action of
    Algorithm(x) -> algorithm (x,s)
  end
