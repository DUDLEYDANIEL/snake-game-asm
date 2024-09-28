org 0x7C00              ; Address denoting it should run in the boot sector
jmp setup_game

;; CONSTANTS
VIDMEM      equ  0x0B800 ; Address denoting the memory for video (common address of video memory)
SCREENW     equ 80      ; Screen width 80 chars
SCREENH     equ 25      ; Screen height 25 chars
BGCOLOR     equ 0x0100   ; Background color blue
APPLECLR    equ 0x4020   ; Apple color
SNAKECLR    equ 0x2020   ; Snake color
TIMER       equ 0x046C   ; Timer interval
SNAKEXARRAY equ 0x1000   ; Memory starting for the snake x coordinates
SNAKEYARRAY equ 0x2000   ; Memory starting for the snake y coordinates

;; VARIABLES
playerX:      dw 40     ; Player x coordinate
playerY:      dw 12     ; Player y coordinate
appleX :      dw 16     ; Apple x coordinate
appleY :      dw 9      ; Apple y coordinate
direction:     db 4      ; Direction
snakeLength:  dw 1      ; Snake length

;; LOGIC  
setup_game:
  ;;  Set video mode - VGA mode 03h (80x25 text mode, 16 colors)
      mov ax, 0x0003
      int 0x10                ; Invoke BIOS video interrupt

  ;;  Clear the screen with the background color
      mov ax, 0x0B800   ; Segment for video memory
      mov es, ax
      xor di, di        ; Start at the beginning of the video memory
      mov cx, SCREENH * SCREENW ; Total characters on the screen
      mov al, 0x20      ; Space character (ASCII code)
      mov ah, 0x01      ; Blue background, white foreground
      rep stosw         ; Fill the screen with spaces and background color

  ;;  set 1st snake segment "head"
      mov ax, [playerX]
      mov word [SNAKEXARRAY], ax
      mov ax, [playerY]
      mov word [SNAKEYARRAY], ax

  ;;  hide the cursor
      mov ax, 0x02
      mov dx, 0x2600 ;; DX -> DH & DL  ==> DH = 0x26 DL = 0x26
      int 0x10  ;; interupt to execite the hide cursor function

  ;; Set cursor position to center of screen
      mov ax, 0x0200 ; Set cursor position function
      mov bx, 0      ; Page number
      mov dx, 0x0C   ; Row (12 in decimal, center for 25 lines)
      mov cx, 0x28   ; Column (40 in decimal, center for 80 columns)
      int 0x10

  ;; Enable blinking cursor
      mov ax, 0x01   ; Function to set cursor type
      mov bx, 0x0000 ; Cursor start (0)
      mov cx, 0x000F ; Cursor end (15)
      int 0x10

  ;; Game loop
game_loop:
  ;; Placeholder for game logic, drawing, etc.
  
  ;; To prevent infinite loop, let's just jump back to the start
  jmp game_loop

;; Boot sector padding
times 510 - ($ - $$) db 0   ; Fill the rest of the boot sector with zeros
dw 0xAA55                 
