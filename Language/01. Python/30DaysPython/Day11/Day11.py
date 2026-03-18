#*def tạo_tên_đầy_đủ():
##    first_name = 'Luong'
##    last_name = 'Manh'
##    space = ' '
##    full_name = first_name + space + last_name
##    print(full_name)
##tạo_tên_đầy_đủ()
## -----------------------------------------------------------------
#def cong(number):
#    return 1 + number
#print(cong(90))
# ----------------------------------------------------------------
#def tinh_tong(*nums):
#    total = 0
#    for num in nums:
#        total+=num
#    return total
#print(tinh_tong(1,2,3,4,5))
#------------------------------------------------------------
#def Sum(n):
#    total = 0
#    for i in range(0,n+1,1):
#        total+=i
#    print(total)
#Sum(10)
#----------------------------------------------------------
#def even_and_odds(n):
#    counteven = 0
#    countodd = 0
#    for i in range(0,n+1,1):
#        if i%2 == 0:
#            counteven+=1
#        else:
#            countodd+=1
#    print(counteven)
#    print(countodd)
#even_and_odds(100)
#---------------------------------------------------------
def is_prime(n):
    count = 0
    for i in range(2,n,1):
        if n%i == 0:
            count+=1
    if count == 0:
        print("Is_prime")
    else:
        print("Not_prime")
is_prime(9)