%{
#include <stdio.h>
#include <string.h>
int line_num = 1;
%}

DIGIT    [0-9]
ID       [a-zA-Z_][a-zA-Z0-9_]*

%%

\n        { line_num++; }
[ \t]+    ;

"><".*"><"    ;  /* Ignore custom comments */
"//".*        ;  /* Ignore single line comments */

/* ---------- KEYWORDS ---------- */
"Suppose"       { printf("Line %d: KEYWORD_IF -> %s\n", line_num, yytext); }
"Suppose_else"  { printf("Line %d: KEYWORD_ELSE -> %s\n", line_num, yytext); }
"Because_of"    { printf("Line %d: KEYWORD_FOR -> %s\n", line_num, yytext); }
"give_out"      { printf("Line %d: KEYWORD_RETURN -> %s\n", line_num, yytext); }
"Correct"       { printf("Line %d: KEYWORD_TRUE -> %s\n", line_num, yytext); }
"Incorrect"     { printf("Line %d: KEYWORD_FALSE -> %s\n", line_num, yytext); }
"take"          { printf("Line %d: KEYWORD_CIN -> %s\n", line_num, yytext); }
"show"          { printf("Line %d: KEYWORD_COUT -> %s\n", line_num, yytext); }
"Digit"         { printf("Line %d: KEYWORD_INT -> %s\n", line_num, yytext); }
"Word"          { printf("Line %d: KEYWORD_CHAR -> %s\n", line_num, yytext); }
"STOP"          { printf("Line %d: KEYWORD_BREAK -> %s\n", line_num, yytext); }
"empty"         { printf("Line %d: KEYWORD_VOID -> %s\n", line_num, yytext); }
"choice"        { printf("Line %d: KEYWORD_OR -> %s\n", line_num, yytext); }
"also"          { printf("Line %d: KEYWORD_AND -> %s\n", line_num, yytext); }
"Decimal"       { printf("Line %d: KEYWORD_FLOAT -> %s\n", line_num, yytext); }

/* ---------- OPERATORS ---------- */
"equal"             { printf("Line %d: OPERATOR_EQUALTO -> %s\n", line_num, yytext); }
"greater_or_equal"  { printf("Line %d: OPERATOR_GREATEREQ -> %s\n", line_num, yytext); }
"lesser_or_equal"   { printf("Line %d: OPERATOR_LESSEREQ -> %s\n", line_num, yytext); }
"not_equal"         { printf("Line %d: OPERATOR_NOTEQUAL -> %s\n", line_num, yytext); }
"AND"               { printf("Line %d: OPERATOR_AND -> %s\n", line_num, yytext); }
"OR"                { printf("Line %d: OPERATOR_OR -> %s\n", line_num, yytext); }
"++"                { printf("Line %d: OPERATOR_INCREMENT -> %s\n", line_num, yytext); }
"--"                { printf("Line %d: OPERATOR_DECREMENT -> %s\n", line_num, yytext); }
"mult"              { printf("Line %d: OPERATOR_MULTIPLY -> %s\n", line_num, yytext); }
"add"               { printf("Line %d: OPERATOR_ADDITION -> %s\n", line_num, yytext); }
"subtract"          { printf("Line %d: OPERATOR_SUBTRACT -> %s\n", line_num, yytext); }
"!"                 { printf("Line %d: OPERATOR_NEGATION -> %s\n", line_num, yytext); }
"="                 { printf("Line %d: OPERATOR_ASSIGNMENT -> %s\n", line_num, yytext); }
">"                 { printf("Line %d: OPERATOR_GREATER -> %s\n", line_num, yytext); }
"<"                 { printf("Line %d: OPERATOR_LESSER -> %s\n", line_num, yytext); }
"divide"            { printf("Line %d: OPERATOR_DIVIDE -> %s\n", line_num, yytext); }
"%"                 { printf("Line %d: OPERATOR_MODULO -> %s\n", line_num, yytext); }

/* ---------- PUNCTUATION ---------- */
"("     { printf("Line %d: PUNC_LEFTPARENTHESIS -> %s\n", line_num, yytext); }
")"     { printf("Line %d: PUNC_RIGHTPARENTHESIS -> %s\n", line_num, yytext); }
"{"     { printf("Line %d: PUNC_LEFTBRACE -> %s\n", line_num, yytext); }
"}"     { printf("Line %d: PUNC_RIGHTBRACE -> %s\n", line_num, yytext); }
";"     { printf("Line %d: PUNC_SEMICOLON -> %s\n", line_num, yytext); }
","     { printf("Line %d: PUNC_COMMA -> %s\n", line_num, yytext); }
":"     { printf("Line %d: PUNC_COLON -> %s\n", line_num, yytext); }

/* ---------- NUMBERS, STRINGS, CHARACTERS ---------- */
{DIGIT}+"."{DIGIT}+    { printf("Line %d: FLOAT -> %s\n", line_num, yytext); }
{DIGIT}+                { printf("Line %d: INTEGER -> %s\n", line_num, yytext); }
\"([^"\\]|\\[\\"tn])*\" { printf("Line %d: STRING -> %s\n", line_num, yytext); }
\'[^']\'                { printf("Line %d: CHAR -> %s\n", line_num, yytext); }

/* ---------- IDENTIFIER / INVALID VARIATION DETECTION ---------- */
{ID} {
    char *keywords[] = {
        "Suppose","Suppose_else","Because_of","give_out","Correct","Incorrect",
        "take","show","Digit","Word","STOP","empty","choice","also","Decimal",NULL
    };
    char *operators[] = {
        "equal","greater_or_equal","lesser_or_equal","not_equal","AND","OR",
        "mult","add","subtract","divide",NULL
    };
    char *puncts[] = {
        "(",")","{","}",";",",",":",NULL
    };

    int is_near_keyword = 0;
    for (int i = 0; keywords[i]; i++) {
        if (strcasecmp(yytext, keywords[i]) == 0 && strcmp(yytext, keywords[i]) != 0) {
            is_near_keyword = 1;
            break;
        }
    }

    int is_near_operator = 0;
    for (int i = 0; operators[i]; i++) {
        if (strcasecmp(yytext, operators[i]) == 0 && strcmp(yytext, operators[i]) != 0) {
            is_near_operator = 1;
            break;
        }
    }

    int is_near_punct = 0;
    for (int i = 0; puncts[i]; i++) {
        if (strcmp(yytext, puncts[i]) == 0) {
            is_near_punct = 1;
            break;
        }
    }

    if (is_near_keyword)
        printf("Line %d: ERROR -> Invalid keyword capitalization or variation: %s\n", line_num, yytext);
    else if (is_near_operator)
        printf("Line %d: ERROR -> Invalid operator variation: %s\n", line_num, yytext);
    else if (is_near_punct)
        printf("Line %d: ERROR -> Invalid punctuation usage: %s\n", line_num, yytext);
    else
        printf("Line %d: IDENTIFIER -> %s\n", line_num, yytext);
}

/* ---------- DEFAULT ---------- */
.   { printf("Line %d: ANY ERROR -> %s\n", line_num, yytext); }

%%

int main() {
    yylex();
    return 0;
}
