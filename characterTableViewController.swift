//
//  characterTableViewController.swift
//  BB API
//
//  Created by IACD-Air-6 on 2021/07/05.
//

import UIKit





class characterTableViewController: UITableViewController {
    
    var char = [Character]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData {
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return char.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! charTableViewCell
        
        let characterSet = char[indexPath.row]
        cell.nameLbl.text = "\(characterSet.name)"
        cell.nickLbl.text = "\(characterSet.nickname)"
        cell.bdayLbl.text = "\(characterSet.birthday)"
        cell.charImg.downloaded(from: "\(characterSet.img)")
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: self)
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? ViewController {
            destination.characters = char[tableView.indexPathForSelectedRow!.row]
        }
        
    }
    
    
    func getData(completed: @escaping () -> ()) {
        
       let url = URL(string: "https://www.breakingbadapi.com/api/characters")!
        let urlSession = URLSession.shared
        let urlRequest = URLRequest(url: url)

        let task = urlSession.dataTask(with: urlRequest) { data, urlResponse, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let unwrappedData = data else {
                print("No data")
                return
            }
            
            if let unwrappedString = String(data: unwrappedData, encoding: .utf8) {
               print(unwrappedString)
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                guard let characterList = try? jsonDecoder.decode([Character].self, from: unwrappedData) else {
                    print("Could not decode")
                    return
                }
                self.char.append(contentsOf: characterList)
            }
            DispatchQueue.main.async {
                completed()
            }
        }

        task.resume()
    }
}
