//
//  Note.swift
//  StudyPlan
//
//  Created by Humberto Rodrigues on 16/02/23.
//
// Minha Classe Note criará uma Nota, contendo View, Cor(escolha do usuário), Fonte, imagem da linguagem em si

import UIKit

struct Note: Codable {
    let color: Colors?
    var font: String = "Georgia"
    let image: ImagesLG?
    let noteText: String?
}
