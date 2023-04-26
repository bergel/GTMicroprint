Class {
	#name : #Microprint,
	#superclass : #Object,
	#instVars : [
		'rules',
		'fileContent'
	],
	#category : #'GTMicroprint-Core'
}

{ #category : #accessing }
Microprint >> buildFromFilename: aFilename [
	^ self buildFromString: aFilename asFileReference contents
]

{ #category : #accessing }
Microprint >> buildFromString: aString [
	"This is the main public method"
	| container |
	container := (BlElement new)
		size: 1000 @ 2000;
		background: Color veryLightGray lighter lighter.
	fileContent := aString.
	fileContent lines doWithIndex: [:l :i |
		self buildFromString: l container: container line: i
	].
	^ container asScalableElement
]

{ #category : #accessing }
Microprint >> buildFromString: aString container: container line: lineIndex [
	| box trimedString nbOfSeparatorChars |
	trimedString := aString trimLeft.
	nbOfSeparatorChars := aString size - trimedString size.
	
	box := self createBox
				size: (trimedString size * 10) @ 10;
				background: (self colorOf: trimedString);
				relocate: (nbOfSeparatorChars * 10) @ (lineIndex * 10 - 2).
	box when: BlClickEvent do: [ :event | 
				| portion |
				portion := MicroprintPortion new 
								lineNumber: lineIndex; 
								fileContent: fileContent.
				event currentTarget phlow spawnObject: portion ].
	container addChild: box
	 
]

{ #category : #accessing }
Microprint >> colorOf: aString [ 
	rules do: [ :assoc |
		(aString matchesRegex: assoc key) ifTrue: [ ^ assoc value ]
	].
	^ Color gray
]

{ #category : #accessing }
Microprint >> createBox [
	^ (BlElement new)
			background: Color yellow
]

{ #category : #accessing }
Microprint >> example01 [
	<gtExample>
	^ Microprint new 
		buildFromString: '    hello
world
  Bonjour
       le monde.
       
Hello' 
]

{ #category : #accessing }
Microprint >> example02 [
	<gtExample>
	^ Microprint new 
		rule: '#.*' color: Color green;
		rule: 'name.*' color: Color yellow;
		rule: '- name.*' color: Color yellow;
		rule: 'timeout.*' color: Color red;
		rule: 'matrix.*\:' color: Color red;
		rule: 'uses\:' color: Color blue;
		
		buildFromFilename: '/Users/alexandrebergel/Desktop/GT/example_workflow2.yaml'

]

{ #category : #accessing }
Microprint >> initialize [
	rules := OrderedCollection new
]

{ #category : #accessing }
Microprint >> rule: patternString color: aColor [
	rules add: patternString -> aColor
]
