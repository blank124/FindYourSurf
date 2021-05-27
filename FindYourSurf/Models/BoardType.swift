//
//  BoardType.swift
//  FindYourSurf
//
//  Created by Michael Blank on 1/16/21.
//

import Foundation

struct BoardType {
    
    var newRec: Recommendation?
    
    func getBoardSize() -> String {
        return newRec?.size ?? "No Size"
    }
    
    mutating func calculateRecommendation(weight: Int, skillLevel: String, boardType: String) {
        
        switch boardType {
        case "SHORTBOARD":
            switch skillLevel {
            case "BEGINNER":
                switch true {
                case weight <= 45:
                    newRec = Recommendation(size: "6'2\"")
                case 45 < weight && weight <= 63:
                    newRec = Recommendation( size: "6'3\"")
                case  63 < weight && weight <= 72:
                    newRec = Recommendation(size: "6'6\"")
                case  72 < weight && weight <= 81:
                    newRec = Recommendation(size: "6'8\"")
                case  81 < weight && weight <= 90:
                    newRec = Recommendation(size: "7'2\"")
                case  90 < weight:
                    newRec = Recommendation(size: "+7'4\"")
                default:
                    newRec = nil
                }
            case "INTERMEDIATE":
                switch true {
                case weight <= 45:
                    newRec = Recommendation(size: "6'0\"")
                case 45 < weight && weight <= 63:
                    newRec = Recommendation(size: "6'2\"")
                case  63 < weight && weight <= 72:
                    newRec = Recommendation(size: "6'4\"")
                case  72 < weight && weight <= 81:
                    newRec = Recommendation(size: "6'6\"")
                case  81 < weight && weight <= 90:
                    newRec = Recommendation(size: "7'0\"")
                case  90 < weight:
                    newRec = Recommendation(size: "+7'2\"")
                default:
                    newRec = nil
                }
            default:
                newRec = nil
            }
        case "FISH":
            switch skillLevel {
            case "BEGINNER":
                switch true {
                case weight <= 45:
                    newRec = Recommendation(size: "6'1\"")
                case 45 < weight && weight <= 63:
                    newRec = Recommendation(size: "6'4\"")
                case  63 < weight && weight <= 72:
                    newRec = Recommendation(size: "6'8\"")
                case  72 < weight && weight <= 81:
                    newRec = Recommendation(size: "6'10\"")
                case  81 < weight && weight <= 90:
                    newRec = Recommendation(size: "7'4\"")
                case  90 < weight:
                    newRec = Recommendation(size: "+7'8\"")
                default:
                    newRec = nil
                }
            case "INTERMEDIATE":
                switch true {
                case weight <= 45:
                    newRec = Recommendation(size: "5'10\"")
                case 45 < weight && weight <= 63:
                    newRec = Recommendation(size: "6'1\"")
                case  63 < weight && weight <= 72:
                    newRec = Recommendation(size: "6'4\"")
                case  72 < weight && weight <= 81:
                    newRec = Recommendation(size: "6'6\"")
                case  81 < weight && weight <= 90:
                    newRec = Recommendation(size: "6'8\"")
                case  90 < weight:
                    newRec = Recommendation(size: "+7'4\"")
                default:
                    newRec = nil
                }
            default:
                newRec = nil
            }
        case "FUNBOARD":
            switch skillLevel {
            case "BEGINNER":
                switch true {
                case weight <= 45:
                    newRec = Recommendation(size: "7'2\"")
                case 45 < weight && weight <= 63:
                    newRec = Recommendation(size: "7'4\"")
                case  63 < weight && weight <= 72:
                    newRec = Recommendation(size: "7'6\"")
                case  72 < weight && weight <= 81:
                    newRec = Recommendation(size: "7'8\"")
                case  81 < weight && weight <= 90:
                    newRec = Recommendation(size: "7'8\"")
                case  90 < weight:
                    newRec = Recommendation(size: "+7'8\"")
                default:
                    newRec = nil
                }
            case "INTERMEDIATE":
                switch true {
                case weight <= 45:
                    newRec = Recommendation(size: "7'0\"")
                case 45 < weight && weight <= 63:
                    newRec = Recommendation(size: "7'2\"")
                case  63 < weight && weight <= 72:
                    newRec = Recommendation(size: "6'4\"")
                case  72 < weight && weight <= 81:
                    newRec = Recommendation(size: "7'6\"")
                case  81 < weight && weight <= 90:
                    newRec = Recommendation(size: "7'7\"")
                case  90 < weight:
                    newRec = Recommendation(size: "+7'8\"")
                default:
                    newRec = nil
                }
            default:
                newRec = nil
            }
        case "FOAMY":
            switch skillLevel {
            case "BEGINNER":
                switch true {
                case weight <= 45:
                    newRec = Recommendation(size: "9'2\"")
                case 45 < weight && weight <= 63:
                    newRec = Recommendation(size: "9'4\"")
                case  63 < weight && weight <= 72:
                    newRec = Recommendation(size: "9'6\"")
                case  72 < weight && weight <= 81:
                    newRec = Recommendation(size: "9'8\"")
                case  81 < weight && weight <= 90:
                    newRec = Recommendation(size: "9'9\"")
                case  90 < weight:
                    newRec = Recommendation(size: "+10'0\"")
                default:
                    newRec = nil
                }
            case "INTERMEDIATE":
                switch true {
                case weight <= 45:
                    newRec = Recommendation(size: "9'0\"")
                case 45 < weight && weight <= 63:
                    newRec = Recommendation(size: "9'2\"")
                case  63 < weight && weight <= 72:
                    newRec = Recommendation(size: "9'3\"")
                case  72 < weight && weight <= 81:
                    newRec = Recommendation(size: "9'4\"")
                case  81 < weight && weight <= 90:
                    newRec = Recommendation(size: "9'5\"")
                case  90 < weight:
                    newRec = Recommendation(size: "+10'0\"")
                default:
                    newRec = nil
                }
            default:
                newRec = nil
            }
        case "LONGBOARD":
            switch skillLevel {
            case "BEGINNER":
                switch true {
                case weight <= 45:
                    newRec = Recommendation(size: "9'2\"")
                case 45 < weight && weight <= 63:
                    newRec = Recommendation(size: "9'4\"")
                case  63 < weight && weight <= 72:
                    newRec = Recommendation(size: "9'6\"")
                case  72 < weight && weight <= 81:
                    newRec = Recommendation(size: "9'8\"")
                case  81 < weight && weight <= 90:
                    newRec = Recommendation(size: "9'9\"")
                case  90 < weight:
                    newRec = Recommendation(size: "+10'0\"")
                default:
                    newRec = nil
                }
            case "INTERMEDIATE":
                switch true {
                case weight <= 45:
                    newRec = Recommendation(size: "9'0\"")
                case 45 < weight && weight <= 63:
                    newRec = Recommendation(size: "9'2\"")
                case  63 < weight && weight <= 72:
                    newRec = Recommendation(size: "9'3\"")
                case  72 < weight && weight <= 81:
                    newRec = Recommendation(size: "9'4\"")
                case  81 < weight && weight <= 90:
                    newRec = Recommendation(size: "9'5\"")
                case  90 < weight:
                    newRec = Recommendation(size: "+10'0\"")
                default:
                    newRec = nil
                }
            default:
                newRec = nil
            }
        case "GUN":
            switch skillLevel {
            case "BEGINNER":
                switch true {
                case weight <= 45:
                    newRec = Recommendation(size: "10'4\"")
                case 45 < weight && weight <= 63:
                    newRec = Recommendation(size: "10'8\"")
                case  63 < weight && weight <= 72:
                    newRec = Recommendation(size: "11'3\"")
                case  72 < weight && weight <= 81:
                    newRec = Recommendation(size: "11'6\"")
                case  81 < weight && weight <= 90:
                    newRec = Recommendation(size: "11'8\"")
                case  90 < weight:
                    newRec = Recommendation(size: "+12'0\"")
                default:
                    newRec = nil
                }
            case "INTERMEDIATE":
                switch true {
                case weight <= 45:
                    newRec = Recommendation(size: "10'2\"")
                case 45 < weight && weight <= 63:
                    newRec = Recommendation(size: "10'6\"")
                case  63 < weight && weight <= 72:
                    newRec = Recommendation(size: "11'0\"")
                case  72 < weight && weight <= 81:
                    newRec = Recommendation(size: "11'4\"")
                case  81 < weight && weight <= 90:
                    newRec = Recommendation(size: "11'6\"")
                case  90 < weight:
                    newRec = Recommendation(size: "+11'10\"")
                default:
                    newRec = nil
                }
            default:
                newRec = nil
            }
        default:
            newRec = nil
        }
        
    }
}
