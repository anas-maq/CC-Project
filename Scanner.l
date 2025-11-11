%{
#include <stdio.h>
#include <string.h>
int line_num = 1;
%}

DIGIT   [0-9]
ID      [a-zA-Z_][a-zA-Z0-9_]*

%%

\n          { line_num++; }
[ \t\r]+    ;

"Suppose"        { printf("Line %d: KEYWORD_IF -> %s\n", line_num, yytext); }
"Suppose_else"   { printf("Line %d: KEYWORD_ELSE -> %s\n", line_num, yytext); }
"Because_of"     { printf("Line %d: KEYWORD_FOR -> %s\n", line_num, yytext); }
"give_out"       { printf("Line %d: KEYWORD_RETURN -> %s\n", line_num, yytext); }
"Correct"        { printf("Line %d: KEYWORD_TRUE -> %s\n", line_num, yytext); }
"Incorrect"      { printf("Line %d: KEYWORD_FALSE -> %s\n", line_num, yytext); }
"take"           { printf("Line %d: KEYWORD_INPUT -> %s\n", line_num, yytext); }
"show"           { printf("Line %d: KEYWORD_OUTPUT -> %s\n", line_num, yytext); }
"Digit"          { printf("Line %d: KEYWORD_INT -> %s\n", line_num, yytext); }
"Word"           { printf("Line %d: KEYWORD_CHAR -> %s\n", line_num, yytext); }
"STOP"           { printf("Line %d: KEYWORD_BREAK -> %s\n", line_num, yytext); }
"empty"          { printf("Line %d: KEYWORD_VOID -> %s\n", line_num, yytext); }
"choice"         { printf("Line %d: KEYWORD_OR -> %s\n", line_num, yytext); }
"also"           { printf("Line %d: KEYWORD_AND -> %s\n", line_num, yytext); }
"Decimal"        { printf("Line %d: KEYWORD_FLOAT -> %s\n", line_num, yytext); }

"equal"             { printf("Line %d: OP_EQUALTO -> %s\n", line_num, yytext); }
"greater_or_equal"  { printf("Line %d: OP_GREATEREQ -> %s\n", line_num, yytext); }
"lesser_or_equal"   { printf("Line %d: OP_LESSEREQ -> %s\n", line_num, yytext); }
"not_equal"         { printf("Line %d: OP_NOTEQUAL -> %s\n", line_num, yytext); }
"AND"               { printf("Line %d: OP_AND -> %s\n", line_num, yytext); }
"OR"                { printf("Line %d: OP_OR -> %s\n", line_num, yytext); }
"++"                { printf("Line %d: OP_INCREMENT -> %s\n", line_num, yytext); }
"--"                { printf("Line %d: OP_DECREMENT -> %s\n", line_num, yytext); }
"mult"              { printf("Line %d: OP_MULTIPLY -> %s\n", line_num, yytext); }
"add"               { printf("Line %d: OP_ADD -> %s\n", line_num, yytext); }
"subtract"          { printf("Line %d: OP_SUBTRACT -> %s\n", line_num, yytext); }
"divide"            { printf("Line %d: OP_DIVIDE -> %s\n", line_num, yytext); }
"="                 { printf("Line %d: OP_ASSIGNMENT -> %s\n", line_num, yytext); }
">"                 { printf("Line %d: OP_GREATER -> %s\n", line_num, yytext); }
"<"                 { printf("Line %d: OP_LESSER -> %s\n", line_num, yytext); }
"%"                 { printf("Line %d: OP_MODULO -> %s\n", line_num, yytext); }
"!"                 { printf("Line %d: OP_NEGATION -> %s\n", line_num, yytext); }

"("     { printf("Line %d: PUNC_LPAREN -> %s\n", line_num, yytext); }
")"     { printf("Line %d: PUNC_RPAREN -> %s\n", line_num, yytext); }
"{"     { printf("Line %d: PUNC_LBRACE -> %s\n", line_num, yytext); }
"}"     { printf("Line %d: PUNC_RBRACE -> %s\n", line_num, yytext); }
";"     { printf("Line %d: PUNC_SEMICOLON -> %s\n", line_num, yytext); }
","     { printf("Line %d: PUNC_COMMA -> %s\n", line_num, yytext); }
":"     { printf("Line %d: PUNC_COLON -> %s\n", line_num, yytext); }

{DIGIT}+"."{DIGIT}+   { printf("Line %d: FLOAT -> %s\n", line_num, yytext); }
{DIGIT}+               { printf("Line %d: INTEGER -> %s\n", line_num, yytext); }

{ID} {
    const char *keywords[] = {
        "Suppose","Suppose_else","Because_of","give_out","Correct","Incorrect",
        "take","show","Digit","Word","STOP","empty","choice","also","Decimal",NULL
    };
    const char *operators[] = {
        "equal","greater_or_equal","lesser_or_equal","not_equal","AND","OR",
        "mult","add","subtract","divide",NULL
    };
    int i, keyword_error = 0, operator_error = 0;
    for (i = 0; keywords[i]; i++)
        if (strcasecmp(yytext, keywords[i]) == 0 && strcmp(yytext, keywords[i]) != 0)
            keyword_error = 1;
    for (i = 0; operators[i]; i++)
        if (strcasecmp(yytext, operators[i]) == 0 && strcmp(yytext, operators[i]) != 0)
            operator_error = 1;
    if (keyword_error)
        printf("Line %d: ERROR -> Invalid keyword capitalization or variation: %s\n", line_num, yytext);
    else if (operator_error)
        printf("Line %d: ERROR -> Invalid operator capitalization or variation: %s\n", line_num, yytext);
    else
        printf("Line %d: IDENTIFIER -> %s\n", line_num, yytext);
}

.   { printf("Line %d: UNKNOWN SYMBOL -> %s\n", line_num, yytext); }

%%

int main() {
    yylex();
    return 0;
}
