//
//  ImageTest.swift
//  append
//
//  Created by Jimmy Kang on 9/12/21.
//

import Foundation
import UIKit

class ImageTest: UIViewController {

    let someImageView: UIImageView = {
       let theImageView = UIImageView()
        let pass = Pass(icon: "", title: "", color: UIColor(), type: "", note: "", data: "12345678")
        theImageView.image = pass.generateScannable(width: 50, height: 100)
       theImageView.translatesAutoresizingMaskIntoConstraints = false //You need to call this property so the image is added to your view
       return theImageView
    }()

    override func viewDidLoad() {
       super.viewDidLoad()

       view.addSubview(someImageView) //This add it the view controller without constraints
       someImageViewConstraints() //This function is outside the viewDidLoad function that controls the constraints
    }

    // do not forget the `.isActive = true` after every constraint
    func someImageViewConstraints() {
//        someImageView.widthAnchor.constraint(equalToConstant: 180).isActive = true
//        someImageView.heightAnchor.constraint(equalToConstant: 180).isActive = true
        someImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        someImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 28).isActive = true
    }

}
