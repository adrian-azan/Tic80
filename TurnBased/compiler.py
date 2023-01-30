import os


rootPath = os.getcwd()
extension = ".azn"


def arrayToString(values):
    output = ""
    if len(values) <= 100000:
        for value in values:
            output += value
    return output + "\n\n"

def traverseFolder(path, depth):
    if int(depth) >= 5:
        return None

    for file in os.listdir(path):
        currentPath = os.path.join(path,file)
        try:
            #we dont need to read the contents of the builded program
            if os.path.isfile(currentPath) and file[-4:] == extension:
                with open(currentPath, 'r') as fin:
                    content = fin.readlines()
                    includes[file] = content
        except:
            print("Issue opening {}".format(file))

    for folder in os.listdir(path):
        if os.path.isdir(os.path.join(path,folder)):
            traverseFolder(os.path.join(path,folder), depth+1)










includes = dict()
mainLines = list()
print("COMPILING INCLUDES")
traverseFolder(rootPath,0)




print("INSERTING INCLUDES")
try:
    with open("main.nut") as fin:
        mainLines = fin.readlines()
        for i in range(len(mainLines)):
            if mainLines[i].startswith("#include"):
                fileNameIndex = mainLines[i].find(" ") + 1
                fileName = mainLines[i][fileNameIndex:].rstrip()

                if fileName.find(extension) == -1:
                    fileName += extension

                mainLines[i] = arrayToString(includes[fileName])
except Exception as Error:
    print("{} Could not open main.nut".format(Error))
    exit(-1)


#INCLUDE
buildOutput = arrayToString(mainLines)


#OUTPUT
print("OUTPUTING")

with open("build.nut", "w") as fout:
    fout.writelines(buildOutput)
