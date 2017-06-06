//
//  LeftMenuController.swift
//  Rutappy
//
//  Created by Miguel Roncallo on 4/11/17.
//  Copyright © 2017 Novus. All rights reserved.
//

import UIKit
import Kingfisher

class LeftMenuController: UIViewController {

    
    var menuItems = ["Datos de Perfil", "Historial", "Noticias", "Configuraciones", "Calificar App", "Cerrar Sesión"]
    var menuImages = ["usuario", "historial", "news", "configuracion", "calificar", "salir"]
    
    @IBOutlet var userImage: UIImageView!
    
    @IBOutlet var userName: UILabel!
    
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        userImage.layer.cornerRadius = userImage.layer.frame.width / 2
        userImage.clipsToBounds = true
        
        userName.text = DataService.sharedInstance.currentUser.name
        
        userImage.kf.setImage(with: URL(string: DataService.sharedInstance.currentUser.imagen))
    }
}

extension LeftMenuController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Profile VC") as! ProfileController
        self.present(vc, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Menu Cell") as! MenuCell
        
        cell.menuLabel.text = menuItems[indexPath.row]
        cell.menuImage.image = UIImage(named: menuImages[indexPath.row])
        
        return cell
    }
}
