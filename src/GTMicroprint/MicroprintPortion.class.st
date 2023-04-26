Class {
	#name : #MicroprintPortion,
	#superclass : #Object,
	#instVars : [
		'lineNumber',
		'allFileContent'
	],
	#category : #'GTMicroprint-Core'
}

{ #category : #accessing }
MicroprintPortion >> fileContent [
	^ allFileContent
]

{ #category : #accessing }
MicroprintPortion >> fileContent: aFileContentAsString [
	allFileContent := aFileContentAsString
]

{ #category : #accessing }
MicroprintPortion >> gtPrintFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Print';
		priority: 110;
		aptitude: BrGlamorousCodeEditorAptitude;
		text: [ self textPortion asRopedText ];
		actionUpdateButton
]

{ #category : #accessing }
MicroprintPortion >> lineNumber [
	^ lineNumber
]

{ #category : #accessing }
MicroprintPortion >> lineNumber: aNumber [
	lineNumber := aNumber
]

{ #category : #accessing }
MicroprintPortion >> textPortion [
	| allLines relevantLines |
	allLines := allFileContent lines.
	relevantLines := allLines copyFrom: ((lineNumber - 5) max: 1) to: ((lineNumber + 5) min: allLines size).
	^ String cr join: relevantLines
]
