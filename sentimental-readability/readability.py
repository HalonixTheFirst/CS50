def countLetters(text):
    count=0
    for i in range(len(text)):
        if text[i].isalpha():
            count+=1
    return count

def countWords(text):
    count=0
    for i in range(len(text)):
        if text[i]==' ':
            count+=1
    count+=1
    return count

def countSentences(text):
    count=0
    for i in range (len(text)):
        if text[i]=='.' or text[i]=='!' or text[i]=='?':
            count+=1
    return count

def main():
    text=input("Text: ")
    letters=countLetters(text)
    words=countWords(text)
    sentences=countSentences(text)
    L=(letters/words)*100
    S=(sentences/words)*100
    index=round((0.0588*L)-(0.296*S)-15.8)
    if index<1:
        print("Before Grade 1")
    elif index>=1 and index <=16:
        print("Grade",index)
    else:
        print("Grade 16+")
main()
