//
//  AboutCompanyCellDescription.swift
//  TrubaPND77
//
//  Created by Serg on 15.09.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation
import UIKit

class AboutCompanyCellDescription: UITableViewCell {
    
    private weak var aboutCompanyDescription: UILabel!
    private weak var operatingMode: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        settingLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        if traitCollection.horizontalSizeClass == .regular {
            aboutCompanyDescription.font = .systemFont(ofSize: 25, weight: .regular)
            operatingMode.font = .systemFont(ofSize: 26, weight: .regular)
        }
        super.updateConstraints()
    }
    
    private func settingLayout() {
        let mode = UILabel()
        mode.font = .systemFont(ofSize: 22, weight: .regular)
        mode.text = "работаем с 9:00 до 18:00"
        self.operatingMode = mode
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "clock")
        imageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [imageView, operatingMode, UIView()])
        stackView.alignment = .center
        stackView.spacing = 5
        addSubview(stackView)
        stackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 16, bottom: 0, right: 16))
        
        let label = UILabel()
        let attributedText = NSMutableAttributedString(string: "\nКомпания «Robustрой» – лидер в производстве и продаже высококачественных трубопроводных, дренажных систем, геотекстиля, а также труб и фитингов.", attributes: [.foregroundColor: UIColor.gray])
        
        attributedText.append(NSAttributedString(string: "\n\nБольше 10 лет мы предлагаем качественные и безопасные решения в области систем водоснабжения. Наша продукция успешно эксплуатируется тысячами строительных площадок и объектов по всей России.", attributes: [.foregroundColor: UIColor.gray]))
        
        attributedText.append(NSAttributedString(string: "\n\nНаша компания предлагает Вам трубопроводные системы ПНД, дренажные системы, геотекстиль, ПВХ и ПП трубы и фитинги. Продукция полностью отвечает всем требованиям российских и международных стандартов.", attributes: [.foregroundColor: UIColor.gray]))
        
        attributedText.append(NSAttributedString(string: "\n\nСобственные производственные и складские мощности позволяют поддерживать широкий ассортимент в наличии, а также непрерывно расширять свой продуктовый портфель. Данная возможность сокращает время выполнения Вашего заказа и его доставки на объект.", attributes: [.foregroundColor: UIColor.gray]))
        
        attributedText.append(NSAttributedString(string: "\n\nПрямое сотрудничество с множеством известных российских и зарубежных производителей комплектующих, позволяет нам оптимизировать коммерческие условия, гарантируя при этом высокое качество поставляемой продукции.", attributes: [.foregroundColor: UIColor.gray]))
        
        attributedText.append(NSAttributedString(string: "\n\nКоманда «Robustрой» – это профессионалы отрасли, чьему опыту доверяют ведущие строительные компании страны. Мы готовы ответить на все Ваши вопросы, рассказать о новинках и оказать квалифицированную помощь в правильном выборе для Вашей системы водоснабжения.", attributes: [.foregroundColor: UIColor.gray]))
        
        attributedText.append(NSAttributedString(string: "\n\nМы заботимся о наших клиентах, предлагая первоклассную продукцию, отличный сервис и различные программы лояльности.", attributes: [.foregroundColor: UIColor.gray]))
        
        attributedText.append(NSAttributedString(string: "\n\nКомпания «Robustрой» – ответственный партнер на Вашей стройке!", attributes: [.foregroundColor: UIColor.gray]))
        
        
        
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.attributedText = attributedText
        label.numberOfLines = 0
        
        self.aboutCompanyDescription = label
        
        addSubview(aboutCompanyDescription)
        aboutCompanyDescription.anchor(top: stackView.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 5, left: 16, bottom: 16, right: 16))
    }
}
