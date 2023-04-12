Class {
	#name : #BaselineOfGTMicroprint,
	#superclass : #BaselineOf,
	#category : #BaselineOfGTMicroprint
}

{ #category : #accessing }
BaselineOfGTMicroprint >> baseline: spec [
	<baseline>
	
	spec for: #common do: [
		spec package: 'GTMicroprint'
	]
]
