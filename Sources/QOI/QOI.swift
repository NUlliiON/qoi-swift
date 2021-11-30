import Foundation

public protocol Coder {
    func read(filename: String) -> QOI.Image
}

public struct QOI {

    public static var coder: Coder = CqoiCoder()
        
    public struct Image {
        var width: Int = 0
        var height: Int = 0
        var channels: Int = 4
        var colorspace: Int = 0
        var pixels: Data = Data()
    }

    /**
     You probably want `read(url:)` instead.
     */
    public static func read(filename: String) -> Image {
        return coder.read(filename: filename)
    }
}
