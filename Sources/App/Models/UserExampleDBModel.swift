//
//  UserExampleDBModel.swift
//  App
//
//  Created by Ferhan Akkan on 17.08.2020.
//

import Foundation
import Vapor
import FluentSQLite

struct UserExampleDBModel: Content {
    var id: UUID?
    var name: String
    var surname: String
    var age: Int
}

extension UserExampleDBModel: SQLiteUUIDModel {
    static let entity: String = "User"
    // Bunu tanimlama nedenimiz tabloya isim vermek bunu vermez isek modelin adini alir.
}

extension UserExampleDBModel: SQLiteMigration {}

extension UserExampleDBModel: Parameter {}
