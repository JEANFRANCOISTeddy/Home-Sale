type storage is record 
    admin : address;
    fund_value : int;
    financialConsultantContract : address
end 

type return is (list(operation) * storage)

type action is
| Increment of int
| Decrement of int
| Reset of unit
| DemandeValeur of unit
