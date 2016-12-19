*----------------------------------------------------------------------
* Programmer: Connor Guy
* Class Account: cssc0683
* Assignment or Title: Assignment 1
* Filename: prog2
* Date completed: 10/27/16
*----------------------------------------------------------------------
* Problem statement: Compute the sum given a data file.
* Input: 
* Output: 
* Error conditions tested: 
* Included files: 
* Method and/or pseudocode: 
* References: 
*----------------------------------------------------------------------
*
        ORG     $0
        DC.L    $3000           * Stack pointer value after a reset
        DC.L    start           * Program counter value after a reset
        ORG     $3000           * Start at location 3000 Hex
*
*----------------------------------------------------------------------
*
#minclude /home/cs/faculty/riggins/bsvc/macros/iomacs.s
#minclude /home/cs/faculty/riggins/bsvc/macros/evtmacs.s
*
*----------------------------------------------------------------------
*
* Register use
*
*----------------------------------------------------------------------
*


DATA: equ	$6000
a:	equ	DATA
b:	equ	a+2
c:	equ	b+2
d:	equ	c+2
e:	equ	d+2
f:	equ	e+2
X:	equ	f+2
Y:	equ	X+2
Z:	equ	Y+2

start:  initIO                  * Initialize (required for I/O)
	setEVT			* Error handling routines
*	initF			* For floating point macros only

	lineout	title
	
	* make X Y Z easy to use
	move.w	X,D5
	move.w	Y,D6
	move.w	Z,D7

	*ax^3 -> D1
	move.w	D5,D1
	muls	D5,D1
	muls	D5,D1
	move.w	a,D2
	muls	D2,D1
	
	*2bY^3 -> D2
	move.w	b,D2
	muls	#2,D2
	move.w	D6,D3
	muls	D6,D3
	muls	D6,D3
	muls	D3,D2
	
	add.w	D2,D1
	
	*cZ^2 -> D2
	move.w	D7,D3
	muls	D7,D3
	muls	c,D2
	
	add.w	D2,D1
	
	*dX^2 -> D2
	move.w	d,D3
	move.w	D5,D4
	muls	D5,D4
	muls	D3,D4
	move.w	D4,D2	*D4 = dX^2
	muls	D6,D2
	
	sub.w	D2,D1
	
	*eY^2 -> D2
	move.w	D6,D2
	muls	D6,D2
	muls	e,D2
	
	add.w	D4,D2
	
	*fXb + D2
	move.w	D5,D3
	muls	f,D3
	muls	b,D3
	add.w	D3,D2
	
	divs	D2,D1
	
	*Second section of the equation, D1 retains first part
	
	*3Z^2 -> D2
	move.w	D7,D2
	muls	D7,D2
	muls	#3,D2
	
	add.w	D2,D1
	
	*2ad -> D2
	move.w	a,D2
	muls	d,D2
	muls	#2,D2
	
	sub.w	D2,D1
	
	*Third section (Mod 100), D1 retains all prior
	move.w	D1,D0
	ext.l	D0
	divs	#100,D0
	
	*Convert sum and put into answer
	swap	D0
	ext.l	D0
	cvt2a	answer,#6
	stripp	answer,#6
	lea	answer,A1
	adda.l	D0,A1
	clr.b	(A1)
	
	lineout	output
	
		


        break                   * Terminate execution
*
*----------------------------------------------------------------------
*       Storage declarations
title:		dc.b	'Program #2, cssc0683, Connor Guy',0
output:		dc.b 	'The answer is: '
answer:		dc.b	10

        end
