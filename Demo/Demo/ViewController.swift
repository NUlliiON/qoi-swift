//
//  ViewController.swift
//  Demo
//
//  Created by Christopher Baltzer on 2021-11-30.
//

import UIKit
import QOI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
                
        do {
            let url = Bundle.main.url(forResource: "testcard_rgba", withExtension: "qoi")!
            
            // Direct read+decode+convert
            //let image = QOI.read(url: url)
            
            // Read
            let testcard = try Data(contentsOf: url)
            // Decode
            let qoi = QOI.decode(data: testcard)
            // Convert for display
            let image = qoi.ciImage
            
            
            let imageView = UIImageView(image: UIImage(ciImage: image))
            view.addSubview(imageView)
        } catch {}
    }

}

