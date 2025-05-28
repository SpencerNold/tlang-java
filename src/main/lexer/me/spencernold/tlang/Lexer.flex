package me.spencernold.tlang;

import me.spencernold.tlang.Errors;

import me.spencernold.tlang.lexer.Token;
import me.spencernold.tlang.lexer.TokenType;

%%
%class Lexer
%unicode
%public
%function yylex
%type me.spencernold.tlang.lexer.Token
%line
%column

%{

private final StringBuilder buffer = new StringBuilder();
private int line = 1;

public int getCurrentLineNumber() {
    return line;
}

%}

%state STRING_DQ
%state STRING_SQ
%state STRING_BT

%%

<YYINITIAL> \" { buffer.setLength(0); yybegin(STRING_DQ); }
<YYINITIAL> ' { buffer.setLength(0); yybegin(STRING_SQ); }
<YYINITIAL> ` { buffer.setLength(0); yybegin(STRING_BT); }

<STRING_DQ> {
    \\n  { buffer.append('\n'); }
    \\r  { buffer.append('\r'); }
    \\t  { buffer.append('\t'); }
    \\f  { buffer.append('\f'); }
    \\\\ { buffer.append('\\'); }
    \\\" { buffer.append('\"'); }
    \"   { yybegin(YYINITIAL); return new Token<>(TokenType.STRING_LIT, buffer.toString()); }
    .    { buffer.append(yytext()); }
}

<STRING_SQ> {
    \\n  { buffer.append('\n'); }
    \\r  { buffer.append('\r'); }
    \\t  { buffer.append('\t'); }
    \\f  { buffer.append('\f'); }
    \\\\ { buffer.append('\\'); }
    \\'  { buffer.append('\''); }
    '    { yybegin(YYINITIAL); return new Token<>(TokenType.STRING_LIT, buffer.toString()); }
    .    { buffer.append(yytext()); }
}

<STRING_BT> {
    \\n  { buffer.append('\n'); }
    \\r  { buffer.append('\r'); }
    \\t  { buffer.append('\t'); }
    \\f  { buffer.append('\f'); }
    \\\\ { buffer.append('\\'); }
    \\`  { buffer.append('`'); }
    `    { yybegin(YYINITIAL); return new Token<>(TokenType.STRING_LIT, buffer.toString()); }
    .    { buffer.append(yytext()); }
}

<YYINITIAL> {
    "("                    { return new Token<>(TokenType.O_PARENTHESES); }
    ")"                    { return new Token<>(TokenType.C_PARENTHESES); }
    "{"                    { return new Token<>(TokenType.O_C_BRACKET); }
    "}"                    { return new Token<>(TokenType.C_C_BRACKET); }
    "["                    { return new Token<>(TokenType.O_BRACKET); }
    "]"                    { return new Token<>(TokenType.C_BRACKET); }
    "."                    { return new Token<>(TokenType.DOT); }
    ","                    { return new Token<>(TokenType.COMMA); }

    "true"                 { return new Token<>(TokenType.TRUE_VALUE); }
    "false"                { return new Token<>(TokenType.FALSE_VALUE); }
    "null"                 { return new Token<>(TokenType.NULL_VALUE); }

    "int8"                 { return new Token<>(TokenType.INT8); }
    "int16"                { return new Token<>(TokenType.INT16); }
    "int32"                { return new Token<>(TokenType.INT32); }
    "int64"                { return new Token<>(TokenType.INT64); }
    "uint8"                { return new Token<>(TokenType.UINT8); }
    "uint16"               { return new Token<>(TokenType.UINT16); }
    "uint32"               { return new Token<>(TokenType.UINT32); }
    "uint64"               { return new Token<>(TokenType.UINT64); }
    "char"                 { return new Token<>(TokenType.CHAR); }
    "bool"                 { return new Token<>(TokenType.BOOL); }
    "float32"              { return new Token<>(TokenType.FLOAT32); }
    "float64"              { return new Token<>(TokenType.FLOAT64); }
    "function"             { return new Token<>(TokenType.FUNCTION); }
    "void"                 { return new Token<>(TokenType.VOID); }
    "string"               { return new Token<>(TokenType.STRING); }

    "include"              { return new Token<>(TokenType.INCLUDE); }
    "private"              { return new Token<>(TokenType.PRIVATE); }
    "protected"            { return new Token<>(TokenType.PROTECTED); }
    "class"                { return new Token<>(TokenType.CLASS); }
    "enum"                 { return new Token<>(TokenType.ENUM); }
    "interface"            { return new Token<>(TokenType.INTERFACE); }
    "new"                  { return new Token<>(TokenType.NEW); }
    "extends"              { return new Token<>(TokenType.EXTENDS); }
    "implements"           { return new Token<>(TokenType.IMPLEMENTS); }
    "abstract"             { return new Token<>(TokenType.ABSTRACT); }
    "final"                { return new Token<>(TokenType.FINAL); }
    "assert"               { return new Token<>(TokenType.ASSERT); }
    "this"                 { return new Token<>(TokenType.THIS); }
    "return"               { return new Token<>(TokenType.RETURN); }
    "if"                   { return new Token<>(TokenType.IF); }
    "else"                 { return new Token<>(TokenType.ELSE); }
    "for"                  { return new Token<>(TokenType.FOR); }
    "in"                   { return new Token<>(TokenType.IN); }
    "range"                { return new Token<>(TokenType.RANGE); }
    "while"                { return new Token<>(TokenType.WHILE); }
    "continue"             { return new Token<>(TokenType.CONTINUE); }
    "break"                { return new Token<>(TokenType.BREAK); }
    "is"                   { return new Token<>(TokenType.IS); }
    "async"                { return new Token<>(TokenType.ASYNC); }
    "future"               { return new Token<>(TokenType.FUTURE); }
    "unsafe"               { return new Token<>(TokenType.UNSAFE); }
    "defer"                { return new Token<>(TokenType.DEFER); }
    "external"             { return new Token<>(TokenType.EXTERNAL); }

    "="                    { return new Token<>(TokenType.EQ_OPER); }
    "+"                    { return new Token<>(TokenType.ADD_OPER); }
    "-"                    { return new Token<>(TokenType.SUB_OPER); }
    "*"                    { return new Token<>(TokenType.MUL_OPER); }
    "/"                    { return new Token<>(TokenType.DIV_OPER); }
    "%"                    { return new Token<>(TokenType.MOD_OPER); }
    "+="                   { return new Token<>(TokenType.ADD_EQ_OPER); }
    "-="                   { return new Token<>(TokenType.SUB_EQ_OPER); }
    "*="                   { return new Token<>(TokenType.MUL_EQ_OPER); }
    "/="                   { return new Token<>(TokenType.DIV_EQ_OPER); }
    "%="                   { return new Token<>(TokenType.MOD_EQ_OPER); }
    "++"                   { return new Token<>(TokenType.INCR_OPER); }
    "--"                   { return new Token<>(TokenType.DECR_OPER); }
    "**"                   { return new Token<>(TokenType.POW_OPER); }
    ">"                    { return new Token<>(TokenType.GT_OPER); }
    "<"                    { return new Token<>(TokenType.LT_OPER); }
    ">="                   { return new Token<>(TokenType.GT_EQ_OPER); }
    "<="                   { return new Token<>(TokenType.LT_EQ_OPER); }
    "&"                    { return new Token<>(TokenType.BIT_AND_OPER); }
    "|"                    { return new Token<>(TokenType.BIT_OR_OPER); }
    "~"                    { return new Token<>(TokenType.BIT_NOT_OPER); }
    "^"                    { return new Token<>(TokenType.BIT_XOR_OPER); }
    "<<"                   { return new Token<>(TokenType.BIT_SHL_OPER); }
    ">>"                   { return new Token<>(TokenType.BIT_SHR_OPER); }
    "and"                  { return new Token<>(TokenType.AND_OPER); }
    "or"                   { return new Token<>(TokenType.OR_OPER); }
    "not"                  { return new Token<>(TokenType.NOT_OPER); }
    "?"                    { return new Token<>(TokenType.TERNARY_OPER); }

    "-"?[1-9][0-9]*        { return new Token<>(TokenType.DECIMAL, Long.parseLong(yytext())); }
    "0x"[0-9a-fA-F]+       { return new Token<>(TokenType.DECIMAL, Long.parseLong(yytext().substring(2), 16)); }
    "-"?[0-9]+"."[0-9]*    { return new Token<>(TokenType.FLOATING_POINT, Double.parseDouble(yytext())); }
    [a-zA-Z_][a-zA-Z0-9_]* { return new Token<>(TokenType.IDENTIFIER, yytext()); }
    [ \t\r]+               { /* return new Token<>(TokenType.WHITESPACE); */ }
    [\n]                   { line++; }

    .                      { Errors.print("Unexpected token", line, yytext()); return new Token<>(TokenType.ERROR); }
    <<EOF>>                { return null; }
}