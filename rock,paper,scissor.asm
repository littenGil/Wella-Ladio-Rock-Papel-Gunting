.model small
.stack 100h

.data
    _Input db 0
    _ComputerNum db 0
    _PlayerNum db 0
    _newline db 0Ah, 0Dh, '$'

    _title db '           ROCK , PAPER , SCISSOR  $'
    _chrock db '     [1] ROCK $'
    _chpaper db '     [2] PAPER $'
    _chscissor db '     [3] SCISSOR $'
    _chquit db '     [4] Quit $'
    _rock db 'ROCK $'
    _paper db 'PAPER $'
    _scissor db 'SCISSOR $'
    _player db '   Player:  $'
    _computer db '    Computer: $'

    _lose db '   YOU LOSE $'
    _win db '    YOU WIN $'
    _draw db '   ITS A DRAW $'

    _again db '(Press any key to restart) $' 
    _error db ' Invalid Input $'
    _thanks db '           THANKS FOR PLAYING :)  from:Monmon $'
.code
main:
    mov ax, @data
    mov ds, ax
    call clrscr
home:
    call printTitle
    lea dx,_chrock
    call print
    lea dx, _newline
    call print

    lea dx,_chpaper
    call print
    lea dx, _newline 
    call print 

    lea  dx,_chscissor
    call print
    lea dx, _newline 
    call print
    call scan
    mov _PlayerNum, al
;Reload Screen
    call printTitle
;Test Player Rock
    cmp _PlayerNum,1
    jne playerNotRock
    lea dx,_player
    call print 
    lea dx,_rock 
    call print 
    jmp computerNum 
  playerNotRock:
;Test Player Paper   
    cmp _PlayerNum,2
    jne playerNotPaper
    lea dx,_player
    call print 
    lea dx,_paper
    call print 
    jmp computerNum 
  playerNotPaper:
;Test Player Scissor 
    cmp _PlayerNum,3
    jne playerNotScissor
    lea dx,_player
    call print 
    lea dx,_scissor
    call print 
    jmp computerNum 
  playerNotScissor:
;Test Player Quit
    cmp _PlayerNum,4
    jne playerNotQuit
    call clrscr 
    lea dx, _thanks
    call print
    mov ah, 4Ch           
    int 21h         
    
  playerNotQuit:
  call clrscr
  lea dx, _error
  call print
  call scan
  jmp home
;Computer Side
  computerNum:
;Produce Computer Hand
    mov ah, 0
    int 1ah
    mov ax,dx
    mov dx,0
    mov bx,3
    div bx
    add dl,1
    mov _ComputerNum, dl

;test computer rock
    cmp _ComputerNum,1
    jne computerNotRock
    lea dx,_computer
    call print 
    lea dx,_rock 
    call print 
    ;test draw win lose
    cmp _playerNum,1
    jne notDraw1
    call draw
    notDraw1:
    cmp _playerNum,3
    je lose
    jne win
  computerNotRock:

  ;test computer paper
    cmp _ComputerNum,2
    jne computerNotPaper
    lea dx,_computer
    call print 
    lea dx,_paper
    call print 
    ;test draw win lose
    cmp _playerNum,2
    jne notDraw2
    call draw
    notDraw2:
    cmp _playerNum,1
    je lose
    jne win
  computerNotPaper:

  ;test computer scissor
    cmp _ComputerNum,3
    jne computerNotScissor
    lea dx,_computer
    call print 
    lea dx,_scissor 
    call print 
    ;test draw win lose
    cmp _playerNum,3
    jne notDraw3
    call draw
    notDraw3:
    cmp _playerNum,2
    je LOSE
    jne win
  computerNotScissor:

win:
    lea dx,_newline
    call print
    call print
    lea dx,_win
    call print      
    call scan
    jmp home

lose:
    lea dx,_newline
    call print
    call print
    lea dx,_lose
    call print
    call scan
    jmp home    
       
draw:
    lea dx,_newline
    call print
    call print
    lea dx,_draw
    mov ah, 09h         
    int 21h   
    call scan
    jmp home    

print:
    mov ah, 09h         
    int 21h       
    ret       

printTitle:
    call clrscr
    lea dx,_title
    call print
    lea dx,_newline
    call print
    call print    
    ret 

scan:
    mov ah, 08h
    int 21h    
    sub al,'0'
    ret       


clrscr proc
    mov ah, 00h          
    mov al, 03h          
    int 10h
    ret


end main