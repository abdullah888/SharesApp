//
//  sharing.swift
//  SharesXC
//
//  Created by abdullah on 09/02/1442 AH.
//

import Foundation
import UIKit

struct sharing {
    var image : UIImage?
    var topText : NSAttributedString?
    var bottomText : NSAttributedString?
    var sharingImage : UIImage?
}

extension sharing {
    static let TopTextKey = "TopTextKey"
    static let BottomTextKey = "BottomTextKey"
    static let OriginalImageNameKey = "OriginalImageNameKey"
    static let sharingImageNameKey = "sharingImageNameKey"
    
    init(dictionary: [String : String]) {
    
        self.topText = NSAttributedString(string: dictionary[sharing.TopTextKey]!)
        self.bottomText = NSAttributedString(string: dictionary[sharing.BottomTextKey]!)
        self.image = UIImage(named: dictionary[sharing.OriginalImageNameKey]!)
        self.sharingImage = UIImage(named: dictionary[sharing.sharingImageNameKey]!)
        
    }
    
    static var testingsharing: [sharing] {
        var SHarrring = [sharing]()
        
        for SH in sharing.loadTestingsharing() {
            SHarrring.append(sharing(dictionary: SH))
        }
        
        return SHarrring
    }
    
    static func loadTestingsharing() -> [[String : String]] {
        return [
            [sharing.TopTextKey : "1Top Text", sharing.BottomTextKey : "Bottom Text", sharing.sharingImageNameKey : "pic1", sharing.OriginalImageNameKey : "pic1"],
            [sharing.TopTextKey : "2Top Text", sharing.BottomTextKey : "Bottom Text", sharing.sharingImageNameKey : "pic2", sharing.OriginalImageNameKey : "pic2"],
            [sharing.TopTextKey : "3Top Text", sharing.BottomTextKey : "Bottom Text", sharing.sharingImageNameKey : "pic3", sharing.OriginalImageNameKey : "pic3"],
            [sharing.TopTextKey : "4Top Text", sharing.BottomTextKey : "Bottom Text", sharing.sharingImageNameKey : "pic4", sharing.OriginalImageNameKey : "pic4"],
        ]
    }
}

