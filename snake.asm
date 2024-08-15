org 0x7C00              ; Address denoting it should run in the boot sector
jmp setup_game

;; CONSTANTS
VIDMEM      equ  0x0B800 ; Address denoting the memory for video (common address of video memory)
SCREENW     equ 80      ; Screen width 80 chars
SCREENH     equ 25      ; Screen height 25 chars
WINCOND     equ 10      ; Win condition 10 chars
BGCOLOR     equ 0x1020  ; Background color
APPLECLR    equ 0x4020  ; Apple color
SNAKECLR    equ 0x2020  ; Snake color
TIMER       equ 0x046C  ; Timer interval
SNAKEXARRAY equ 0x1000  ; Memory starting for the snake x coordinates
SNAKEYARRAY equ 0x2000  ; Memory starting for the snake y coordinates

;; VARIABLES
playerX:      dw 40     ; Player x coordinate
playerY:      dw 12     ; Player y coordinate
appleX :      dw 16     ; Apple x coordinate
appleY :      dw 9      ; Apple y coordinate
direction :   db 4     ; Direction
snakeLength:  dw 1     ; Snake length

;; LOGIC  
setup_game:
  ;; Set video mode - VGA mode 03h (80x25 text mode, 16 colors)
  mov ax, 0x0003
  int 0x10                ; Invoke BIOS video interrupt

  ;; Clear the screen (Text Mode)
  mov ah, 0x06            ; Function to scroll up the entire screen
  mov al, 0x00            ; Scroll up
  mov bh, 0x00            ; Attribute for the entire screen (black on black)
  mov cx, 0x0000          ; Upper left corner
  mov dx, 0x184F          ; Lower right corner (80x25)
  int 0x10                ; Invoke BIOS interrupt to clear the screen

  ;; Boot sector padding
times 510 - ($ - $$) db 0   ; Fill the rest of the boot sector with zeros
dw 0xAA55                  ; Boot sector signature

