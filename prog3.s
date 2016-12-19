	  *----------------------------------------------------------------------
* Programmer: Connor Guy
* Class Account: cssc0683
* Assignment or Title: prog3
* Filename: prog3
* Date completed: 11/14/2016
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

	lineout	title

getnum:	lineout	prompt1
	linein	buffer
	*Validate what has been entered as valid
	stripp	buffer,D0
	cmpi.l	#4,D0
	BHI	bad
	move.l	D0,D1
	TST.w	D1
	BEQ	bad
	
	subq.w	#1,D1 *0 based so -1
	lea	buffer,A0
	
loop:	cmpi.b	#'0',(A0)
	BLO	bad
	cmpi.b	#'9',(A0)+ *increments address pointer
	BHI	bad
	dbra	D1,loop *decrement and check if -1
	cvta2	buffer,D0
	cmpi.l	#3999,D0
	BHI	bad
	tst.l	D0
	BLE	bad
	BRA	setup
	
	*If user has entered an invalid entry
	*Show prompt and branch
bad:	lineout	badprompt
	bra	getnum
	
setup:	lea	buffer,A2
	
	*if(x>1000)
M:	cmpi.l	#1000,D0
	BLT	CM
	sub.l	#1000,D0
	move.b	#'M',(A2)+
	BRA	M
	
	*if(x>900)
CM:	cmpi.l	#900,D0
	BLT	D
	sub.l	#900,D0
	move.b	#'C',(A2)+
	move.b	#'M',(A2)+

	*if(x>500)
D:	cmpi.l	#500,D0
	BLT	CD
	sub.l	#500,D0
	move.b	#'D',(A2)+
	
	*if(x>400)
CD:	cmpi.l	#400,D0
	BLT	C
	sub.l	#400,D0
	move.b	#'C',(A2)+
	move.b	#'D',(A2)+
	
	*if(x>100)
C:	cmpi.l	#100,D0
	BLT	XC
	sub.l	#100,D0
	move.b	#'C',(A2)+
	BRA	C

	*if(x>90)
XC:	cmpi.l	#90,D0
	BLT	L
	sub.l	#90,D0
	move.b	#'X',(A2)+
	move.b	#'C',(A2)+
	
	*if(x>50)
L:	cmpi.l	#50,D0
	BLT	XL
	sub.l	#50,D0
	move.b	#'L',(A2)+
	BRA	L

	*if(x>40)
XL:	cmpi.l	#40,D0
	BLT	X
	sub.l	#40,D0
	move.b	#'X',(A2)+
	move.b	#'L',(A2)+
	
	*if(x>10)
X:	cmpi.l	#10,D0
	BLT	IX
	sub.l	#10,D0
	move.b	#'X',(A2)+
	BRA	X

	*if(x>9)
IX:	cmpi.l	#9,D0
	BLT	V
	sub.l	#9,D0
	move.b	#'X',(A2)+
	move.b	#'L',(A2)+

	*if(x>5)
V:	cmpi.l	#5,D0
	BLT	IV
	sub.l	#5,D0
	move.b	#'V',(A2)+
	BRA	V

	*if(x>4)
IV:	cmpi.l	#4,D0
	BLT	I
	sub.l	#4,D0
	move.b	#'I',(A2)+
	move.b	#'V',(A2)+
	
	*if(x>1)
I:	cmpi.l	#1,D0
	BLT	ansout
	sub.l	#1,D0
	move.b	#'I',(A2)+
	BRA	I
	
ansout:	clr.b	(A2)
	lineout	answeris
	lineout	buffer
	
	*Ask if user want to enter new number
again:	lineout	newnum
	linein	buffer
	cmpi.b	#1,D0
	BNE	inval
	ori.b	#$20,buffer
	cmpi.b	#'n',buffer
	BEQ	done
	cmpi.b	#'y',buffer
	BEQ	getnum
inval:	lineout	badYorN
	BRA	again
	
done:
	


        break                   * Terminate execution
*
*----------------------------------------------------------------------
*       Storage declarations

title:		dc.b	'* Program #3, cssc0683, Connor Guy *',0
prompt1:	dc.b	'Enter a number in the range 1 . . 3999',0
buffer:		ds.b	80
badprompt:	dc.b	'The number you entered is invalid,',0
newnum:		dc.b	'Do you want to convert another number?',0
badYorN:	dc.b	'Please enter Y/N.',0
answeris:	dc.b	'The roman numeral equivalent is '
        end
