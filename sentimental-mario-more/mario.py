while True:
    try:
        height= int(input("Height: "))
        if height>0 and height<=8:
            break
    except ValueError:
        continue
if height>0:
    for i in range(height):
        print(" "*(height-i-1),end='')
        print("#"*(i+1), end='')
        print("  ",end='')
        print("#"*(i+1))
