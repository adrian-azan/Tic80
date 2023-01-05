import os

def arrayToString(values):
    output = ""
    if len(values) <= 8800:
        for value in values:
            output += value
    return output + "\n\n"

includes = dict()
#COLLECT INCLUDES
for file in os.listdir():
    try:
        #we dont need to read the contents of the builded program
        if file.find("build") == -1 and file.find("compiler.py") == -1:
            with open(file) as fin:
                content = fin.readlines()
                includes[file] = content
    except:
        print("Folder")


mainLines = []
#FIND INCLUDES
with open("main.nut") as fin:
    mainLines = fin.readlines()
    for i in range(len(mainLines)):
        if mainLines[i].startswith("#include"):
            fileNameIndex = mainLines[i].find(" ") + 1
            fileName = mainLines[i][fileNameIndex:-1]
            mainLines[i] = arrayToString(includes[fileName])

#INCLUDE
buildOutput = arrayToString(mainLines)


#OUTPUT
with open("build.nut", "w") as fout:
    fout.writelines(buildOutput)