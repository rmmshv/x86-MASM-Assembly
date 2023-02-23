TITLE  Lab 5: Calculate alarm time with loops
		
; Name: Rimma Esheva

; Sample program output:
; Enter hour of get up time: 7
; Enter minute of get up time: 20
; Enter number of minutes of snooze: 20
; Alarm set for 07:00
; Enter hour of get up time: 11
; Enter minute of get up time: 15
; Enter number of minutes of snooze: 20
; Alarm set for 10:55
; Enter hour of get up time: 1
; Enter minute of get up time: 20
; Enter number of minutes of snooze: 60
; Must be 0-59
; Enter number of minutes of snooze: 99
; Must be 0-59
; Enter number of minutes of snooze: 58
; Alarm set for 00:22
; Enter hour of get up time: 0
; Enter minute of get up time: 0
; Enter number of minutes of snooze: 30
; Can't go to previous day
; Enter hour of get up time:



INCLUDE Irvine32.inc

.data
prompt1		byte	"Enter hour of get up time (0-23): ", 0				; prompt the user for GOB hour
prompt2		byte	"Enter minutes of get up time (0-59): ",0			; prompt the user for GOB mins
prompt3		byte	"Enter number of minutes to snooze (0-59): ", 0		; prompt the user for snooze mins
alarm1		byte	"Alarm set for ", 0									; final output 1/2		
alarm2		byte	":", 0												; final output 2/2
err_minutes	byte	"Must be 0-59", 0									; invalid mins input error msg
err_hrs		byte	"Must be 0-23", 0									; invalid hrs input error msg
err_day		byte	"Can't go to previous day, please try again", 0		; invalid alarm time error msg

.code
main PROC

; prompt the user for get out of bed hour, loop untill the input is valid
	get_hour:
	mov edx, offset prompt1						
	call writeString
	call readDec
	cmp eax, 0		
	jl err_hrs_input
	cmp eax, 23
	jg err_hrs_input

; convert input hrs to mins
	mov ecx, eax	; store gob hr in ecx
	mov ebx, 60		; store 60 in ebx
	mul ebx			; multiply input hrs x 60
	mov ecx, eax	; save result in ecx for later
	jmp get_mins
	
; prompt the user for input mins, loop untill the input is valid
	get_mins:
	mov edx, Offset prompt2						
	call writeString
	call readDec
	cmp eax, 0
	jl err_mins_input
	cmp eax, 59
	jg err_mins_input

	add eax, ecx	; add input mins to input hrs from prev step
	mov ecx, 0		
	mov ecx, eax	; store updated result in ecx
	jmp get_snooze

; prompt the user for snooze mins, loop untill the input is valid
	get_snooze:
	mov edx, offset prompt3						
	call writeString
	call readDec
	cmp eax, 0
	jl err_snooze_mins
	cmp eax, 59
	jg err_snooze_mins
	
	sub ecx, eax	; subtract snooze mins from the alarm time
	js err_alarm_day
	mov eax, ecx	; save result in eax

; convert result back to hrs and mins to print our later
	mov ebx, 60
	xor edx, edx
	div ebx

	mov esi, eax	; hours
	mov ecx, edx	; mins

	
; print the result
	mov edx, offset alarm1
	call writeString
	mov eax, esi	; hours
	call writeDec
	mov edx, offset alarm2
	call writeString
	mov eax, ecx	; mins
	call writeDec
	call crlf
	call crlf
	jmp get_hour	; loop back to prompt the user again

; alarm hr less than 10
	hr_format:

; invalid GOB hour input
	err_hrs_input:
	mov edx, offset err_hrs
	call writeString
	call crlf
	jmp get_hour

; invalid GOB mins input
	err_mins_input:
	mov edx, offset err_minutes
	call writeString
	call crlf
	jmp get_mins

; invalid GOB snooze input
	err_snooze_mins:
	mov edx, offset err_minutes
	call writeString
	call crlf
	jmp get_snooze

; invalid alarm day
	err_alarm_day:
	mov edx, offset err_day	; display error message
	call writeString
	call crlf
	call crlf
	jmp get_hour			; prompt the user for correct alarm time

	exit
main ENDP

END main
