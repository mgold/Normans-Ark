from sys import stderr
from collections import Counter

class Error:
    def __init__(self, name, cat):
        self.name = name
        self.cat = cat
        self.failers = set()
        categories.add(cat)

    def addFailer(self, failer):
        self.failers.add(failer)

    def __str__(self):
        ret = self.name+","+self.cat+","
        total = 0
        for failer in self.failers:
            student = students[failer]
            assert(student.hasError(self.name))
            total += student.getScore()
        ret += str(round(total/len(self.failers),5))
        for failer in self.failers:
            ret += ","+failer
        return ret

class Student:
    def __init__(self):
        self.results = Counter();

    def addResult(self, result):
        self.results[result] += 1

    def hasError(self, errName):
        return errName in self.results

    def getScore(self):
        return float(self.results["passed"]) / sum(self.results.values())

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
    e = genericErrors(witness)
    if e:
        return e
    if "bad cell count" in witness:
        return Error("Bad cell count", "Cells")
    elif "bad contents" in witness:
        return Error("Bad contents", "Cells")
    elif "bad" in witness and "pointer" in witness:
        return Error("Bad pointer", "Cells")
    elif "bad return value" in witness:
        return Error("Bad return value", "Cells")
    elif "block size too large" in witness:
        return Error("Block size too large", "Cells")
    elif "block size too small" in witness:
        return Error("Block size too small", "Cells")
    elif "cannot allocate" in witness:
        return Error("Cannot allocate array", "Cells")
    elif "bounds check" in witness:
        return Error("Bounds check", "Cells")
    elif "not in contiguous memory" in witness:
        return Error("Noncontiguous memory", "Cells")
    elif "visited block twice" in witness:
        return Error("Visited block twice", "Cells")
    else:
        stderr.write("Warning: Unrecognized witness \""+witness+"\"\n")
        return None

if __name__ == "__main__":
    from sys import argv;
    from string import lower, split, join;
    if len(argv) != 2:
        print "Must supply exactly 1 data file."
        exit();

    filename = argv[1]
    if "unit" in filename:
        errorFun = unitErrors
    else:
        stderr.write("Warning: No customized witness detection available for file.\n")
        errorFun = genericErrors

    categories = set()
    errors = {}
    students = {}
    with open(filename) as file:
        for line in file:
            words = split(split(line, ",")[1])
            student = words[0]
            result = words[1]
            witness = lower(join(words[3:]))
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

    catstr = ""
    for cat in categories:
        catstr += cat+","
    print catstr[:-1]
    for error in errors.values():
        print error
    print len(students)

    #for name in students.keys():
    #    print name

