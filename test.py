import sys
import random

ans = True

print 0xFFFF * 2**208
print hex(0xFFFF * 2**208)

while ans:
    answer = float(raw_input("Enter difficulty \n"))
    if answer == "":
        sys.exit
    elif answer == "q":
        sys.exit
    elif answer > 0:
        #print int(26959535291011309493156476344723991336010898738574164086137773096960 / float(answer))
	print int(26959535291011309493156476344723991336010898738574164086137773096960 / float(answer))
#110427836236357352041769395878404723568785424659630784333489133269811200 / float(answer))
