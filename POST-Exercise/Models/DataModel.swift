//
//  DataModel.swift
//  POST-Exercise
//
//  Created by C4Q on 12/12/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import Foundation

class DataModel {
    static let kPathname = "ImageListCodable.plist"
    private init() {}
    static let shared = DataModel()
    
    private var lists = [Image]() {
        didSet {
            saveImageList()
        }
    }
    
    private func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    private func dataFilePath(withPathName path: String) -> URL {
        return DataModel.shared.documentsDirectory().appendingPathComponent(path)
    }
    private func saveImageList() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(lists)
            let path = dataFilePath(withPathName: DataModel.kPathname)
            try data.write(to: path, options: .atomic)
        } catch {
            print("error encoding items: \(error.localizedDescription)")
        }
    }
    public func load() {
        let path = dataFilePath(withPathName: DataModel.kPathname)
        let decoder = PropertyListDecoder()
        do {
            let data = try Data.init(contentsOf: path)
            lists = try decoder.decode([Image].self, from: data)
        } catch {
            print("error decoding items: \(error.localizedDescription)")
        }
    }
    public func addImageItemToList(imageItem item: Image) {
        lists.append(item)
    }
    public func getLists() -> [Image] {
        return lists
    }
    public func updateImageItem(withUpdatedItem item: Image) {
        if let index = lists.index(where: {$0 === item}) {
            lists[index] = item
        }
    }
    public func removeImageItemFromIndex(fromIndex index: Int) {
        lists.remove(at: index)
    }
    
}
