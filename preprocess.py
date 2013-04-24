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
        stderr.write("Warning: Unrecognized witness \""+witness+"\"\n")
        return None


def umlErrors(witness):
    numComments = 0
    quoteDelim = split(witness, '"');
    if "uncaught exception" in witness:
        return Error(witness[rindex(witness, ' ')+1:-2], "Exception")
    elif "CPU time" in witness:
        return Error("CPU Time", "Runtime")
    elif "wrote the error message" in witness:
        return Error("Wrote Error", "Runtime")
    elif "signalled a bug in type inference" in witness:
        return Error("Signalled Bug", "Type Inference")
    elif "typed-incorrectly" in witness:
        return Error("Wrong Type", "Type Inference")
    elif "did-not-type" in witness:
        return Error("Did Not Type", "Type Inference")
    elif "typed-untypeable" in witness:
        return Error("Typed Untypeable", "Type Inference")
    else:
        stderr.write("Warning: Unrecognized witness \""+witness+"\"\n")
        return None

############################################################
# There should be no need to make changes below this line. #
############################################################


from sys import stderr
from collections import Counter

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

if __name__ == "__main__":
    from sys import argv;
    from string import lower, split, join, rindex;
    if len(argv) != 2:
        stderr.write("Error: Must supply exactly 1 data file.\n")
        exit();

    filename = argv[1]
    numComments = 0
    if "unit" in filename:
        errorFun = unitErrors
    elif "uml" in filename or "Additional" in filename:
        errorFun = umlErrors
    else:
        stderr.write("Warning: No customized witness detection available for file.\n")
        errorFun = genericErrors

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
                error = errorFun(witness)
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
    print numComments
    catstr = ""
    for cat, freq in categories.most_common():
        catstr += cat+","
    print catstr[:-1]
    for error in errorObs:
        print error
    failers = [s for s in students.values() if not s.isPerfect]
    print len(failers)
    for name in students.keys():
        if students[name] in failers:
            outstr = name+","
            for error in errorObs:
                outstr += str(students[name].errorFreq(error.name))+","
            outstr += str(students[name].errorFreq("passed"))
            print outstr

