//
//  NSObject+Extensions.swift
//  Pokedex
//
//  Created by Charles de Jesus Lima on 05/06/21.
//

import Foundation

extension NSObject {
    
    public class var className: String {
        return String(describing: self)
    }
    
}
