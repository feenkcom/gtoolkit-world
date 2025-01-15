Extension { #name : #BrWithExplicitMenuAptitude }

{ #category : #'*GToolkit-Extensions' }
BrWithExplicitMenuAptitude >> handle: aHandleBlock stencil: aMenuBlock [
	menuContainer withCenterHandle.
	self stencil: [ (BrMenuExplicitHandle new
		handle: aHandleBlock;
		submenu: aMenuBlock) ]
]

{ #category : #'*GToolkit-Extensions' }
BrWithExplicitMenuAptitude >> withHandleSubmenu: aMenuBlock [
	menuContainer withCenterHandle.
	self stencil: [ (BrMenuExplicitHandle new
		submenu: aMenuBlock) ]
]
