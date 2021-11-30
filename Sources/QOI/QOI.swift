import Foundation

public protocol Coder {
    func read(filename: String, desc: inout QOI.Descriptor, channels: Int32) -> Data
}

public struct QOI {

    public static var coder: Coder = CqoiCoder()
    
    public struct Descriptor {
        var width: UInt32 = 0
        var height: UInt32 = 0
        var channels: UInt8 = 4
        var colorspace: UInt8 = 0
    }

    
    /**
     Direct mapping of `qoi_read()`. You probably want `read(url:)` instead.
     */
    public static func read(filename: String, desc: inout Descriptor, channels: Int32) -> Data {
        
        return coder.read(filename: filename, desc: &desc, channels: channels)
        
    }
}
