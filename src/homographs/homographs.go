// go:generate go run generate_confusables.go

package homographs

import (
	"unicode/utf8"

	"golang.org/x/text/unicode/norm"
)

// Skeleton converts a string to it's "skeleton" form
// 	See http://www.unicode.org/reports/tr39/#Confusable_Detection
func Skeleton(s string) string {
	// Convert s to NFD format
	s = norm.NFD.String(s)
	// Successively map each source character in s to the target string
	for i, w := 0, 0; i < len(s); i += w {
		char, width := utf8.DecodeRuneInString(s[i:])
		// Use the confusables generated map
		replacement, exists := confusablesMap[char]
		if exists {
			s = s[:i] + replacement + s[i+width:]
			w = len(replacement)
		} else {
			w = width
		}
	}
	// Reapply NFD
	return norm.NFD.String(s)
}

// Returns true if two strings have the same skeleton (could be confused)
func Confusable(x, y string) bool {
	return Skeleton(x) == Skeleton(y)
}
