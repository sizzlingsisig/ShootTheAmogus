;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module bgtiles
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _tile
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_tile::
	.ds 160
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
	.area _CODE
	.area _INITIALIZER
__xinit__tile:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x33	; 51	'3'
	.db #0x0f	; 15
	.db #0x66	; 102	'f'
	.db #0x1e	; 30
	.db #0xcc	; 204
	.db #0x3c	; 60
	.db #0x99	; 153
	.db #0x78	; 120	'x'
	.db #0x33	; 51	'3'
	.db #0xf0	; 240
	.db #0x66	; 102	'f'
	.db #0xe1	; 225
	.db #0xcc	; 204
	.db #0xc3	; 195
	.db #0x99	; 153
	.db #0x87	; 135
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xbf	; 191
	.db #0xc0	; 192
	.db #0xa0	; 160
	.db #0xc0	; 192
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x88	; 136
	.db #0xff	; 255
	.db #0xbb	; 187
	.db #0xcc	; 204
	.db #0xaa	; 170
	.db #0xcc	; 204
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0xfd	; 253
	.db #0x03	; 3
	.db #0x05	; 5
	.db #0x03	; 3
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x11	; 17
	.db #0xff	; 255
	.db #0xdd	; 221
	.db #0x33	; 51	'3'
	.db #0x55	; 85	'U'
	.db #0x33	; 51	'3'
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0xfd	; 253
	.db #0x01	; 1
	.db #0xfd	; 253
	.db #0x01	; 1
	.db #0xfd	; 253
	.db #0x01	; 1
	.db #0xfd	; 253
	.db #0x01	; 1
	.db #0xfd	; 253
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xef	; 239
	.db #0xef	; 239
	.db #0xd7	; 215
	.db #0xc7	; 199
	.db #0xbb	; 187
	.db #0xef	; 239
	.db #0xd7	; 215
	.db #0xff	; 255
	.db #0xef	; 239
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xef	; 239
	.db #0xef	; 239
	.db #0xd7	; 215
	.db #0xff	; 255
	.db #0xef	; 239
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x7a	; 122	'z'
	.db #0x66	; 102	'f'
	.db #0x72	; 114	'r'
	.db #0x4e	; 78	'N'
	.db #0x46	; 70	'F'
	.db #0x7e	; 126
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0x00	; 0
	.area _CABS (ABS)
