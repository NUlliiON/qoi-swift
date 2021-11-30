import Foundation
import CoreImage

extension QOI {
    
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

        let filename = url.path
        var desc = QOI.Descriptor()
        
        let pixels = QOI.read(filename: filename, desc: &desc, channels: 4)

        let byesPerRow = Int(desc.width * 4)
        let size = CGSize(width: Int(desc.width), height: Int(desc.width))

        let ci = CIImage(bitmapData: pixels,
                         bytesPerRow: byesPerRow,
                         size: size,
                         format: .RGBA8,
                         colorSpace: CGColorSpaceCreateDeviceRGB())

        return ci
    }
}
