//
//  ViewController.swift
//  WondersOfTheWorldApp
//
//  Created by Pelin ASLAN on 6.05.2021.
//

import UIKit

class WonderWorld {
    var categoryName: String?
    var placeName: [String]?
    var placeImage = [UIImage]()
    
    
    init(categoryName: String, placeName: [String], placeImage: [UIImage]) {
        self.categoryName = categoryName
        self.placeName = placeName
        self.placeImage = placeImage
      
    }
}

class ViewController: UIViewController {
    
    var chosenPlaceNames = ""
    var chosenPlaceImage  = UIImage()


    @IBOutlet weak var tableView: UITableView!
    var wonderWorld = [WonderWorld]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wonderWorld.append(WonderWorld.init(categoryName: "New7Wonders of the World",placeName: ["Great Wall of China","Petra","Christ the Redeemer", "Machu Picchu", "Chichen Itza", "Colosseum", "Taj Mahal", "Great Pyramid of Giza"],placeImage: [UIImage(named: "Great Wall of China")!,UIImage(named: "Petra")!,UIImage(named: "Christ the Redeemer")!,UIImage(named: "Machu Picchu")!,UIImage(named: "Chichen Itza")!,UIImage(named: "Colosseum")!,UIImage(named: "Taj Mahal")!,UIImage(named: "Great Pyramid of Giza")!]))
        
        
        wonderWorld.append(WonderWorld.init(categoryName: "New7Wonders of Nature", placeName: ["Iguazu Falls ", "Hạ Long Bay", "Jeju Island ", "Puerto Princesa Underground River", "Table Mountain","Komodo","Amazon rainforest" ],placeImage: [UIImage(named: "Iguazu Falls")!,UIImage(named: "Hạ Long Bay")!,UIImage(named: "Jeju Island")!,UIImage(named: "Puerto Princesa Underground River")!,UIImage(named: "Table Mountain")!,UIImage(named: "Komodo")!,UIImage(named: "Amazon rainforest")!]))
        
        wonderWorld.append(WonderWorld.init(categoryName: "New7Wonders Cities", placeName: ["Durban, South Africa", "Vigan, Philippines", "Havana, Cuba","Kuala Lumpur, Malaysia","Beirut, Lebanon","Doha, Qatar","La Paz, Bolivia"],placeImage: [UIImage(named: "durban")!,UIImage(named: "vigan")!,UIImage(named: "havana")!,UIImage(named: "kuala lampur")!,UIImage(named: "beirut")!,UIImage(named: "doha")!,UIImage(named: "la paz")!]))
        
        wonderWorld.append(WonderWorld.init(categoryName: "Seven Wonders of the Underwater World", placeName: ["Palau", "Belize Barrier Reef", "Great Barrier Reef", "Deep-Sea Vents","Galápagos Islands","Lake Baikal","Northern Red Sea"],placeImage: [UIImage(named: "palau")!,UIImage(named: "Belize Barrier Reef")!,UIImage(named: "Great Barrier Reef")!,UIImage(named: "Deep-Sea Vents")!,UIImage(named: "Galápagos Islands")!,UIImage(named: "Lake Baikal")!,UIImage(named: "Northern Red Sea")!]))
        
        //baslik
        navigationItem.title = "Wonders Of The World"
                                                                                                                                  
    
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return wonderWorld.count
    }
    
    //satir sayisi
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wonderWorld[section].placeName?.count ?? 0
    }
    
    //her satirdaki icerik
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = wonderWorld[indexPath.section].placeName?[indexPath.row]
        return cell
    }
    
    //func tableView(_ tableView: UITableView, //titleForHeaderInSection section: Int) -> String? {
   //     return mobileBrand[section].brandName
   // }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        view.backgroundColor = #colorLiteral(red: 1, green: 0.3653766513, blue: 0.1507387459, alpha: 1)
        
        let lbl = UILabel(frame: CGRect(x: 15, y: 0, width: view.frame.width - 15, height: 40))
        lbl.font = UIFont.systemFont(ofSize: 20)
        lbl.text = wonderWorld[section].categoryName
        view.addSubview(lbl)
        return view
    }
    
    //secilince ne olacak
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //secilen degerleri alir
        chosenPlaceNames = (wonderWorld[indexPath.section].placeName?[indexPath.row])!
        chosenPlaceImage = (wonderWorld[indexPath.section].placeImage[indexPath.row])
        
        performSegue(withIdentifier: "toimageViewController", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toimageViewController"{
                                    //hedef viewCont.
            let destinatinationVC = segue.destination as! imageViewController
            destinatinationVC.selectedPlaceName = chosenPlaceNames
            destinatinationVC.selectedPlaceImage = chosenPlaceImage
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    
}


