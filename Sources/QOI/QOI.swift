import Foundation
import CoreImage

public protocol Coder {
    func read(filename: String) -> QOI.Image
    func read(url: URL) -> QOI.Image
    func decode(data: Data) -> QOI.Image
}

public struct QOI {

    /**
     The qoi en-/decoder to use. Currently only supports Cqoi.
     TODO: make this public when swift coder is added.
     */
    private static var coder: Coder = CqoiCoder()
        
    
    public struct Image {
        var header: Header = Header()
        var pixels: Data = Data()
    }

    public struct Header {
        var width: Int = 0
        var height: Int = 0
        var channels: Int = 4
        var colorspace: Int = 0
    }
    
    /**
     You probably want `read(url:)` instead.
     */
    public static func read(filename: String) -> Image {
        return coder.read(filename: filename)
    }
    
    /**
     Reads a QOI file at the specified file URL and converts it into a CIImage for display.
     Uses the devices default RGB colorspace, and assumes the image has 4 channels.

     Example usage:
     ```
     let ci = QOI.read(url: url)
     let image = UIImage(ciImage: ci)
     ```

        - parameters:
            - url: A file URL pointing to a QOI file on disk
     */
    public static func read(url: URL) -> CIImage {
        guard url.isFileURL else {
            return CIImage()
        }

        let image = coder.read(url: url)

        let byesPerRow = Int(image.header.width * 4)
        let size = CGSize(width: image.header.width, height: image.header.height)

        let ci = CIImage(bitmapData: image.pixels,
                         bytesPerRow: byesPerRow,
                         size: size,
                         format: .RGBA8,
                         colorSpace: CGColorSpaceCreateDeviceRGB())

        return ci
    }
}
