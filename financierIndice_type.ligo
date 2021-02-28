type indice_storage is record 
    fund_value : int;
    //address hors du storage
    //financialConsultantContract : address
end 

const financialConsultantContractAddress : address =("tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx" : address)

type action is
| Increment of int
| Decrement of int
| DemandeValeur of int
