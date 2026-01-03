card=input("Number: ")
# card="4003600000000014"
while not card.isnumeric():
    card=input("Number: ")
length=len(card)
if length in [13,15,16]:
    i=length-2
    sum=0
    while i>=0 :
        product=2*int(card[i])
        for k in str(product):
            sum=sum+int(k)
        i-=2
    i=length-1
    # print(sum)
    while i>=0:
        for k in str(card[i]):
            sum=sum+int(k)
        i-=2
    # print(sum)
    lastDigit=sum%10
    if lastDigit==0:
        startDigits=card[0:2]
        if int(startDigits) in [51,52,53,54,55]:
            print("MASTERCARD")
        elif int(startDigits) in [34,37]:
            print("AMEX")
        elif int(card[0])==4:
            print("VISA")
        else:
            print("INVALID")
    else:
        print("INVALID")
else:
    print("INVALID")
