type value is int 

type storage is record [
    func : (value)->bool;
    response: bool;

    //address hors du storage
    //financierIndiceContract : address
]

type return is (list(operation) * storage)

const financialIndiceContractAddress : address =("tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx" : address)

type entryPoints is 
    | DemandeAvisAuConseiller of int
    | ReceptionValeurIndice of int
    | ChangerAlgorithm of (value)->bool
