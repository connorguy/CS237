*----------------------------------------------------------------------
* Programmer: Connor Guy
* Class Account: cssc0683
* Assignment or Title: prog4
* Filename: prog4
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
fib:	EQU	$7000
start:  initIO                  * Initialize (required for I/O)
	setEVT			* Error handling routines
*	initF			* For floating point macros only	

	lineout	title
	lineout	prompt1
	linein	buffer
	cvta2	buffer,D0
	
	** Push parameter on stack
	move.w	D0,-(SP)
	
	** Jump to subroutine
	JSR	fib
	
	** Pop paremeter off the stack
	adda.l	#2,SP
	
        cvt2a	buffer,#10
	stripp	buffer,#10
	lea	buffer,A1
	adda.l	D0,A1	
	clr.b	(A1)
	
	lineout	answer1
	
        break                   * Terminate execution
*
*----------------------------------------------------------------------
*       Storage declarations

title:		dc.b	'Program #4, cssc0683, Connor Guy',0
prompt1:	dc.b	'Enter a number:',0
answer1:	dc.b	'The fibonacci number is '
buffer:		ds.b	80


        end
