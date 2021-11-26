# QOI

A thin Swift wrapper of `qoi` the [Quite OK Image format](https://github.com/phoboslab/qoi). 

Still very much a work in progress, contributions are welcome.

Supported functionality:
- [x] Render for display
- [x] Read from file
- [ ] Decode in memory
- [ ] Encode in memory
- [ ] Write to file  

#### Keeping up to date

When SPM updates a package it _should_ automatically update submodules with it. You'll only need to update your Swift packages to get the latest `qoi`. 

## Usage

```swift
guard let url = Bundle.main.url(forResource: "test_output", withExtension: "qoi") else {
    return
}

// Creates a CIImage which is available cross platform
let ci = QOI.read(url: url) 

// iOS  
let image = UIImage(ciImage: ci)

// macOS 
if let cg = ci.cgImage {
    let image = NSImage(cgImage: cg, size: .zero)
}
```
