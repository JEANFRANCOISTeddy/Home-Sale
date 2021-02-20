type indice_storage is record 
    admin : address;
    fund_value : int;
    
    //address hors du storage
    financialConsultantContract : address
end 

type action is
| Increment of int
| Decrement of int
| Reset of unit
| DemandeValeur of unit
