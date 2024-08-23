# Chuong trinh: tao file
#-----------------------------------
# Data segment
	.data
# Cac dinh nghia bien
tenfile:	.asciiz	"SOTHUC.TXT"
fdescr:	.word	0	
base_10: .float 100000000.000
dulieu1:	.float 0.0
dulieu2:	.float 0.0
dulieu3:	.float 0.0
# Cac cau nhac nhap du lieu
str_tc:	.asciiz	"Thanh cong."
str_loi:	.asciiz	"Mo file bi loi."
str_endl:	.asciiz	"\n"
str1:	.asciiz 	"So 1: "
str2:	.asciiz	"So 2: "
str3:	.asciiz	"So 3: "
str_dulieu1:	.space 11
str_dulieu2:	.space 11
str_dulieu3:	.space 11
#-----------------------------------
# Code segment
	.text
	.globl	main
#-----------------------------------
# Chuong trinh chinh
#-----------------------------------
main:
	jal Random_generator #Generating fi
#Xu li
  Xuli_so1:
	mov.s $f0,$f1
	la $a0,str_dulieu1
	jal Convert_toString
	
  Xuli_so2:
	mov.s $f0,$f2
	la $a0,str_dulieu2
	jal Convert_toString
	
  Xuli_so3:
	mov.s $f0,$f3
	la $a0,str_dulieu3
	jal Convert_toString
  Out:
  	#j Kthuc
	#In ra ket qua
	jal Xuat_out
	#Ghi vao file
	j File_output
end_main:
############ Helper functions ############
Random_generator:
	li $v0,30
	syscall
	move $t0,$a0
	
	li $v0,40
	li $a0,0
	move $a1,$t0
	syscall
	
  #So thu nhat
	li $v0,43
	syscall
	mov.s $f1,$f0
	swc1 $f1,dulieu1
	
  #So thu hai
	li $v0,43
	syscall
	mov.s $f2,$f0
	swc1 $f2,dulieu2
	
  #So thu nhat
	li $v0,43
	syscall
	mov.s $f3,$f0
	swc1 $f3,dulieu3
  Return:
	jr $ra
####### Converting function #######
# $f0 chua so thu i
# $a0 chua dia chi string so thu i
# $a1 luu dang bit cua so $f0 * 10^8
Convert_toString:

Init:
	l.s $f4,base_10
	
	mul.s $f0,$f0,$f4 	# fi = fi . 10^8 de lay 8 so sau phan thap phan
	cvt.w.s $f0,$f0 	# fi = floor(fi)
	mfc1 $a1,$f0 		# $a1 chua phan nguyen cua fi
	
Add_0.: # them chuoi '0.' vao str_dulieui
	li $t0,'0'
	sb $t0,0($a0)
	li $t0,'.'
	sb $t0,1($a0)
	addi $a0,$a0,2 
edge_case: # Neu so chu so < 8 thi them so 0
	li $t0,8
	move $t1,$a1 
	count_digit:
		beqz $t1,Add_0 		# while (num !=0)
		
		li $t2,10
		div $t1,$t2
		mflo $t1			# num/=10;
		subi $t0,$t0,1			# count--;
		j count_digit
Add_0: # them chuoi '0' vao str_dulieu1
	move $t2,$t0	# so luong so 0 can them
	loop_add:
		beqz $t0,normal_process
		li $t1,'0'
		sb $t1,0($a0)
		addi $a0,$a0,1	# dich qua dia chi tiep
		subi $t0,$t0,1	# count--;
		j loop_add
		
normal_process:
# Move $a0 den cuoi chuoi
	beq $t2,8,return # ket qua da du
	
	li $t0,7
	sub $t0,$t0,$t2 # tinh offset
	add $a0,$a0,$t0 # $a0 o vi tri end
	addi $t0,$t0,1 # do dai cua so can them
  Loop_ketqua:
		beqz $t0,return # while (count!=0)
		
		li $t1,10
		div $a1,$t1	#division
		mfhi $t1		#last_digit = num%10;
		mflo $a1		# num/=10;
		
		addi $t1,$t1,48
		sb $t1,0($a0) 	# ans += to_string(last_digit);
	increasing:
		subi $t0,$t0,1	# count--;
		subi $a0,$a0,1 # offset = -1
		j Loop_ketqua
  return:
  	jr $ra
######## End of Helper functions ########
# Nhap (syscall)
# Ghi vao file
File_output:
  file_open:
	la	$a0,tenfile
	addi	$a1,$zero,1	# open with write-only
	addi	$v0,$zero,13
	syscall
	# check loi neu co
	bltz	$v0,baoloi
	sw	$v0,fdescr
  # ghi file
  file_write:
    So_thu_1:
  	lw	$a0,fdescr	# file descriptor
  	
  	la	$a1,str1
  	addi	$a2,$zero,6
  	addi	$v0,$zero,15
  	syscall
  	
  	la	$a1,str_dulieu1
  	addi	$a2,$zero,10
  	addi	$v0,$zero,15
  	syscall
    	endl_1:
    	la	$a1,str_endl
  	addi	$a2,$zero,1
  	addi	$v0,$zero,15
  	syscall
  	
    So_thu_2:
    	la	$a1,str2
  	addi	$a2,$zero,6
  	addi	$v0,$zero,15
  	syscall
  	
  	la	$a1,str_dulieu2
  	addi	$a2,$zero,10
  	addi	$v0,$zero,15
  	syscall
  	endl_2:
  	la	$a1,str_endl
  	addi	$a2,$zero,1
  	addi	$v0,$zero,15
  	syscall
  	
    So_thu_3:
    	la	$a1,str3
  	addi	$a2,$zero,6
  	addi	$v0,$zero,15
  	syscall
  	
  	la	$a1,str_dulieu3
  	addi	$a2,$zero,10
  	addi	$v0,$zero,15
  	syscall
  # dong file
  file_close:
	lw	$a0,fdescr
	addi	$v0,$zero,16
	syscall
	
	la	$a0,str_tc
	addi	$v0,$zero,4
	syscall
	j	Kthuc
baoloi:	
	la	$a0,str_loi
	addi	$v0,$zero,4
	syscall
	j Kthuc
# Xuat ket qua (syscall)
Xuat_out:
  #so thu nhat:
	li $v0,4
	la $a0,str1
	syscall
	
	li $v0,4
	la $a0,str_dulieu1
	syscall
   #Xuong dong
   	li $v0,11
   	li $a0,'\n'
   	syscall
  #so thu hai:
	li $v0,4
	la $a0,str2
	syscall
	
	li $v0,4
	la $a0,str_dulieu2
	syscall
   #Xuong dong
   	li $v0,11
   	li $a0,'\n'
   	syscall
  #so thu ba:
	li $v0,4
	la $a0,str3
	syscall
	
	li $v0,4
	la $a0,str_dulieu3
	syscall
   #Xuong dong
   	li $v0,11
   	li $a0,'\n'
   	syscall
  #Return
   	jr $ra
# Ket thuc chuong trinh (syscall)
Kthuc:	
	addiu	$v0,$zero,10
	syscall
#-----------------------------------
