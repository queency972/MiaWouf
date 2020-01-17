//
//  SuccessViewController.swift
//  Miawouf
//
//  Created by Steve Bernard on 15/01/2020.
//  Copyright © 2020 Steve Bernard. All rights reserved.
//

import UIKit

class SuccessViewController: UIViewController {
    var dog: Pet!
    @IBAction func dissmis(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    @IBOutlet weak var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setTextLabel()
    }

    private func setTextLabel() {
        if let name = dog.name {
            label.text = "WOUF ! Bienvenue \(name) ! \n\nVous avez bien été ajouté à notre base de donnée ! Nous vous enverrons un SMS dès que nous avons une âme soeur à vous proposer !"
        }
    }
}
