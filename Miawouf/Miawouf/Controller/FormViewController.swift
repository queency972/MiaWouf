//
//  FormViewController.swift
//  Miawouf
//
//  Created by Steve Bernard on 14/01/2020.
//  Copyright © 2020 Steve Bernard. All rights reserved.
//

import UIKit

// Class et ses propriétés.
class FormViewController: UIViewController, UITextFieldDelegate {

    var dog: Pet!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var majoritySwitch: UISwitch!
    @IBOutlet weak var genderSegmentControl: UISegmentedControl!
    @IBOutlet weak var racePickerView: UIPickerView!
}

// MARK: -  Extension de la classe FormViewController avec ses protocoles...
extension FormViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    // number of column in dropdown list
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dogRaces.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dogRaces[row]
    }
}

// MARK: - Extension de la classe FormViewController pour valider le formulaire.
extension FormViewController {
    // Bouton "valider"
    @IBAction func validate() {
        createPetObject()
        checkPetStatus()
        // Lancer la transition ver le controlleur.
        performSegue(withIdentifier: "segueToSuccess", sender: self)
    }

    // On crée l'objet dog.
    private func createPetObject() {
        let name = nameTextField.text
        let phone = phoneTextField.text
        let hasMajority = majoritySwitch.isOn
        let genderIndex = genderSegmentControl.selectedSegmentIndex
        let gender: Pet.Gender = (genderIndex == 0) ? .female : .male
        let raceIndex = racePickerView.selectedRow(inComponent: 0)
        let race = dogRaces[raceIndex]
        dog = Pet(name: name, hasMajority: hasMajority, phone: phone, race: race, gender: gender)
    }

    // Evaluez le status de l'objet "dog"
    private func checkPetStatus() {
        switch dog.status {
        case .accepted:
            performSegue(withIdentifier: "segueToSucces", sender: self)
        case .rejected(let error):
            presentAlert(with: error)
        }
    }

    // Afficher une alerte
    private func presentAlert(with error: String) {
        // On crée l'alerte.
        let alertVC = UIAlertController(title: "Oups !", message: error, preferredStyle: .alert)
        // On crée l'action.
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        // On ajoute l'action à l'alerte.
        alertVC.addAction(action)
        // Et on présente l'alerte.
        present(alertVC, animated: true, completion: nil)
    }
}
// MARK: - Extension FormViewControlleur pour les methodes naviguation
extension FormViewController {
    // Faire passer les données d'une controlleur à un autre. Elle est executé juste avant que la transition n'est lieu.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToSuccess" {
            // Recuperer le controleur de distination
            let successVC = segue.destination as! SuccessViewController
            // Passer les données.
            successVC.dog = dog
        }
    }
}
// MARK: - Extension FormViewControlleur pour les methodes clavier.
extension FormViewController {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        nameTextField.resignFirstResponder()
        phoneTextField.resignFirstResponder()
    }
}

