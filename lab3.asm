; Title: lab 3
; Name: Rimma Esheva

INCLUDE Irvine32.inc

.data
str1 BYTE "Enter hour of get up time (0-23): ", 0 ; prompt the user for GOB hour
str2 BYTE "Enter minutes of get up time (0-59): ",0 ; prompt the user for GOB mins
str3 BYTE "Enter number of minutes to snooze (0-59): ", 0 ; prompt the user for snooze mins
str4 BYTE "Alarm set for ", 0
str5 BYTE " hour and ", 0
str6 BYTE " minutes", 0
.code
main PROC
    ; prompt the user for get out of bed hour
    mov edx, OFFSET str1
    call WriteString
    call ReadInt

    ; prompt the user for get out of bed minute
    mov edx, Offset str2
    call writeString
    call readInt
   
    ; prompt the user for snooze minute
    mov edx, offset str3
    call writeString
    call readInt
   
    ; calculate the time for the alarm to go off
    mov ebx, eax ; save the minute of the alarm
    mov ecx, eax ; save the hour of the alarm
    mov eax, 60
    mul ecx ; convert hour to minute
    add eax, ebx ; add the minute to the total
    mov ecx, eax ; save the total in ecx
    sub eax, edx ; subtract snooze time from the total
   
    ; convert result back to hrs and mins
    mov ebx, 60
    xor edx, edx
    div ebx
   
    ; 4. print the alarm time as hours and minutes
    mov edx, offset str4
    call writeString
    call WriteInt
    mov edx, offset str5
    call writeString
    mov eax, ecx ; get the hour of the alarm
    call WriteInt
    mov edx, offset str6
    call writeString
    mov eax, ebx ; get the minute of the alarm
    call WriteInt
    exit
main ENDP

END main
