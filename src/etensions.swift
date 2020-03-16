//
//  etensions.swift
//  ios-jjbadge
//
//  Created by Juan J LF on 3/16/20.
//

import Foundation

public extension NSAttributedString {
    
    func sizeOneLine( cgSize: inout CGSize) {
         
         let size = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
   
        let boundingBox = self.boundingRect(with: size, options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
         
         //redondeo float
         cgSize.width =  ceil(boundingBox.width)
         cgSize.height = ceil(boundingBox.height)
     
     }

}


public struct JJConstraintPriority {
     public var top, bottom, leading, trailing, width, height, centerX, centerY : UILayoutPriority
    
    static public let normal = JJConstraintPriority(top: UILayoutPriority(rawValue: 950), bottom: UILayoutPriority(rawValue: 950), leading: UILayoutPriority(rawValue: 950), trailing: UILayoutPriority(rawValue: 950), width: UILayoutPriority(rawValue: 950), height: UILayoutPriority(rawValue: 950), centerX: UILayoutPriority(rawValue: 950), centerY: UILayoutPriority(rawValue: 950))
    
    static public let required = JJConstraintPriority(top: UILayoutPriority(rawValue: 1000), bottom: UILayoutPriority(rawValue: 1000), leading: UILayoutPriority(rawValue: 1000), trailing: UILayoutPriority(rawValue: 1000), width: UILayoutPriority(rawValue: 1000), height: UILayoutPriority(rawValue: 1000), centerX: UILayoutPriority(rawValue: 1000), centerY: UILayoutPriority(rawValue: 1000))
}

public class JJConstraintSet {
    weak public var top, leading, bottom, trailing, width, height, centerXanchor, centerYanchor: NSLayoutConstraint?
}

   
public extension UIEdgeInsets {
    static func all(_ side: CGFloat) -> UIEdgeInsets {
        return .init(top: side, left: side, bottom: side, right: side)
    }
    static func top(_ side: CGFloat) -> UIEdgeInsets {
        return .init(top: side, left: 0, bottom: 0, right: 0)
    }
    
    static func bottom(_ side: CGFloat) -> UIEdgeInsets {
        return .init(top: 0, left: 0, bottom: side, right: 0)
    }
    static func left(_ side: CGFloat) -> UIEdgeInsets {
        return .init(top: 0, left: side, bottom: 0, right: 0)
    }
    static func right(_ side: CGFloat) -> UIEdgeInsets {
        return .init(top: 0, left: 0, bottom: 0, right: side)
    }
    
}
