import UIKit

class characterTableViewController: UITableViewController {
    
    var char = [Character]()
    var quoteDeats = [CharQoutes]()
    var filteredQuotes = [CharQoutes]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData {
            self.getQoutes {
                print("Happy")
            }
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? ViewController {
            destination.characters = char[tableView.indexPathForSelectedRow!.row]
            destination.qouta = returnCharacterQuote(char[(tableView.indexPathForSelectedRow?.row)!].name)
        }
        
    }
    
    func returnCharacterQuote(_ characterName: String) -> [CharQoutes]
    {
        
        filteredQuotes = quoteDeats.filter
        {
            $0.author.elementsEqual(characterName)
        }
        
        return filteredQuotes
        
    }
    
    func getQoutes(completed: @escaping () -> ())
    {
        let url = URL(string: "https://www.breakingbadapi.com/api/quotes")
        
        URLSession.shared.dataTask(with: url!)
        {
            (data, response, error) in
            
            if error == nil
            {
                do
                    {
                        self.quoteDeats = try JSONDecoder().decode([CharQoutes].self, from: data!)
                        
                        DispatchQueue.main.async
                        {
                            completed()
                        }
                    }
                catch
                {
                    print("Quotes not found.")
                }
            }
        }.resume()
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
                    print("Could not decode characters")
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
