import csv
import jieba
content="" 
with open("comment.csv","r",encoding='utf-8') as csvfile:
    reader=csv.reader(csvfile)

    for line in reader:
        # print(line[1])
        content+=line[1] 
# print("字数：",len(content)) 
wordlist=jieba.cut(content,cut_all=True)
stopwords=[line.strip() for line in open('stopwords.txt', 'r', encoding='utf-8').readlines()]
outstr = ''
for word in wordlist:
    if word not in stopwords:
        if word != '\t':
            outstr += word
            outstr += " "
print(outstr)
worddict=dict()
wordlist1=outstr.split(' ')

for word in wordlist1:
    if word not in worddict:
        worddict[word]=1
    else:
        worddict[word]+=1
#print(worddict)
with open("result.csv","w",encoding='utf-8') as f:
    for i in worddict:
        f.writelines(str(i)+","+str(worddict[i])+"\n")
