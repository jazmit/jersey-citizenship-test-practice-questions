#!/usr/bin/awk -f
function printHeader() {
    print "<!DOCTYPE html>"
    print "<html><body>"
    print "<h1>Jersey Citizenship Test Practice Questions</h1>"
    print "<link href=\"qs.css\" rel=\"stylesheet\">"
    print "<div class='qs-container'>"
}

function printQ(question, N, ansT, ansA) {
    print "<div class='q-container'>"
    print "<h3 class='q'>" question "</h3>"
    print "<div class='a-container'>"
    for (n = 0; n < N; n++) {
        printAnswer(question, ansT[n], ansA[n])
    }
    print "</div>"
    print "</div>"
}

function printAnswer(question, answer, isCorrect) {
    print "<label class='ans-" isCorrect "' style=\"order:" int(20 * rand()) "\">"
    print "<input type=radio name='" question "'> "
    print "<span>" answer "</span>"
    print "</label>"
}

function printFooter() {
    print "</div>"
    print "</body></html>"
}

BEGIN {
    RS="\n\n"
    FS="\n"
    printHeader()
}

{
    for (n = 1; n <= NF; n++)

        sub(/^- /, "", $n)
    ansT[0] = $2
    ansA[0] = "correct"
    for(n=3; n<=NF; n++) {
        ansT[n - 2] = $n
        ansA[n - 2] = "wrong"
    }
    printQ($1, NF - 1, ansT, ansA)

}

END {
    printFooter()
}
