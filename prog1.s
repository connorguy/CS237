*----------------------------------------------------------------------
* Programmer: Connor Guy
* Class Account: 
* Assignment or Title: Assignment 1
* Filename: prog1
* Date completed:  
*----------------------------------------------------------------------
* Problem statement:
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
start:  initIO                  * Initialize (required for I/O)
	setEVT			* Error handling routines
*	initF			* For floating point macros only	

	* Get user input
	lineout		title
	lineout		prompt1
	linein		buffer
	
	* Take out the year in the string
	cvta2		buffer+6,#4
	move.l		D0,D1	*copy of users age
	
	* Subtract age from 2016 and stripp result stored in age
	move.l		#2016,D2
	sub.l		D1,D2	*users age
	move.l		D2,D0	*cvt2a only reads from D0
	cvt2a		age,#3
	stripp		age,#3
	
	* Move last part of the output string in place
	lea		age,A0
	adda.l		D0,A0
	move.b		#' ',(A0)
	adda.l		#1,A0
	move.b		#'y',(A0)
	adda.l		#1,A0
	move.b		#'e',(A0)
	adda.l		#1,A0
	move.b		#'a',(A0)
	adda.l		#1,A0
	move.b		#'r',(A0)
	adda.l		#1,A0
	move.b		#'s',(A0)
	adda.l		#1,A0
	move.b		#' ',(A0)
	adda.l		#1,A0
	move.b		#'o',(A0)
	adda.l		#1,A0
	move.b		#'l',(A0)
	adda.l		#1,A0
	move.b		#'d',(A0)
	adda.l		#1,A0
	move.b		#'*',(A0)
	adda.l		#1,A0
	clr.b		(A0) *null terminate the string
	
	* Change length of stars
	lea		stars+32,A1
	adda.l		D0,A1
	clr.b		(A1) *null terminate stars
	
	
	
	
	lineout		stars
	lineout		answer1
	lineout		stars

        break                   * Terminate execution
*
*----------------------------------------------------------------------
*       Storage declarations
title:		dc.b	'Program #1, cssc0683, Connor Guy',0
stars:		dc.b	'***********************************'
prompt1:	dc.b	'Enter your date of birth (MM/DD/YYYY):',0
buffer:		ds.b	80
thisYear:	dc.w	'2016'
answer1:	dc.b	'*In 2016 you will be '
age:		ds.b	8
        end
