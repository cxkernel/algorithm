import Cocoa

extension Int {
    ///十进制转十六进制
    func decTohex() -> String {
        return decTohex(0)
    }

    func decTohex(_ format: Int) -> String {
        return String(format: "%0\(format)X", self)
    }

    func decTobinary() -> String {
        var binaryString = ""
        var dec = self
        while dec > 0 {
            binaryString = "\(dec % 2)" + binaryString
            dec /= 2
        }

        return binaryString
    }

    func hostToBig() -> Int {
        if self < 0 { return self }
        if self <= 2<<15 {
            return Int(NSSwapHostShortToBig(UInt16(self)))
        } else if self <= 2<<31 {
            return Int(NSSwapHostIntToBig(UInt32(self)))
        } else if self <= 2<<63 {
            return Int(NSSwapBigLongLongToHost(UInt64(self)))
        }

        return self
    }

    func bigToHost() -> Int {
        if self < 0 { return self }
        if self <= 2<<15 {
            return Int(NSSwapBigShortToHost(UInt16(self)))
        } else if self <= 2<<31 {
            return Int(NSSwapBigIntToHost(UInt32(self)))
        } else if self <= 2<<63 {
            return Int(NSSwapBigLongLongToHost(UInt64(self)))
        }

        return self
    }

    func string() -> String {
        return String(self)
    }
}
58119.bigToHost()
let len = ["12", "123", "1234"].map { $0.count }.reduce(0, +)
print(len)
