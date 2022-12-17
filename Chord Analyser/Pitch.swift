//
//  Pitch.swift
//  Chord Analyser
//
//  Created by Jeremy Lindsay on 15/12/2022.
//

import Foundation

// In MIDI 1.0, each note is assigned a numeric value, where middle C is 60.
//   Here, we call each numeric value in the range 0, ..., 128 a "key".
// There are 12 pitch classes.
//   0  <-> C
//   1  <-> C# ~ Db
//   2  <-> D
//   ...
//   11 <-> B

enum PitchClass : Int {
    case defaultPitchClass
    case c
    case csh
    case d
    case dsh
    case e
    case f
    case fsh
    case g
    case gsh
    case a
    case ash
    case b
    
    var name: String {
        switch self {
        case .c:   return "C"
        case .csh: return "D♭"
        case .d:   return "D"
        case .dsh: return "E♭"
        case .e:   return "E"
        case .f:   return "F"
        case .fsh: return "F#"
        case .g:   return "G"
        case .gsh: return "A♭"
        case .a:   return "A"
        case .ash: return "B♭"
        case .b:   return "B"
        default:   return "N/A"
        }
    }
}

extension PitchClass : Comparable {
    static func < (lhs: PitchClass, rhs: PitchClass) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
    static func == (lhs: PitchClass, rhs: PitchClass) -> Bool {
        lhs.rawValue == rhs.rawValue
    }
}

func toPClass(_ note: UInt32?) -> PitchClass {
    if let uNote = note {
        switch uNote % 12 {
        case 0:  return .c
        case 1:  return .csh
        case 2:  return .d
        case 3:  return .dsh
        case 4:  return .e
        case 5:  return .f
        case 6:  return .fsh
        case 7:  return .g
        case 8:  return .gsh
        case 9:  return .a
        case 10: return .ash
        case 11: return .b
        default: return .defaultPitchClass
        }
    } else {
        return .defaultPitchClass
    }
}

enum Interval {
    case unison
    case minSecond
    case majSecond
    case minThird
    case majThird
    case perfFourth
    case dimFifth
    case perfFifth
    case minSixth
    case majSixth
    case minSeventh
    case majSeventh
    case octave
    case defaultInterval
}

func toInterval(_ note1: Int, _ note2: Int) -> Interval {
    switch abs(note1 - note2) % 12 {
    case 0:  return Interval.unison
    case 1:  return Interval.minSecond
    case 2:  return Interval.majSecond
    case 3:  return Interval.minThird
    case 4:  return Interval.majThird
    case 5:  return Interval.perfFourth
    case 6:  return Interval.dimFifth
    case 7:  return Interval.perfFifth
    case 8:  return Interval.minSixth
    case 9:  return Interval.majSixth
    case 10: return Interval.minSeventh
    case 11: return Interval.majSeventh
    case 12: return Interval.octave
    default: return Interval.defaultInterval
    }
}

func toInterval(_ pClass1: PitchClass, _ pClass2: PitchClass) -> Interval {
    switch abs(pClass1.rawValue - pClass2.rawValue) % 12 {
    case 0:  return Interval.unison
    case 1:  return Interval.minSecond
    case 2:  return Interval.majSecond
    case 3:  return Interval.minThird
    case 4:  return Interval.majThird
    case 5:  return Interval.perfFourth
    case 6:  return Interval.dimFifth
    case 7:  return Interval.perfFifth
    case 8:  return Interval.minSixth
    case 9:  return Interval.majSixth
    case 10: return Interval.minSeventh
    case 11: return Interval.majSeventh
    case 12: return Interval.octave
    default: return Interval.defaultInterval
    }
}

// NOTE: an amount of 21 must first be subtracted from the
//       MIDI note's numeric value. For example, to get Middle C
//       on the phantom keyboard one should use midiToPhantomPiano[60 - 21].
let midiToPhantomKeyboardNote: [Int] =
    [
        // octave 0
        0, 1, 2,
        // octave 1
        4, 5, 6, 7, 8,
        10, 11, 12, 13, 14, 15, 16,
        // octave 2
        18, 19, 20, 21, 22,
        24, 25, 26, 27, 28, 29, 30,
        // octave 3
        32, 33, 34, 35, 36,
        38, 39, 40, 41, 42, 43, 44,
        // octave 4
        46, 47, 48, 49, 50,
        52, 53, 54, 55, 56, 57, 58,
        // octave 5
        60, 61, 62, 63, 64,
        66, 67, 68, 69, 70, 71, 72,
        // octave 6
        74, 75, 76, 77, 78,
        80, 81, 82, 83, 84, 85, 86,
        // octave 7
        88, 89, 90, 91, 92,
        94, 95, 96, 97, 98, 99, 100,
        // octave 8
        102
    ]
