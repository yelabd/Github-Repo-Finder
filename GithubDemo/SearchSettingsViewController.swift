//
//  SearchSettingsViewController.swift
//  GithubDemo
//
//  Created by Youssef Elabd on 3/2/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit

class SearchSettingsViewController: UIViewController {
    
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var minSlider: UISlider!
    
    weak var delegate: SettingsPresentingViewControllerDelegate?

    var settings = GithubRepoSearchSettings()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        self.delegate?.didCancelSettings()
        dismiss(animated:
            true, completion: nil)
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        settings.minStars = Int(minSlider.value)
        print(Int(minSlider.value))
         self.delegate?.didSaveSettings(settings: settings)
        dismiss(animated:
            true, completion: nil)
    }
    
    @IBAction func onSliderChanged(_ sender: Any) {
        minLabel.text = String(Int(minSlider.value))
         //print(Int(minSlider.value))
    }
    
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}



