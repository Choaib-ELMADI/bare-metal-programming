	.cpu cortex-m4
	.arch armv7e-m
	.fpu softvfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 1
	.eabi_attribute 30, 6
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"main.c"
	.text
	.align	1
	.global	delay
	.syntax unified
	.thumb
	.thumb_func
	.type	delay, %function
delay:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	push	{r7}
	sub	sp, sp, #20
	add	r7, sp, #0
	str	r0, [r7, #4]
	b	.L2
.L5:
	movs	r3, #0
	strb	r3, [r7, #15]
	b	.L3
.L4:
	.syntax unified
@ 7 "main.c" 1
	nop
@ 0 "" 2
	.thumb
	.syntax unified
	ldrb	r3, [r7, #15]
	adds	r3, r3, #1
	strb	r3, [r7, #15]
.L3:
	ldrb	r3, [r7, #15]	@ zero_extendqisi2
	cmp	r3, #29
	bls	.L4
.L2:
	ldr	r3, [r7, #4]
	subs	r2, r3, #1
	str	r2, [r7, #4]
	cmp	r3, #0
	bne	.L5
	nop
	nop
	adds	r7, r7, #20
	mov	sp, r7
	@ sp needed
	pop	{r7}
	bx	lr
	.size	delay, .-delay
	.align	1
	.global	main
	.syntax unified
	.thumb
	.thumb_func
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}
	add	r7, sp, #0
	ldr	r3, .L8
	ldr	r3, [r3]
	ldr	r2, .L8
	orr	r3, r3, #1
	str	r3, [r2]
	ldr	r3, .L8+4
	ldr	r3, [r3]
	ldr	r2, .L8+4
	bic	r3, r3, #3072
	str	r3, [r2]
	ldr	r3, .L8+4
	ldr	r3, [r3]
	ldr	r2, .L8+4
	orr	r3, r3, #1024
	str	r3, [r2]
.L7:
	ldr	r3, .L8+8
	movs	r2, #1
	str	r2, [r3]
	movw	r0, #20000
	bl	delay
	ldr	r3, .L8+8
	movs	r2, #0
	str	r2, [r3]
	movw	r0, #20000
	bl	delay
	nop
	b	.L7
.L9:
	.align	2
.L8:
	.word	1073887280
	.word	1073872896
	.word	1111491220
	.size	main, .-main
	.ident	"GCC: (Arm GNU Toolchain 13.3.Rel1 (Build arm-13.24)) 13.3.1 20240614"
