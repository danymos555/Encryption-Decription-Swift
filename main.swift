//
//  main.swift
//  Encryption
//
//  Created by Daniela Moscoso on 01/11/24.
//

import Foundation

typealias OTPKey = [UInt8]
typealias OTPKeyPair = (key1: OTPKey, key2: OTPKey)

//Function to generate random One-time-pad key
func randomOTPKey(lenght: Int) -> OTPKey {
    var randomKey: OTPKey = OTPKey() // Initialiazing an empty key
    
    for _ in 0..<lenght{
        let RandomKeyPoint = UInt8(arc4random_uniform(UInt32(UInt8.max)))
        randomKey.append(RandomKeyPoint)
    }
    
    return randomKey
}
            
//function to create product key and perform xor operation
func encryptOTP(original: String) -> OTPKeyPair{
    let dummy = randomOTPKey(lenght: original.utf8.count)
    //Calls randomOTPKey to generate a random key of the same length as the UTF-8 representation of the original string.
    
    let encrypted: OTPKey = dummy.enumerated().map { i, e in
        return e ^ original.utf8[original.utf8.index(original.utf8 .startIndex, offsetBy: i)]
    }
    
    return (dummy, encrypted)
}


func decryptOTP(keyPair: OTPKeyPair) -> String? {
    let decrypted: OTPKey = keyPair.key1.enumerated().map {
        i, e in e ^ keyPair.key2[i]
    }
    
    return String(bytes: decrypted, encoding: String.Encoding.utf8)
}

let encrypted = encryptOTP(original: "¡Vamos Swift!")
print(encrypted.0, "This is the dummy key")
print(encrypted.1, "This is the encrypted key")// printing encrypted key2
print(decryptOTP(keyPair: encrypted) ?? "", "This is the original message")//Encrypting and decrypting "Vamos Swift" message
