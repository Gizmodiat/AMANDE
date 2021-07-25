#! /bin/usr/python

fin=open("temporary/temp3","r")
fout=open("temporary/temp4","w")
for i in fin.readlines():
	li=i.split(" ")
	if len(li[1])<2 and len(li[2])<2:
		#print(li[1]+"---"+str(len(li[2])))
		ss=""
		for j in li:
			ss=ss+" "+j
		fout.write(ss)
fin.close()
fout.close()
