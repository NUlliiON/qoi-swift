# QOI

A thin Swift wrapper of `qoi` the [Quite OK Image format](https://github.com/phoboslab/qoi). 

Still very much a work in progress, contributions are welcome.

Supported functionality:
- [x] Render for display
- [x] Read from file
- [x] Decode in memory
- [ ] Encode in memory
- [ ] Write to file  

#### Keeping up to date

When SPM updates a package it _should_ automatically update submodules with it. You'll only need to update your Swift packages to get the latest `qoi`. 

You can use `git submodule update --remote` if you're not unsure.

## Usage

```swift
guard let url = Bundle.main.url(forResource: "test_output", withExtension: "qoi") else {
    return
}

// Reads and decodes a qoi file into a container  
let qoi = QOI.read(url: url) 

// Creates a CIImage out of the decoded pixel data, for display
let ci = qoi.ciImage

// iOS  
let image = UIImage(ciImage: ci)

// macOS 
if let cg = ci.cgImage {
    let image = NSImage(cgImage: cg, size: .zero)
}
```
