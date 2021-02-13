type value is int 

type storage is record [
    admin : address;
    func : (value)->bool;
    response: bool;
    financierIndiceContract : address
]

type return is (list(operation) * storage)

type entryPoints is 
    | DemandeAvisAuConseiller of int
    | ReceptionValeurIndice of bool
    | ChangerAlgorithm of (value)->bool
