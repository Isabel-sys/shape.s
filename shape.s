# A shape is a quad following the following schema :
# short 4 = x
# short 3 = y
# shorts 1&2 = supplementary info (height, width | radius | etc)

# --- Shape Generic Functions ---
.globl GetShapeX
.globl GetShapeY

.globl SetShapeX
.globl SetShapeY

.globl GetSupOne
.globl GetSupTwo

# --- End Shape Generic Functions ---

# -- Rect Specific functions ---
.globl GetRectWidth
.globl GetRectHeight

.globl SetRectWidth
.globl SetRectHeight

# --- End Rect Specific functions ---
.equ X_MASK, 0xFFFF000000000000
.equ Y_MASK, 0x0000FFFF00000000

.equ SUP_ONE_MASK, 0x00000000FFFF0000
.equ SUP_TWO_MASK, 0x000000000000FFFF

SetShapeX:
	push %rbp
	movq %rsp, %rbp

	movq $X_MASK, %rax
	not  %rax

	and %rdi, %rax
	shl $48, %rsi
	or  %rsi, %rax

	pop %rbp
	ret

SetShapeY:
	push %rbp
	movq %rsp, %rbp

	movq $Y_MASK, %rax
	not  %rax

	and %rdi, %rax
	shl $32, %rsi
	or  %rsi, %rax

	pop %rbp
	ret

GetShapeX:
	push %rbp
	movq %rsp, %rbp
	shr  $48, %rdi
	and  $0xFFFF, %rdi
	movq %rdi, %rax
	pop  %rbp
	ret

GetShapeY:
	push %rbp
	movq %rsp, %rbp
	shr  $32, %rdi
	and  $0xFFFF, %rdi
	movq %rdi, %rax
	pop  %rbp
	ret

SetSupOne:
	push %rbp
	movq %rsp, %rbp

	movq $SUP_ONE_MASK, %rax
	not  %rax

	and %rdi, %rax
	shl $16, %rsi
	or  %rsi, %rax

	pop %rbp
	ret

SetSupTwo:
	push %rbp
	movq %rsp, %rbp
	movq $SUP_TWO_MASK, %rax
	not  %rax

	and %rdi, %rax

	or %rsi, %rax

	pop %rbp
	ret

SetRectWidth:
	push %rbp
	movq %rsp, %rbp
	call SetSupOne
	pop  %rbp
	ret

GetSupOne:
	push %rbp
	movq %rsp, %rbp
	shr  $16, %rdi
	and  $0xFFFF, %rdi
	movq %rdi, %rax
	pop  %rbp
	ret

GetRectWidth:
	push %rbp
	movq %rsp, %rbp

	call GetSupOne

	pop %rbp
	ret

SetRectHeight:
	push %rbp
	movq %rsp, %rbp
	call SetSupTwo
	pop  %rbp
	ret

GetSupTwo:
	push %rbp
	movq %rsp, %rbp

	movq $0xFFFF, %rax
	and  %rdi, %rax

	pop %rbp
	ret

GetRectHeight:
	push %rbp
	movq %rsp, %rbp

	call GetSupTwo
	pop  %rbp
