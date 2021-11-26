import Foundation
import CoreImage
import Cqoi

public struct QOI {

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
        var w: Int32 = 0
        var h: Int32 = 0

        let pixels = QOI.read(filename: filename, w: &w, h: &h, channels: 4)

        let byesPerRow = Int(w * 4)
        let size = CGSize(width: Int(w), height: Int(h))

        let ci = CIImage(bitmapData: pixels,
                         bytesPerRow: byesPerRow,
                         size: size,
                         format: .RGBA8,
                         colorSpace: CGColorSpaceCreateDeviceRGB())

        return ci
    }


    /**
     Direct mapping of `qoi_read()`. You probably want `read(url:)` instead.
     */
    public static func read(filename: String, w: inout Int32, h: inout Int32, channels: Int32) -> Data {
        guard let pixels = Cqoi.qoi_read(filename.cString(using: .utf8), &w, &h, channels) else {
            return Data()
        }

        let data = Data(bytes: pixels, count: Int(w * h * (channels + 1) + Cqoi.QOI_HEADER_SIZE + Cqoi.QOI_PADDING))

        return data
    }
}
