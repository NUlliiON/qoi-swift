import Foundation
import Cqoi

public struct QOI {

    public static func read(filename: String, w: inout Int32, h: inout Int32, channels: Int32) -> Data {
        guard let pixels = Cqoi.qoi_read(filename.cString(using: .utf8), &w, &h, channels) else {
            print("no file")
            return Data()
        }

        let data = Data(bytes: pixels, count: Int(w * h))

        return data
    }
}
