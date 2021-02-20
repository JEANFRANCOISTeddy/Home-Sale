type value is int 

type storage is record [
    admin : address;
    func : (value)->bool;
    response: bool;

    //address hors du storage
    financierIndiceContract : address
]

type return is (list(operation) * storage)

type entryPoints is 
    | DemandeAvisAuConseiller of int
    | ReceptionValeurIndice of int
    | ChangerAlgorithm of (value)->bool

// ligo compile-contract financialConsultant.ligo main
