import UIKit


let someClosure: (String, String) -> Bool =
{ (s1: String, s2: String) -> Bool in
    let isAscending: Bool
    if s1 > s2 {
        isAscending = true
    } else {
        isAscending = false
    }
    return isAscending
}

// some closure is closure 
// string,string -> boll

let someClosure =
{
    
}
