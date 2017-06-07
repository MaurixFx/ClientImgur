//
//  Constants.swift
//  ClientImgur
//
//  Created by Mauricio Figueroa Olivares on 31-05-17.
//  Copyright © 2017 Mauricio Figueroa Olivares. All rights reserved.
//

import Foundation

let Cheaders = ["Authorization": "Client-ID 551cdb16a4eb8c9"]
let CbaseUrlTopics = "https://api.imgur.com/3/topics/defaults"
let CbaseUrlTags = "https://api.imgur.com/3/tags/"
let CbaseUrlGaleryTags = "https://api.imgur.com/3/gallery/t/"

let CbaseUrlAlbumImage = "https://api.imgur.com/3/album/"
let CbaseUrlTopicsImages = "https://api.imgur.com/3/topics/"
let CbaseUrlCommentsGalleryImage = "https://api.imgur.com/3/gallery/album/"
let CbaseUrlUploadImage = "https://api.imgur.com/3/image"

typealias DownloadComplete = () -> ()
