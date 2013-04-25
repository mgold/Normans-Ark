# Norman's Ark Preprocessor
#
# Error functions are expected to return Error(name, category)
# where name and category are strings. Optionally, they may also return
# an array of strings to be shown as comments. If comments are returned
# by an error function, they must be returned in all cases.
#
# pickErrorFun decides which error function to call based on the file name.

def pickErrorFun(filename):
    if "unit" in filename:
        return unitErrors
    elif "uml" in filename or "Additional" in filename:
        return umlErrors
    else:
        stderr.write("Warning: No customized witness detection available for file.\n")
        return genericErrors

def genericErrors(witness):
    if "assertion" in witness:
        return Error("Assertion", "Termination")
    elif "exception" in witness:
        return Error("Exception", "Termination")
    elif "segmentation fault" in witness:
        return Error("Segfault", "Termination")
    elif "no executable" in witness:
        return Error("No executable", "Termination")
    elif "junk on stderr" in witness:
        return Error("Junk on stderr", "Output")
    elif "junk on stdout" in witness:
        return Error("Junk on stdout", "Output")
    else:
        return None

def unitErrors(witness):
    witness = lower(witness)
    e = genericErrors(witness)
    if e:
        return e
    if "bad cell count" in witness:
        return Error("Bad cell count", "Cells")
    elif "bad contents" in witness:
        return Error("Bad contents", "Cells")
    elif "bad" in witness and "pointer" in witness:
        return Error("Bad pointer", "Memory")
    elif "bad return value" in witness:
        return Error("Bad return value", "Cells")
    elif "block size too large" in witness:
        return Error("Block size too large", "Cells")
    elif "block size too small" in witness:
        return Error("Block size too small", "Cells")
    elif "cannot allocate" in witness:
        return Error("Cannot allocate array", "Memory")
    elif "bounds check" in witness:
        return Error("Bounds check", "Cells")
    elif "not in contiguous memory" in witness:
        return Error("Noncontiguous memory", "Memory")
    elif "visited block twice" in witness:
        return Error("Visited block twice", "Cells")
    else:
        stderr.write('Warning: Unrecognized witness "'+witness+'"\n')
        return None


def umlErrors(witness):
    comment = umlComment(witness)
    if "uncaught exception" in witness:
        return Error(witness[rindex(witness, ' ')+1:-3], "Exception"), comment
    elif "CPU time" in witness:
        return Error("CPU Time", "Runtime"), comment
    elif "wrote the error message" in witness:
        return Error("Wrote Error", "Runtime"), comment
    elif "signalled a bug in type inference" in witness:
        return Error("Signalled Bug", "Type Inference"), comment
    elif "typed-incorrectly" in witness:
        return Error("Wrong Type", "Type Inference"), comment
    elif "did-not-type" in witness:
        return Error("Did Not Type", "Type Inference"), comment
    elif "typed-untypeable" in witness:
        return Error("Typed Untypeable", "Type Inference"), comment
    else:
        stderr.write('Warning: Unrecognized witness "'+witness+'"\n')
        return None

def umlComment(witness):
    quotedelim = split(witness, '"');
    test = split(witness)[1]+"-"+split(witness)[3][0]
    term = ' '.join(quotedelim[1].split())
    if "uML type error" in witness:
        shouldbe = "type error"
    else:
        shouldbe = quotedelim[3]
    if "uncaught exception" in witness:
        got = "exception "+witness[rindex(witness, ' ')+1:-3]
    elif "CPU time" in witness:
        got = "CPU timeout"
    elif "signalled a bug in type inference" in witness:
        if "typed-untypeable" in witness:
            got = "signaled bug: "+quotedelim[3]
        else:
            got = "signaled bug: "+quotedelim[5]
    elif "typed-incorrectly" in witness:
        got = quotedelim[5]
    elif "did-not-type" in witness:
        got = "type error: "+quotedelim[5]
    elif "wrote the error message" in witness:
        if "typed-untypeable" in witness:
            got = "error: "+quotedelim[3]
        else:
            got = "error: "+quotedelim[5]
    elif "typed-untypeable" in witness:
        got = quotedelim[3]
    else:
        stderr.write('Warning: Unable to finish comment for "'+witness+'"\n')
        return ["Term "+term, "Is "+shouldbe]
    return ["Test "+test,"Term "+term, "Is "+shouldbe, "Got "+got]

############################################################
# There should be no need to make changes below this line. #
############################################################

class Error:
    def __init__(self, name, cat):
        self.name = name
        self.cat = cat
        self.failers = set()
        categories[cat] += 1

    def addFailer(self, failer):
        self.failers.add(failer)

    def __str__(self):
        ret = self.name+","+self.cat+","
        total = 0
        for failer in self.failers:
            student = students[failer]
            assert(student.hasError(self.name))
            total += student.getScore()
        ret += str(round(total/len(self.failers),5))+","
        ret += str(len(self.failers))
        return ret

class Student:
    def __init__(self):
        self.results = Counter();
        self.isPerfect = True
        self.comments = {}

    def addResult(self, result):
        self.results[result] += 1
        if result != "passed":
            self.isPerfect = False

    def hasError(self, errName):
        return errName in self.results

    def errorFreq(self, errName):
        return self.results[errName]

    def getScore(self):
        return float(self.results["passed"]) / sum(self.results.values())

    def addCommentForError(self, cmnt, error):
        if error not in self.comments:
            self.comments[error] = []
        self.comments[error].append(cmnt)

    def printCommentForError(self, error):
        if error in self.comments:
            for cmntList in self.comments[error]:
                outstr = ""
                for cmntStr in cmntList:
                    outstr += "|"+cmntStr
                print outstr

if __name__ == "__main__":
    from sys import argv;
    from sys import stderr, version_info

    if version_info[0] != 2 or version_info[1] != 7:
        stderr.write("Error: Must use Python 2.7.\n")
        exit();
    if len(argv) != 2:
        stderr.write("Error: Must supply exactly 1 data file.\n")
        exit();

    from collections import Counter
    from string import lower, split, join, rindex

    filename = argv[1]
    numCommentLines = 0
    errorFun = pickErrorFun(filename)

    categories = Counter() # string
    errors = {} # string -> Error
    students = {} # string -> Student
    with open(filename) as file:
        for witness in file:
            words = split(split(witness, ",")[1])
            student = words[0]
            result = words[1]
            if student not in students:
                students[student] = Student()
            if result != "passed":
                returned = errorFun(witness)
                if isinstance(returned, tuple):
                    error = returned[0]
                    comment = returned[1]
                    if len(returned) > 2 or not isinstance(comment, list) or not isinstance(comment[0], str):
                        stderr.write("Error: expected comment to be a list of of strings.\n")
                        exit();
                    numCommentLines = max(numCommentLines, len(comment))
                    students[student].addCommentForError(comment, error.name)
                else:
                    error = returned
                if error:
                    if error.name not in errors:
                        errors[error.name] = error
                    errors[error.name].addFailer(student)
                    students[student].addResult(error.name)
                else:
                    students[student].addResult(witness)
            else:
                students[student].addResult("passed")


    errorObs = errors.values()
    print numCommentLines
    catstr = ""
    for cat, freq in categories.most_common():
        catstr += cat+","
    print catstr[:-1]
    for error in errorObs:
        print error
    failers = [s for s in students.values() if not s.isPerfect]
    print len(failers)
    for name in students.keys():
        student = students[name]
        if student in failers:
            outstr = name+","
            for error in errorObs:
                outstr += str(student.errorFreq(error.name))+","
            outstr += str(student.errorFreq("passed"))
            print outstr
            for error in errorObs:
                student.printCommentForError(error.name)


