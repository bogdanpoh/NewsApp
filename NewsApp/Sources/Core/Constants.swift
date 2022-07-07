//
//  Constants.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 13.04.2021.
//

import Foundation
import Rswift

enum Constants {
    
    enum NewsApi {
        enum Countries: String, CaseIterable {
            case ae, ar, at, au, be, bg, br, ca, ch, cn, co, cu, cz, de, eg, fr, gb, gr, hk, hu, id, ie, il, `in`, it, jp, kr, lt, lv,
                 ma, mx, my, ng, nl, no, nz, ph, pl, pt, ro, rs, ru, sa, se, sg, si, sk, th, tr, tw, ua, us, ve, za
            
            #if os(iOS)
            var title: String {
                switch self {
                case .ae: return R.string.localizable.countryAe()
                case .ar: return R.string.localizable.countryAr()
                case .at: return R.string.localizable.countryAt()
                case .au: return R.string.localizable.countryAu()
                case .be: return R.string.localizable.countryBe()
                case .bg: return R.string.localizable.countryBg()
                case .br: return R.string.localizable.countryBr()
                case .ca: return R.string.localizable.countryCa()
                case .ch: return R.string.localizable.countryCh()
                case .cn: return R.string.localizable.countryCn()
                case .co: return R.string.localizable.countryCo()
                case .cu: return R.string.localizable.countryCu()
                case .cz: return R.string.localizable.countryCz()
                case .de: return R.string.localizable.countryDe()
                case .eg: return R.string.localizable.countryEg()
                case .fr: return R.string.localizable.countryFr()
                case .gb: return R.string.localizable.countryGb()
                case .gr: return R.string.localizable.countryGr()
                case .hk: return R.string.localizable.countryHk()
                case .hu: return R.string.localizable.countryHu()
                case .id: return R.string.localizable.countryId()
                case .ie: return R.string.localizable.countryIe()
                case .il: return R.string.localizable.countryIl()
                case .in: return R.string.localizable.countryIn()
                case .it: return R.string.localizable.countryIt()
                case .jp: return R.string.localizable.countryJp()
                case .kr: return R.string.localizable.countryKr()
                case .lt: return R.string.localizable.countryLt()
                case .lv: return R.string.localizable.countryLv()
                case .ma: return R.string.localizable.countryMa()
                case .mx: return R.string.localizable.countryMx()
                case .my: return R.string.localizable.countryMy()
                case .ng: return R.string.localizable.countryNg()
                case .nl: return R.string.localizable.countryNl()
                case .no: return R.string.localizable.countryNo()
                case .nz: return R.string.localizable.countryNz()
                case .ph: return R.string.localizable.countryPh()
                case .pl: return R.string.localizable.countryPl()
                case .pt: return R.string.localizable.countryPt()
                case .ro: return R.string.localizable.countryRo()
                case .rs: return R.string.localizable.countryRs()
                case .ru: return R.string.localizable.countryRu()
                case .sa: return R.string.localizable.countrySa()
                case .se: return R.string.localizable.countrySe()
                case .sg: return R.string.localizable.countrySg()
                case .si: return R.string.localizable.countrySi()
                case .sk: return R.string.localizable.countrySk()
                case .th: return R.string.localizable.countryTh()
                case .tr: return R.string.localizable.countryTr()
                case .tw: return R.string.localizable.countryTw()
                case .ua: return R.string.localizable.countryUa()
                case .us: return R.string.localizable.countryUs()
                case .ve: return R.string.localizable.countryVe()
                case .za: return R.string.localizable.countryZa()
                }
            }
            #endif
        }
        
        static let domainString = "https://newsapi.org/v2/top-headlines"
        static let apiKey: String = StorageKeys.newsApiKey
    }
    
}
