#include "counter.ligo"

type value is record [ x : int ]

type storage is record [
    func : (value)->value;
    result_execute: 
]

type parameter is Algorithm of (value)->value

function algorithm(const lambda:(value)->value, const s: storage): storage is block{
    
}with s

function executeRequest() : storage is block{

}with s

function main (const action : parameter; const s: storage) : return is
block { skip } with case action of
    Algorithm(x) -> algorithm (x,s)
  end

// ligo compile-contract XXX2.ligo main
// ligo dry-run XXX.ligo main 'Algortithm(function(const:f value): value is record[x:100])' 'record[func=(function(const v: value):value is record[x:10])]'