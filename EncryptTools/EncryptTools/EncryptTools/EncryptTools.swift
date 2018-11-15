//
//  EncryptTools.swift
//  EncryptTools
//
//  Created by AndyCui on 2018/4/10.
//  Copyright © 2018年 AndyCuiYTT. All rights reserved.
//

import UIKit
import CommonCrypto

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
    
    
    /// 对数据进行 MD5 加密
    ///
    /// - Returns: 加密后字符串
    func MD5() -> String? {
        if let str = obj as? String {
            if let data = str.data(using: .utf8) {
                return MD5_Encrypt(data)
            }else {
                return nil
            }
        }else if let image = obj as? UIImage {
            guard let imageData = image.pngData() else {
                return nil
            }
            return MD5_Encrypt(imageData)
        }else if let data = obj as? Data {
            return MD5_Encrypt(data)
        }
        
        return nil
    }
    
    /// 对数据进行 SHA1 加密
    ///
    /// - Returns: 加密后字符串
    func SHA1() -> String? {
        if let str = obj as? String {
            if let data = str.data(using: .utf8) {
                return SHA1_Encrypt(data)
            }else {
                return nil
            }
        }else if let image = obj as? UIImage {
            guard let imageData = image.pngData() else {
                return nil
            }
            return SHA1_Encrypt(imageData)
        }else if let data = obj as? Data {
            return SHA1_Encrypt(data)
        }
        
        return nil
    }
    
    
    /// 对数据亦或加密
    ///
    /// - Parameter encryptKeyStr: 加密秘钥字符串
    /// - Returns: 加密后的 Data(加密后数据可能无法转化为字符串)
    func XOR(encryptKeyStr: String) -> Data? {
        if let str = obj as? String {
            if let data = str.data(using: .utf8) {
                return XOR_Encrypt(data, encryptKeyStr: encryptKeyStr)
            }else {
                return nil
            }
        }else if let image = obj as? UIImage {
            guard let imageData = image.pngData() else {
                return nil
            }
            return XOR_Encrypt(imageData, encryptKeyStr: encryptKeyStr)
        }else if let data = obj as? Data {
            return XOR_Encrypt(data, encryptKeyStr: encryptKeyStr)
        }
        return nil
    }
    
    
    private func MD5_Encrypt(_ data: Data) -> String {
    
        return data.withUnsafeBytes { (cStr: UnsafePointer<UInt8>) -> String in
            let result = UnsafeMutablePointer<UInt8>.allocate(capacity: Int(CC_MD5_DIGEST_LENGTH))
            CC_MD5(cStr, CC_LONG(data.count), result)
            let resultStr: NSMutableString = NSMutableString()
            for i in 0 ..< Int(CC_MD5_DIGEST_LENGTH) {
                resultStr.appendFormat("%02x", result[i])
            }
            result.deallocate()
            return resultStr as String
        }
        
//        let cStr = (data as NSData).bytes
//        let result = UnsafeMutablePointer<UInt8>.allocate(capacity: Int(CC_MD5_DIGEST_LENGTH))
//        CC_MD5(cStr, CC_LONG(data.count), result)
//        let resultStr: NSMutableString = NSMutableString()
//        for i in 0 ..< Int(CC_MD5_DIGEST_LENGTH) {
//            resultStr.appendFormat("%02x", result[i])
//        }
//        result.deallocate()
//        return resultStr as String
    }
    
    private func SHA1_Encrypt(_ data: Data) -> String {
//        let cStr = (data as NSData).bytes
        return data.withUnsafeBytes { (cStr: UnsafePointer<UInt8>) -> String in
            let result = UnsafeMutablePointer<UInt8>.allocate(capacity: Int(CC_SHA1_DIGEST_LENGTH))
            CC_SHA1(cStr, CC_LONG(data.count), result)
            let resultStr: NSMutableString = NSMutableString()
            for i in 0 ..< Int(CC_MD5_DIGEST_LENGTH) {
                resultStr.appendFormat("%02x", result[i])
            }
            result.deallocate()
            return resultStr as String
        }
    }
    
    private func XOR_Encrypt(_ data: Data, encryptKeyStr: String) -> Data? {

        guard let keyData = encryptKeyStr.data(using: .utf8) else {
            return nil
        }
        var resultData: Data = Data()
        for i in 0 ..< data.count {
            resultData.append(data[i] ^ keyData[i % keyData.count])
        }
        return resultData
    }
    
    
}

