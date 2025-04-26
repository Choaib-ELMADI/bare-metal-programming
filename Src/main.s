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
	.global	current_task
	.data
	.type	current_task, %object
	.size	current_task, 1
current_task:
	.byte	1
	.global	g_tick_count
	.bss
	.align	2
	.type	g_tick_count, %object
	.size	g_tick_count, 4
g_tick_count:
	.space	4
	.global	const_v_1
	.section	.rodata
	.align	2
	.type	const_v_1, %object
	.size	const_v_1, 4
const_v_1:
	.word	100
	.global	const_v_2
	.align	2
	.type	const_v_2, %object
	.size	const_v_2, 4
const_v_2:
	.word	100
	.global	const_V_3
	.type	const_V_3, %object
	.size	const_V_3, 1
const_V_3:
	.byte	100
	.global	user_tasks
	.bss
	.align	2
	.type	user_tasks, %object
	.size	user_tasks, 80
user_tasks:
	.space	80
	.section	.rodata
	.align	2
.LC0:
	.ascii	"Implementation of simple task scheduler\000"
	.text
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
	bl	enable_processor_faults
	bl	initialise_monitor_handles
	ldr	r0, .L3
	bl	init_scheduler_stack
	ldr	r0, .L3+4
	bl	puts
	bl	init_tasks_stack
	bl	led_init_all
	mov	r0, #1000
	bl	init_systick_timer
	bl	switch_sp_to_psp
	bl	task1_handler
.L2:
	b	.L2
.L4:
	.align	2
.L3:
	.word	536996864
	.word	.LC0
	.size	main, .-main
	.align	1
	.global	idle_task
	.syntax unified
	.thumb
	.thumb_func
	.type	idle_task, %function
idle_task:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	push	{r7}
	add	r7, sp, #0
.L6:
	b	.L6
	.size	idle_task, .-idle_task
	.section	.rodata
	.align	2
.LC1:
	.ascii	"Task1 is executing\000"
	.text
	.align	1
	.global	task1_handler
	.syntax unified
	.thumb
	.thumb_func
	.type	task1_handler, %function
task1_handler:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}
	add	r7, sp, #0
.L8:
	ldr	r0, .L9
	bl	puts
	movs	r0, #12
	bl	led_on
	mov	r0, #1000
	bl	task_delay
	movs	r0, #12
	bl	led_off
	mov	r0, #1000
	bl	task_delay
	b	.L8
.L10:
	.align	2
.L9:
	.word	.LC1
	.size	task1_handler, .-task1_handler
	.section	.rodata
	.align	2
.LC2:
	.ascii	"Task2 is executing\000"
	.text
	.align	1
	.global	task2_handler
	.syntax unified
	.thumb
	.thumb_func
	.type	task2_handler, %function
task2_handler:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}
	add	r7, sp, #0
.L12:
	ldr	r0, .L13
	bl	puts
	movs	r0, #13
	bl	led_on
	mov	r0, #1000
	bl	task_delay
	movs	r0, #13
	bl	led_off
	mov	r0, #1000
	bl	task_delay
	b	.L12
.L14:
	.align	2
.L13:
	.word	.LC2
	.size	task2_handler, .-task2_handler
	.section	.rodata
	.align	2
.LC3:
	.ascii	"Task3 is executing\000"
	.text
	.align	1
	.global	task3_handler
	.syntax unified
	.thumb
	.thumb_func
	.type	task3_handler, %function
task3_handler:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}
	add	r7, sp, #0
.L16:
	ldr	r0, .L17
	bl	puts
	movs	r0, #15
	bl	led_on
	movs	r0, #250
	bl	task_delay
	movs	r0, #15
	bl	led_off
	movs	r0, #250
	bl	task_delay
	b	.L16
.L18:
	.align	2
.L17:
	.word	.LC3
	.size	task3_handler, .-task3_handler
	.section	.rodata
	.align	2
.LC4:
	.ascii	"Task4 is executing\000"
	.text
	.align	1
	.global	task4_handler
	.syntax unified
	.thumb
	.thumb_func
	.type	task4_handler, %function
task4_handler:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}
	add	r7, sp, #0
.L20:
	ldr	r0, .L21
	bl	puts
	movs	r0, #14
	bl	led_on
	movs	r0, #125
	bl	task_delay
	movs	r0, #14
	bl	led_off
	movs	r0, #125
	bl	task_delay
	b	.L20
.L22:
	.align	2
.L21:
	.word	.LC4
	.size	task4_handler, .-task4_handler
	.align	1
	.global	init_systick_timer
	.syntax unified
	.thumb
	.thumb_func
	.type	init_systick_timer, %function
init_systick_timer:
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	push	{r7}
	sub	sp, sp, #28
	add	r7, sp, #0
	str	r0, [r7, #4]
	ldr	r3, .L24
	str	r3, [r7, #20]
	ldr	r3, .L24+4
	str	r3, [r7, #16]
	ldr	r2, .L24+8
	ldr	r3, [r7, #4]
	udiv	r3, r2, r3
	subs	r3, r3, #1
	str	r3, [r7, #12]
	ldr	r3, [r7, #20]
	movs	r2, #0
	str	r2, [r3]
	ldr	r3, [r7, #20]
	ldr	r2, [r3]
	ldr	r3, [r7, #12]
	orrs	r2, r2, r3
	ldr	r3, [r7, #20]
	str	r2, [r3]
	ldr	r3, [r7, #16]
	ldr	r3, [r3]
	orr	r2, r3, #2
	ldr	r3, [r7, #16]
	str	r2, [r3]
	ldr	r3, [r7, #16]
	ldr	r3, [r3]
	orr	r2, r3, #4
	ldr	r3, [r7, #16]
	str	r2, [r3]
	ldr	r3, [r7, #16]
	ldr	r3, [r3]
	orr	r2, r3, #1
	ldr	r3, [r7, #16]
	str	r2, [r3]
	nop
	adds	r7, r7, #28
	mov	sp, r7
	@ sp needed
	pop	{r7}
	bx	lr
.L25:
	.align	2
.L24:
	.word	-536813548
	.word	-536813552
	.word	16000000
	.size	init_systick_timer, .-init_systick_timer
	.align	1
	.global	init_scheduler_stack
	.syntax unified
	.thumb
	.thumb_func
	.type	init_scheduler_stack, %function
init_scheduler_stack:
	@ Naked Function: prologue and epilogue provided by programmer.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	r3, r0
	.syntax unified
@ 131 "main.c" 1
	MSR MSP,r3
@ 0 "" 2
@ 132 "main.c" 1
	BX LR
@ 0 "" 2
	.thumb
	.syntax unified
	nop
	.size	init_scheduler_stack, .-init_scheduler_stack
	.align	1
	.global	init_tasks_stack
	.syntax unified
	.thumb
	.thumb_func
	.type	init_tasks_stack, %function
init_tasks_stack:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	push	{r7}
	sub	sp, sp, #20
	add	r7, sp, #0
	ldr	r3, .L32
	movs	r2, #0
	strb	r2, [r3, #8]
	ldr	r3, .L32
	movs	r2, #0
	strb	r2, [r3, #24]
	ldr	r3, .L32
	movs	r2, #0
	strb	r2, [r3, #40]
	ldr	r3, .L32
	movs	r2, #0
	strb	r2, [r3, #56]
	ldr	r3, .L32
	movs	r2, #0
	strb	r2, [r3, #72]
	ldr	r3, .L32
	ldr	r2, .L32+4
	str	r2, [r3]
	ldr	r3, .L32
	ldr	r2, .L32+8
	str	r2, [r3, #16]
	ldr	r3, .L32
	ldr	r2, .L32+12
	str	r2, [r3, #32]
	ldr	r3, .L32
	ldr	r2, .L32+16
	str	r2, [r3, #48]
	ldr	r3, .L32
	ldr	r2, .L32+20
	str	r2, [r3, #64]
	ldr	r3, .L32
	ldr	r2, .L32+24
	str	r2, [r3, #12]
	ldr	r3, .L32
	ldr	r2, .L32+28
	str	r2, [r3, #28]
	ldr	r3, .L32
	ldr	r2, .L32+32
	str	r2, [r3, #44]
	ldr	r3, .L32
	ldr	r2, .L32+36
	str	r2, [r3, #60]
	ldr	r3, .L32
	ldr	r2, .L32+40
	str	r2, [r3, #76]
	movs	r3, #0
	str	r3, [r7, #8]
	b	.L28
.L31:
	ldr	r2, .L32
	ldr	r3, [r7, #8]
	lsls	r3, r3, #4
	add	r3, r3, r2
	ldr	r3, [r3]
	str	r3, [r7, #12]
	ldr	r3, [r7, #12]
	subs	r3, r3, #4
	str	r3, [r7, #12]
	ldr	r3, [r7, #12]
	mov	r2, #16777216
	str	r2, [r3]
	ldr	r3, [r7, #12]
	subs	r3, r3, #4
	str	r3, [r7, #12]
	ldr	r2, .L32
	ldr	r3, [r7, #8]
	lsls	r3, r3, #4
	add	r3, r3, r2
	adds	r3, r3, #12
	ldr	r3, [r3]
	mov	r2, r3
	ldr	r3, [r7, #12]
	str	r2, [r3]
	ldr	r3, [r7, #12]
	subs	r3, r3, #4
	str	r3, [r7, #12]
	ldr	r3, [r7, #12]
	mvn	r2, #2
	str	r2, [r3]
	movs	r3, #0
	str	r3, [r7, #4]
	b	.L29
.L30:
	ldr	r3, [r7, #12]
	subs	r3, r3, #4
	str	r3, [r7, #12]
	ldr	r3, [r7, #12]
	movs	r2, #0
	str	r2, [r3]
	ldr	r3, [r7, #4]
	adds	r3, r3, #1
	str	r3, [r7, #4]
.L29:
	ldr	r3, [r7, #4]
	cmp	r3, #12
	ble	.L30
	ldr	r2, [r7, #12]
	ldr	r1, .L32
	ldr	r3, [r7, #8]
	lsls	r3, r3, #4
	add	r3, r3, r1
	str	r2, [r3]
	ldr	r3, [r7, #8]
	adds	r3, r3, #1
	str	r3, [r7, #8]
.L28:
	ldr	r3, [r7, #8]
	cmp	r3, #4
	ble	.L31
	nop
	nop
	adds	r7, r7, #20
	mov	sp, r7
	@ sp needed
	pop	{r7}
	bx	lr
.L33:
	.align	2
.L32:
	.word	user_tasks
	.word	536997888
	.word	537001984
	.word	537000960
	.word	536999936
	.word	536998912
	.word	idle_task
	.word	task1_handler
	.word	task2_handler
	.word	task3_handler
	.word	task4_handler
	.size	init_tasks_stack, .-init_tasks_stack
	.align	1
	.global	enable_processor_faults
	.syntax unified
	.thumb
	.thumb_func
	.type	enable_processor_faults, %function
enable_processor_faults:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	push	{r7}
	sub	sp, sp, #12
	add	r7, sp, #0
	ldr	r3, .L35
	str	r3, [r7, #4]
	ldr	r3, [r7, #4]
	ldr	r3, [r3]
	orr	r2, r3, #65536
	ldr	r3, [r7, #4]
	str	r2, [r3]
	ldr	r3, [r7, #4]
	ldr	r3, [r3]
	orr	r2, r3, #131072
	ldr	r3, [r7, #4]
	str	r2, [r3]
	ldr	r3, [r7, #4]
	ldr	r3, [r3]
	orr	r2, r3, #262144
	ldr	r3, [r7, #4]
	str	r2, [r3]
	nop
	adds	r7, r7, #12
	mov	sp, r7
	@ sp needed
	pop	{r7}
	bx	lr
.L36:
	.align	2
.L35:
	.word	-536810204
	.size	enable_processor_faults, .-enable_processor_faults
	.align	1
	.global	get_psp_value
	.syntax unified
	.thumb
	.thumb_func
	.type	get_psp_value, %function
get_psp_value:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	push	{r7}
	add	r7, sp, #0
	ldr	r3, .L39
	ldrb	r3, [r3]	@ zero_extendqisi2
	ldr	r2, .L39+4
	lsls	r3, r3, #4
	add	r3, r3, r2
	ldr	r3, [r3]
	mov	r0, r3
	mov	sp, r7
	@ sp needed
	pop	{r7}
	bx	lr
.L40:
	.align	2
.L39:
	.word	current_task
	.word	user_tasks
	.size	get_psp_value, .-get_psp_value
	.align	1
	.global	save_psp_value
	.syntax unified
	.thumb
	.thumb_func
	.type	save_psp_value, %function
save_psp_value:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	push	{r7}
	sub	sp, sp, #12
	add	r7, sp, #0
	str	r0, [r7, #4]
	ldr	r3, .L42
	ldrb	r3, [r3]	@ zero_extendqisi2
	ldr	r2, .L42+4
	lsls	r3, r3, #4
	add	r3, r3, r2
	ldr	r2, [r7, #4]
	str	r2, [r3]
	nop
	adds	r7, r7, #12
	mov	sp, r7
	@ sp needed
	pop	{r7}
	bx	lr
.L43:
	.align	2
.L42:
	.word	current_task
	.word	user_tasks
	.size	save_psp_value, .-save_psp_value
	.align	1
	.global	update_next_task
	.syntax unified
	.thumb
	.thumb_func
	.type	update_next_task, %function
update_next_task:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	push	{r7}
	sub	sp, sp, #12
	add	r7, sp, #0
	movs	r3, #255
	str	r3, [r7, #4]
	movs	r3, #0
	str	r3, [r7]
	b	.L45
.L48:
	ldr	r3, .L52
	ldrb	r3, [r3]	@ zero_extendqisi2
	adds	r3, r3, #1
	uxtb	r2, r3
	ldr	r3, .L52
	strb	r2, [r3]
	ldr	r3, .L52
	ldrb	r2, [r3]	@ zero_extendqisi2
	ldr	r3, .L52+4
	umull	r1, r3, r3, r2
	lsrs	r1, r3, #2
	mov	r3, r1
	lsls	r3, r3, #2
	add	r3, r3, r1
	subs	r3, r2, r3
	uxtb	r2, r3
	ldr	r3, .L52
	strb	r2, [r3]
	ldr	r3, .L52
	ldrb	r3, [r3]	@ zero_extendqisi2
	ldr	r2, .L52+8
	lsls	r3, r3, #4
	add	r3, r3, r2
	adds	r3, r3, #8
	ldrb	r3, [r3]	@ zero_extendqisi2
	str	r3, [r7, #4]
	ldr	r3, [r7, #4]
	cmp	r3, #0
	bne	.L46
	ldr	r3, .L52
	ldrb	r3, [r3]	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L50
.L46:
	ldr	r3, [r7]
	adds	r3, r3, #1
	str	r3, [r7]
.L45:
	ldr	r3, [r7]
	cmp	r3, #4
	ble	.L48
	b	.L47
.L50:
	nop
.L47:
	ldr	r3, [r7, #4]
	cmp	r3, #0
	beq	.L51
	ldr	r3, .L52
	movs	r2, #0
	strb	r2, [r3]
.L51:
	nop
	adds	r7, r7, #12
	mov	sp, r7
	@ sp needed
	pop	{r7}
	bx	lr
.L53:
	.align	2
.L52:
	.word	current_task
	.word	-858993459
	.word	user_tasks
	.size	update_next_task, .-update_next_task
	.align	1
	.global	switch_sp_to_psp
	.syntax unified
	.thumb
	.thumb_func
	.type	switch_sp_to_psp, %function
switch_sp_to_psp:
	@ Naked Function: prologue and epilogue provided by programmer.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	.syntax unified
@ 212 "main.c" 1
	PUSH {LR}
@ 0 "" 2
@ 214 "main.c" 1
	BL get_psp_value
@ 0 "" 2
@ 215 "main.c" 1
	MSR PSP,R0
@ 0 "" 2
@ 217 "main.c" 1
	POP {LR}
@ 0 "" 2
@ 221 "main.c" 1
	MOV R0,#0X02
@ 0 "" 2
@ 222 "main.c" 1
	MSR CONTROL,R0
@ 0 "" 2
@ 223 "main.c" 1
	BX LR
@ 0 "" 2
	.thumb
	.syntax unified
	nop
	.size	switch_sp_to_psp, .-switch_sp_to_psp
	.align	1
	.global	schedule
	.syntax unified
	.thumb
	.thumb_func
	.type	schedule, %function
schedule:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	push	{r7}
	sub	sp, sp, #12
	add	r7, sp, #0
	ldr	r3, .L56
	str	r3, [r7, #4]
	ldr	r3, [r7, #4]
	ldr	r3, [r3]
	orr	r2, r3, #268435456
	ldr	r3, [r7, #4]
	str	r2, [r3]
	nop
	adds	r7, r7, #12
	mov	sp, r7
	@ sp needed
	pop	{r7}
	bx	lr
.L57:
	.align	2
.L56:
	.word	-536810236
	.size	schedule, .-schedule
	.align	1
	.global	task_delay
	.syntax unified
	.thumb
	.thumb_func
	.type	task_delay, %function
task_delay:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}
	sub	sp, sp, #8
	add	r7, sp, #0
	str	r0, [r7, #4]
	.syntax unified
@ 234 "main.c" 1
	MOV R0,#0x1
@ 0 "" 2
@ 234 "main.c" 1
	MSR PRIMASK,R0
@ 0 "" 2
	.thumb
	.syntax unified
	ldr	r3, .L60
	ldrb	r3, [r3]	@ zero_extendqisi2
	cmp	r3, #0
	beq	.L59
	ldr	r3, .L60+4
	ldr	r2, [r3]
	ldr	r3, .L60
	ldrb	r3, [r3]	@ zero_extendqisi2
	mov	r0, r3
	ldr	r3, [r7, #4]
	add	r2, r2, r3
	ldr	r1, .L60+8
	lsls	r3, r0, #4
	add	r3, r3, r1
	adds	r3, r3, #4
	str	r2, [r3]
	ldr	r3, .L60
	ldrb	r3, [r3]	@ zero_extendqisi2
	ldr	r2, .L60+8
	lsls	r3, r3, #4
	add	r3, r3, r2
	adds	r3, r3, #8
	movs	r2, #255
	strb	r2, [r3]
	bl	schedule
.L59:
	.syntax unified
@ 243 "main.c" 1
	MOV R0,#0x0
@ 0 "" 2
@ 243 "main.c" 1
	MSR PRIMASK,R0
@ 0 "" 2
	.thumb
	.syntax unified
	nop
	adds	r7, r7, #8
	mov	sp, r7
	@ sp needed
	pop	{r7, pc}
.L61:
	.align	2
.L60:
	.word	current_task
	.word	g_tick_count
	.word	user_tasks
	.size	task_delay, .-task_delay
	.align	1
	.global	PendSV_Handler
	.syntax unified
	.thumb
	.thumb_func
	.type	PendSV_Handler, %function
PendSV_Handler:
	@ Naked Function: prologue and epilogue provided by programmer.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	.syntax unified
@ 250 "main.c" 1
	MRS R0,PSP
@ 0 "" 2
@ 252 "main.c" 1
	STMDB R0!,{R4-R11}
@ 0 "" 2
@ 254 "main.c" 1
	PUSH {LR}
@ 0 "" 2
@ 257 "main.c" 1
	BL save_psp_value
@ 0 "" 2
@ 262 "main.c" 1
	BL update_next_task
@ 0 "" 2
@ 265 "main.c" 1
	BL get_psp_value
@ 0 "" 2
@ 268 "main.c" 1
	LDMIA R0!,{R4-R11}
@ 0 "" 2
@ 271 "main.c" 1
	MSR PSP,R0
@ 0 "" 2
@ 273 "main.c" 1
	POP {LR}
@ 0 "" 2
@ 275 "main.c" 1
	BX LR
@ 0 "" 2
	.thumb
	.syntax unified
	nop
	.size	PendSV_Handler, .-PendSV_Handler
	.align	1
	.global	update_global_tick_count
	.syntax unified
	.thumb
	.thumb_func
	.type	update_global_tick_count, %function
update_global_tick_count:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	push	{r7}
	add	r7, sp, #0
	ldr	r3, .L64
	ldr	r3, [r3]
	adds	r3, r3, #1
	ldr	r2, .L64
	str	r3, [r2]
	nop
	mov	sp, r7
	@ sp needed
	pop	{r7}
	bx	lr
.L65:
	.align	2
.L64:
	.word	g_tick_count
	.size	update_global_tick_count, .-update_global_tick_count
	.align	1
	.global	unblock_tasks
	.syntax unified
	.thumb
	.thumb_func
	.type	unblock_tasks, %function
unblock_tasks:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	push	{r7}
	sub	sp, sp, #12
	add	r7, sp, #0
	movs	r3, #1
	str	r3, [r7, #4]
	b	.L67
.L69:
	ldr	r2, .L70
	ldr	r3, [r7, #4]
	lsls	r3, r3, #4
	add	r3, r3, r2
	adds	r3, r3, #8
	ldrb	r3, [r3]	@ zero_extendqisi2
	cmp	r3, #0
	beq	.L68
	ldr	r2, .L70
	ldr	r3, [r7, #4]
	lsls	r3, r3, #4
	add	r3, r3, r2
	adds	r3, r3, #4
	ldr	r2, [r3]
	ldr	r3, .L70+4
	ldr	r3, [r3]
	cmp	r2, r3
	bne	.L68
	ldr	r2, .L70
	ldr	r3, [r7, #4]
	lsls	r3, r3, #4
	add	r3, r3, r2
	adds	r3, r3, #8
	movs	r2, #0
	strb	r2, [r3]
.L68:
	ldr	r3, [r7, #4]
	adds	r3, r3, #1
	str	r3, [r7, #4]
.L67:
	ldr	r3, [r7, #4]
	cmp	r3, #4
	ble	.L69
	nop
	nop
	adds	r7, r7, #12
	mov	sp, r7
	@ sp needed
	pop	{r7}
	bx	lr
.L71:
	.align	2
.L70:
	.word	user_tasks
	.word	g_tick_count
	.size	unblock_tasks, .-unblock_tasks
	.align	1
	.global	SysTick_Handler
	.syntax unified
	.thumb
	.thumb_func
	.type	SysTick_Handler, %function
SysTick_Handler:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}
	sub	sp, sp, #8
	add	r7, sp, #0
	ldr	r3, .L73
	str	r3, [r7, #4]
	bl	update_global_tick_count
	bl	unblock_tasks
	ldr	r3, [r7, #4]
	ldr	r3, [r3]
	orr	r2, r3, #268435456
	ldr	r3, [r7, #4]
	str	r2, [r3]
	nop
	adds	r7, r7, #8
	mov	sp, r7
	@ sp needed
	pop	{r7, pc}
.L74:
	.align	2
.L73:
	.word	-536810236
	.size	SysTick_Handler, .-SysTick_Handler
	.section	.rodata
	.align	2
.LC5:
	.ascii	"Exception : Hardfault\000"
	.text
	.align	1
	.global	HardFault_Handler
	.syntax unified
	.thumb
	.thumb_func
	.type	HardFault_Handler, %function
HardFault_Handler:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}
	add	r7, sp, #0
	ldr	r0, .L77
	bl	puts
.L76:
	b	.L76
.L78:
	.align	2
.L77:
	.word	.LC5
	.size	HardFault_Handler, .-HardFault_Handler
	.section	.rodata
	.align	2
.LC6:
	.ascii	"Exception : MemManage\000"
	.text
	.align	1
	.global	MemManage_Handler
	.syntax unified
	.thumb
	.thumb_func
	.type	MemManage_Handler, %function
MemManage_Handler:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}
	add	r7, sp, #0
	ldr	r0, .L81
	bl	puts
.L80:
	b	.L80
.L82:
	.align	2
.L81:
	.word	.LC6
	.size	MemManage_Handler, .-MemManage_Handler
	.section	.rodata
	.align	2
.LC7:
	.ascii	"Exception : BusFault\000"
	.text
	.align	1
	.global	BusFault_Handler
	.syntax unified
	.thumb
	.thumb_func
	.type	BusFault_Handler, %function
BusFault_Handler:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}
	add	r7, sp, #0
	ldr	r0, .L85
	bl	puts
.L84:
	b	.L84
.L86:
	.align	2
.L85:
	.word	.LC7
	.size	BusFault_Handler, .-BusFault_Handler
	.ident	"GCC: (Arm GNU Toolchain 13.3.Rel1 (Build arm-13.24)) 13.3.1 20240614"
