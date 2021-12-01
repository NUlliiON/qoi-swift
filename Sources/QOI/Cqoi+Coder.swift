import Foundation
import Cqoi

struct CqoiCoder: Coder {
    
    func read(filename: String) -> QOI.Image {
        let file = filename.cString(using: .utf8)
        let channels = 4
        
        var descriptor: Cqoi.qoi_desc = Cqoi.qoi_desc(width: 0,
                                                      height: 0,
                                                      channels: 4,
                                                      colorspace: 0)
        
        guard let pixels = Cqoi.qoi_read(file, &descriptor, Int32(channels)) else {
            return QOI.Image()
        }

        
        let count = Int(descriptor.width) * Int(descriptor.height) * (channels + 1) + Int(Cqoi.QOI_HEADER_SIZE) + Int(Cqoi.QOI_PADDING)
        
        let data = Data(bytes: pixels, count: count)

        return image(descriptor: descriptor, pixels: data)
    }
    
    
    func read(url: URL) -> QOI.Image {
        do {
            let data = try Data(contentsOf: url)
            return decode(data: data)
        } catch {
            return QOI.Image()
        }
    }
    
    
    func decode(data: Data) -> QOI.Image {
        let channels = 4
        
        var descriptor: Cqoi.qoi_desc = Cqoi.qoi_desc(width: 0,
                                                      height: 0,
                                                      channels: 4,
                                                      colorspace: 0)
        
        let qoiPixels = data.withUnsafeBytes {
            $0.baseAddress!
        }
        
        guard let pixels = Cqoi.qoi_decode(qoiPixels, Int32(data.count), &descriptor, Int32(channels)) else {
            return QOI.Image()
        }

        let count = Int(descriptor.width) * Int(descriptor.height) * (channels + 1) + Int(Cqoi.QOI_HEADER_SIZE) + Int(Cqoi.QOI_PADDING)
        
        let decodedData = Data(bytes: pixels, count: count)
        
        return image(descriptor: descriptor, pixels: decodedData)
    }
    
    
    fileprivate func image(descriptor: Cqoi.qoi_desc, pixels: Data) -> QOI.Image {
        var image = QOI.Image()
        image.header.width = Int(descriptor.width)
        image.header.height = Int(descriptor.height)
        image.header.channels = Int(descriptor.channels)
        image.header.colorspace = Int(descriptor.colorspace)
        image.pixels = pixels
        
        return image
    }
}
