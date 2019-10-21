//
//  ImageDictionnary.swift
//  ImageDetection-JPO
//
//  Created by Robin Champsaur on 28/06/2018.
//  Copyright © 2018 Robin Champsaur. All rights reserved.
//

import Foundation
import ARKit

class ImageDictionnary {
    
    var dictionnary: [String: String]
    
    init() {
        dictionnary = [String: String]()
        getElements(ressourceFolder: Constants.ARReference.folderName)
    }
    
    func getElements(ressourceFolder: String) {
        guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: ressourceFolder, bundle: nil) else {
            fatalError("Missing expected asset catalog resources")
        }
        
        for im in referenceImages {
            if let name = im.name {
                dictionnary[name] = configDisplayName(xcodeName: name)
            }
        }
    }
    
    func configDisplayName(xcodeName: String) -> String {
        if xcodeName.lowercased().range(of: "under") != nil {
            return "Under"
        } else if xcodeName.lowercased().range(of: "3ie-") != nil {
            return "Le lab 3IE"
        } else if xcodeName.lowercased().range(of: "android") != nil {
            return "Android"
        } else if xcodeName.lowercased().range(of: "figurine") != nil {
            return "Pôle iOS"
        } else if xcodeName.lowercased().range(of: "design") != nil {
            return "Pôle Design"
        } else if xcodeName.lowercased().range(of: "web") != nil {
            return "Pôle Web"
        } else {
            return xcodeName
        }
    }
}
