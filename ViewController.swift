//
//  ViewController.swift
//  BB API
//
//  Created by IACD-Air-6 on 2021/07/05.
//

import UIKit

extension UIImageView {
    
    
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link)
        else {
            return
        }
        downloaded(from: url, contentMode: mode)
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var charImage: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var nickyLbl: UILabel!
    @IBOutlet weak var portrayed: UILabel!
    @IBOutlet weak var birthday: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var qouteLbl: UILabel!
    
    var qouta = [CharQoutes]()
    
    var charQ: CharQoutes?
    var characters: Character?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLbl.text = "Name: \(characters!.name)"
        nickyLbl.text = "Nickname: \(characters!.nickname)"
        portrayed.text = "Portrayed as: \(characters!.portrayed)"
        birthday.text = "DOB: \(characters!.birthday)"
        
        statusLbl.text = "Current status: \(characters!.status)"
        if characters?.status == "Deceased" || characters?.status == "Presumed dead" {
            statusLbl.textColor = UIColor.red
        }
        else {
            statusLbl.textColor = UIColor.green
        }
        
        let urlString = (characters?.img)!
        let url = URL(string: urlString)
        
        charImage.downloaded(from: url!)
        
        
        
        qouteLbl.text = ""
        
        for i in 0 ..< qouta.count
        {
            qouteLbl.text?.append("\(qouta[i].quote) \n\n")
            print(qouta[i].quote)
        }
    }  
}



