//
//  objects.swift
//  append
//
//  Created by Patrick Cui on 9/11/21.
//

import UIKit
import PassKit

var passTypes = ["Membership Card", "ID Card", "Ticket", "Coupon", "Barcode", "QR Code", "Other"]

struct PassStruct: Codable {
    var icon: String
    var title: String
    var colorIndex: Int
    var type: String
    var note: String?
    var data: String?
    var metaData: String?
}

class Pass {
    public var icon: String
    public var title: String
    public var color: UIColor
    public var type: String
    public var note: String?
    public var data: String?
    public var metaData: String?
    
    init(icon: String, title: String, color: UIColor, type: String, note: String?, data: String? = nil, metaData: String? = nil) {
        self.icon = icon
        self.title = title
        self.color = color
        self.type = type
        self.note = note
        self.data = data
        self.metaData = metaData
    }
    
    static func fromStruct(input: PassStruct) -> Pass {
        return Pass(icon: input.icon, title: input.title, color: Color.customColors[input.colorIndex], type: input.type, note: input.note, data: input.data, metaData: input.metaData)
    }
    
    func copy() -> Pass {
        return Pass(icon: icon, title: title, color: color, type: type, note: note)
    }
    
    func update(with other: Pass) {
        icon = other.icon
        title = other.title
        color = other.color
        type = other.type
        note = other.note
    }
    
    func generateScannable() -> UIImage? {
        return nil
    }
    
    func generateStruct() -> PassStruct {
        let colorIndex = Color.customColors.firstIndex(of: color) ?? 0
        let output = PassStruct(icon: icon, title: title, colorIndex: colorIndex, type: type, note: note, data: data, metaData: metaData)
        return output
    }
    
    func preview() -> UIView {
        let logoView: UIImageView = {
            let logoView = UIImageView()
            logoView.translatesAutoresizingMaskIntoConstraints = false
            logoView.image = UIImage(named: "logo")
            logoView.contentMode = .scaleAspectFit
            return logoView
        }()
        let typeLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = Font.ny.withSize(size: 12.s)
            label.text = type
            label.numberOfLines = 1
            label.adjustsFontSizeToFitWidth = true
            label.minimumScaleFactor = 0.8
            label.textAlignment = .center
            return label
        }()
        let titleLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = icon + " " + title
            label.font = Font.bold.withSize(size: 24.s)
            label.adjustsFontSizeToFitWidth = true
            label.textAlignment = .center
            label.numberOfLines = 1
            return label
        }()
        let noteLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = note ?? ""
            label.font = Font.regular.withSize(size: 12.s)
            label.numberOfLines = 3
            label.adjustsFontSizeToFitWidth = true
            label.textAlignment = .center
            label.minimumScaleFactor = 0.5
            return label
        }()
        let scannable: UIImageView = {
            let v = UIImageView()
            v.translatesAutoresizingMaskIntoConstraints = false
            v.backgroundColor = UIColor.white
            return v
        }()
        let view: UIView = {
            let v = UIView()
            v.translatesAutoresizingMaskIntoConstraints = false
            v.backgroundColor = color
            v.layer.cornerRadius = 16
            return v
        }()
        view.addSubview(logoView)
        logoView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        logoView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20.s).isActive = true
        logoView.widthAnchor.constraint(equalToConstant: 80.s).isActive = true
        view.addSubview(typeLabel)
        typeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        typeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 64.s).isActive = true
        typeLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        view.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: (note == nil) ? 48.s : 16.s).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        view.addSubview(noteLabel)
        noteLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        noteLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20.s).isActive = true
        noteLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        view.addSubview(scannable)
        scannable.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scannable.widthAnchor.constraint(equalToConstant: 200.s).isActive = true
        scannable.heightAnchor.constraint(equalToConstant: 75.s).isActive = true
        scannable.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50.s).isActive = true
        scannable.image = generateScannable()
        return view
    }
    
}

class CacheManager {
    static func save(data: [PassStruct]) {
        do {
            let encoder = JSONEncoder()
            let encoded = try encoder.encode(data)
            UserDefaults.standard.set(encoded, forKey: "passes")
        } catch {
            print("Unable to Encode Note (\(error))")
        }
    }
    static func load() -> [PassStruct] {
        if let data = UserDefaults.standard.data(forKey: "passes") {
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode([PassStruct].self, from: data)
                return result
            } catch {
                print("Unable to Decode Notes (\(error))")
                return []
            }
        }
        return []
    }
}
