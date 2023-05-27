INCLUDE Irvine32.inc

.data
; MENU VARIABLES
menuHeader BYTE "*** MAIN MENU ***", 0
selectionPrompt BYTE "Please select one of the following:", 13, 10, 0
menu1 BYTE "1. Display my available credit", 13, 10, 0
menu2 BYTE "2. Add credits to my account", 13, 10, 0
menu3 BYTE "3. Play the guessing game", 13, 10, 0
menu4 BYTE "4. Display my statistics", 13, 10, 0
menu5 BYTE "5. To exit", 13, 10, 0
choice DWORD 0
menuExecute BYTE "Executing choice #", 0

; WELCOME VARIABLES
NAME_MAX = 15
nameString BYTE NAME_MAX + 1 DUP(? )
welcomeString BYTE "Please enter your name: ", 0

; DISPLAY CREDIT VARIABLES
displayCreditPrompt BYTE "Your available balance is: $ ", 0

; GENERAL VARIABLES
promptBad BYTE "Invalid input, please enter again", 13, 10, 0
credits DWORD 0


.code

; ==== = main ============================================ =
main PROC
CALL welcomeMessage; Welcome message for user

menuLoop : ; Begin menu loop

CALL menuTime; Display menu, get user choice

CALL executeChoice; Execute user choice

jmp menuLoop; Jump back to menu loop

exit
main ENDP; End main

; ==== = welcomeMessage ================================== =
welcomeMessage PROC; welcomeMessage start

mov edx, OFFSET welcomeString
call WriteString; Display prompt for user's name

mov edx, OFFSET nameString
mov ecx, NAME_MAX
call ReadString; Get user name, save in nameString

ret
welcomeMessage ENDP; end welcomeMessage

; ==== = menuTime ========================================
menuTime PROC; menuTime start
Call Clrscr; Clear screen

mov edx, OFFSET menuHeader
call WriteString; Display menu header

call Crlf

mov edx, OFFSET selectionPrompt
call WriteString; Display all menu selection choices

call Crlf

mov edx, OFFSET menu1
call WriteString

mov edx, OFFSET menu2
call WriteString

mov edx, OFFSET menu3
call WriteString

mov edx, OFFSET menu4
call WriteString

mov edx, OFFSET menu5
call WriteString


read : ; begin read loop
call ReadInt
cmp eax, 1
jb badInput
cmp eax, 5
ja badInput; Get user input, decide if bad or not

jmp endCheck; When input is good jump to endCheck

badInput :
mov edx, OFFSET promptBad
call WriteString
jmp read; Display if input is bad, jump to beginning of read loop

endCheck :
mov choice, eax
call WriteInt; Save input in choice,

ret
menuTime ENDP; End menuTime

; ==== = executeChoice ======================================
executeChoice PROC; Start executeChoice
CALL Clrscr; Clear screen

MOV eax, choice; Save choice in eax

CMP eax, 1; Jump to whichever choice
je choice1

CMP eax, 2
je choice2

CMP eax, 3
je choice3

CMP eax, 4
je choice4

CMP eax, 5
je choice5

choice1 :
CALL displayCredit
jmp endChoice

choice2 :
; call choice 2
jmp endChoice

choice3 :
; call choice 3
jmp endChoice

choice4 :
; call choice 4
jmp endChoice

choice5 :
exit; If choice is 5, end program
jmp endChoice

endChoice :
ret
executeChoice ENDP; End executeChoice

; ==== = displayCredit ======================================
displayCredit PROC; Start displayCredit
MOV edx, OFFSET displayCreditPrompt
MOV eax, credits

CALL WriteString; Display prompt
CALL WriteDec; Display credits

mov eax, 50
CALL Delay; Delay 50ms

CALL Crlf

CALL WaitMsg; Press any button to continue
ret
displayCredit ENDP; End displayCredit

end main

