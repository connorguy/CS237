*----------------------------------------------------------------------
* Programmer: Connor Guy
* Class Account: cssc0683
* Assignment or Title: program 4
* Filename: fib
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

      ORG     $7000

** initialize registers
fib:  link      A6,#0
      movem.l   D1/D2,-(SP)
      move.w    8(A6),D1
      
      ** If 1 or 0 branch
      TST.w     D1
      BNE       checkOne
      clr.l	D0
      BRA	out
      
checkOne:
      cmpi.w    #1,D1
      BNE	recurse
      moveq	#1,D0
      BRA	out

      
** Call fib recusrsively twice
recurse:
      subq.w	#1,D1
      move.w	D1,-(SP)
      JSR	fib
      adda.l	#2,SP
      move.l	D0,D2	*fib(n-1)
      
      ** Second Call fib(n-2)
      subq	#1,D1
      move.w	D1,-(SP)
      JSR	fib
      adda.l	#2,SP
      
      ** fib(n-1) + fib(n-2)
      add.l	D2,D0
      
out:  
      movem.l   (SP)+,D1/D2
      unlk	A6
      rts

        end
