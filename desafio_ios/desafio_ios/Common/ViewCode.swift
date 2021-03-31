//
//  ViewCoding.swift
//  desafio_ios
//
//  Created by Lelio Jorge on 30/03/21.
//

import Foundation



public protocol ViewCoding {
    
    ///Métodos para configurar as subviews na view
    func buildViewHierarchy()
    
    ///Método para configurar as constraints nas subviews
    func setupConstraints()
    
    /// Método para fazer alguma configuração adicional na view
    func setupAdditionalConfiguration()
    
    /// Método que chama os métodos auxiliares para configurar a view
    func setupView()
}


extension ViewCoding{
    
    func setupView(){
        buildViewHierarchy()
        setupConstraints()
        setupAdditionalConfiguration()
    }
    
    func setupAdditionalConfiguration(){}

}

