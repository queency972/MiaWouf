//
//  Pet.swift
//  Miawouf
//
//  Created by Steve Bernard on 16/01/2020.
//  Copyright © 2020 Steve Bernard. All rights reserved.
//

import Foundation

struct Pet {
    // Enum normale
    enum Gender {
        case male, female
    }

    var name: String?
    var hasMajority: Bool
    var phone: String?
    var race: String?
    var gender: Gender
}

// Extension permet d'etendre la classe.
extension Pet {
    // Enum avec valeur assosciée.
    enum Status {
        case accepted, rejected(String)
    }
    
    // Enumeration des cas "Status"
    var status: Status {
        if name == nil || name == "" {
            return .rejected("Vous n'avez pas indiqué votre nom !")
        }
        if phone == nil || phone == "" {
            return .rejected("Vous n'avez pas indiqué votre téléphone !")
        }
        if race == nil || race == "" {
            return .rejected("Quel est votre race ?")
        }
        if !hasMajority {
            return .rejected("Les mineurs ne sont pas admis.")
        }
        return .accepted
    }
}
