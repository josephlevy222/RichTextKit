//
//  RichTextViewComponent+Color.swift
//  RichTextKit
//
//  Created by Daniel Saidi on 2024-02-14.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import Foundation
#if iOS
import UIKit
#endif
public extension RichTextViewComponent {

    /// Get the superscript level.
    var richTextSuperscriptLevel: Int? {
        #if macOS
        richTextAttribute(.superscript)
        #else
		richTextAttributes(at: selectedRange)[.baselineOffset] as? Int
        #endif
    }

    /// Set the superscript level.
    func setRichTextSuperscriptLevel(to val: Int) {
        #if macOS
        setRichTextAttribute(.superscript, to: val)
        #else
        print("Faking the unsupported platform")
		let baseline = richTextAttributes(at: selectedRange)[.baselineOffset] as? CGFloat
		if val == 0 {
			if baseline != 0 { // increase font size
				if let uiFont = richTextAttributes(at: selectedRange)[.font] as? UIFont {
					let biggerFont = UIFont(descriptor: uiFont.fontDescriptor, size: uiFont.pointSize/0.75)
					setRichTextAttribute(.font, to: biggerFont, at: selectedRange)
				} else { print("Unsupported font for superscripts")}
			}
		} else {
			if baseline == 0 { // decrease font size
				if let uiFont = richTextAttributes(at: selectedRange)[.font] as? UIFont {
					let smallerFont = UIFont(descriptor: uiFont.fontDescriptor, size: uiFont.pointSize*0.75)
					setRichTextAttribute(.font, to: smallerFont, at: selectedRange)
				} else { print("Unsupported font for superscripts")}
			}
		}
		setRichTextAttribute(.baselineOffset, to: val)
        #endif
    }

    /// Step the superscript level.
    func stepRichTextSuperscriptLevel(points: Int) {
        let currentSize = richTextSuperscriptLevel ?? 0
        let newSize = currentSize + points
        setRichTextSuperscriptLevel(to: newSize)
    }
}
