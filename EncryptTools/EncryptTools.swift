//
//  EncryptTools.swift
//  EncryptTools
//
//  Created by qiuweniOS on 2018/4/10.
//  Copyright © 2018年 AndyCuiYTT. All rights reserved.
//

import UIKit

extension String {
    var ytt: EncryptTools<String> {
        return EncryptTools(self)
    }
}

extension Data {
    var ytt: EncryptTools<Data> {
        return EncryptTools(self)
    }
}

extension UIImage {
    var ytt: EncryptTools<UIImage> {
        return EncryptTools(self)
    }
}

class EncryptTools<Element> {
    private var obj: Element
    
    init(_ item: Element) {
        obj = item
    }
    
    func MD5() -> String? {
        if let str = obj as? String {
            if let data = str.data(using: .utf8) {
                return MD5_Encrypt(data)
            }else {
                return nil
            }
        }else if let image = obj as? UIImage {
            guard let imageData = UIImagePNGRepresentation(image) else {
                return nil
            }
            return MD5_Encrypt(imageData)
        }else if let data = obj as? Data {
            return MD5_Encrypt(data)
        }
        
        return nil
    }
    
    
    private func MD5_Encrypt(_ data: Data) -> String {
    
        let cStr = (data as NSData).bytes
        let result = UnsafeMutablePointer<UInt8>.allocate(capacity: 16)
        CC_MD5(cStr, CC_LONG(data.count), result)
        let resultStr: NSMutableString = NSMutableString()
        for i in 0 ..< Int(CC_MD5_DIGEST_LENGTH) {
            resultStr.appendFormat("%02x", result[i])
        }
        return resultStr.lowercased
    }
    
    
}

