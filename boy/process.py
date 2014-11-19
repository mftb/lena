import os

images = ['baboon', 'monarch', 'peppers', 'retina', 'sonnet', 'wedge']
cwdir = os.getcwd()
for img in images:
    os.system("mkdir " + img)
    cwdir = os.getcwd()
    os.chdir(cwdir + "/" + img)
    os.system("cp ../" + img + ".pgm  ./")
    os.system("cp ../lab03.m ./")
    os.system("./lab03.m " + img + ".pgm")
    os.chdir(cwdir)
