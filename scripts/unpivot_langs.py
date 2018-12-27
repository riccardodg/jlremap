import io,sys
import collections
import itertools

ifile="/opt/java/app/jlremap/sql/MAPDBJPA_LANG_temp.csv"
hr=io.open(ifile,'r',encoding='utf-8')
ofile="/opt/java/app/jlremap/sql/MAPDBJPA_LANG.csv"
ho=io.open(ofile,'w',encoding='utf-8')

key2langs=collections.defaultdict(list)
key2otherMD=collections.defaultdict(list)
key2lt=collections.defaultdict(list)

key2langs_pivoted=collections.defaultdict(list)
key2lothers_pivoted=collections.defaultdict(list)


def serializeLangs(thelist):
	sep="\t"
	ret=""
	if len(thelist)==1:
		ret=thelist[0]
		return ret
	
	i=0
	
	for item in thelist:
		item=item.replace("\"","")
		if(i==0):
			ret=sep.join([item,""])
		else:
			ret=sep.join([ret,item,""])
		i=i+1
	#print ret
	#print item+"-"
	return ret

def serializeOLangs(thelist):
	sep=","
	ret=""
	if len(thelist)==1:
		ret=thelist[0]
		return "\t".join([ret,""])
	
	i=0
	for item in thelist:
		item=item.replace("\"","")
		if(i<len(thelist)-1):
			ret=ret+item+sep
		else:
			ret=ret+item
		i=i+1
	#print ret
	ret="\t".join([ret,""])
	return ret

'''
structure of file input
ID (key)
conf
year
passcode
resid
ResourceType
ResourceType_clean
resourceName
resourceName_clean
ResourceProdStatus
ResourceProdStatus_clean
ResourceLang
lang_type (dim)
'''

'''
structure of outfile
conf
year
passcode
resid
ResourceType
ResourceType_clean
resourceName
resourceName_clean
ResourceProdStatus
ResourceProdStatus_clean
ResourceLang_1
ResourceLang_1_clean
ResourceLang_2
ResourceLang_2_clean
ResourceLang_3
ResourceLang_3_clean
ResourceLang_4
ResourceLang_4_clean
ResourceLang_5
ResourceLang_5_clean
ResourceLang_O
ResourceLang_O_clean
langdim
'''
num_max_langs=5
oline="\t".join(["conf","year","passcode","resid","ResourceType","ResourceType_clean","resourceName","resourceName_clean","ResourceProdStatus","ResourceProdStatus_clean","ResourceLang_1"
,"ResourceLang_1_clean"
,"ResourceLang_2"
,"ResourceLang_2_clean"
,"ResourceLang_3"
,"ResourceLang_3_clean"
,"ResourceLang_4"
,"ResourceLang_4_clean"
,"ResourceLang_5"
,"ResourceLang_5_clean"
,"ResourceLang_O"
,"ResourceLang_O_clean"
,"langdim"])
ho.write(oline.decode('utf-8')+"\n")
c=1
for l in hr:
	
	l_stripped=l.strip()
	fields=l_stripped.split("\t")
	key=fields[0]
	conf=fields[1]
	year=fields[2]
	passcode=fields[3]
	resid=fields[4]
	ResourceType=fields[5]
	ResourceType_clean=fields[6]
	resourceName=fields[7]
	resourceName_clean=fields[8]
	ResourceProdStatus=fields[9]
	ResourceProdStatus_clean=fields[10]
	ResourceLang=fields[11]
	lang_type=fields[12]
	line="\t".join([conf,year,passcode,resid,ResourceType,ResourceType_clean,resourceName,resourceName_clean,ResourceProdStatus,ResourceProdStatus_clean])    
	key2langs[key].append(ResourceLang)
	key2lt[key].append(lang_type)

	key2otherMD[key].append(line)
	c=c+1

for k,ls in key2langs.iteritems():
	others=[]
	if len(ls) <=5:
		for i in range(0,5-len(ls)):
			ls.append("")
	else:		
		for i in range(5,len(ls)):
			others.append(ls[i].strip(" "))
	lstr=serializeLangs(ls)
	if len(others)==0:
		
		others.append("")
        ostr=serializeOLangs(others)
	key2langs_pivoted[k].append(lstr)
	key2lothers_pivoted[k].append(ostr)
	#print k,lstr,ostr
	
	



print "len(ifile) "+str(c)+ " len(key2otherMD) " +str(len(key2otherMD))

lstr=""	
for k,os in key2otherMD.iteritems():
	lstr=key2langs_pivoted.get(k)[0]
	ostr=key2lothers_pivoted.get(k)[0]
	ltstr=key2lt.get(k)[0]
	o=key2otherMD.get(k)[0]
	oline="\t".join([o,lstr,ostr,ltstr])
	ho.write(oline+"\n")
	print o, lstr,ostr,ltstr
	
		


