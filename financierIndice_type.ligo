type indice_storage is record 
    admin : address;
    fund_value : int;
    financialConsultantContract : address
end 

type return is (list(operation) * indice_storage)

type action is
| Increment of int
| Decrement of int
| Reset of unit
| DemandeValeur of unit
