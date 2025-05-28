package me.spencernold.tlang;

import me.spencernold.tlang.Errors;

import me.spencernold.tlang.lexer.Token;
import me.spencernold.tlang.lexer.Type;

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
    \"   { yybegin(YYINITIAL); return new Token<>(Type.STRING_LIT, buffer.toString()); }
    .    { buffer.append(yytext()); }
}

<STRING_SQ> {
    \\n  { buffer.append('\n'); }
    \\r  { buffer.append('\r'); }
    \\t  { buffer.append('\t'); }
    \\f  { buffer.append('\f'); }
    \\\\ { buffer.append('\\'); }
    \\'  { buffer.append('\''); }
    '    { yybegin(YYINITIAL); return new Token<>(Type.STRING_LIT, buffer.toString()); }
    .    { buffer.append(yytext()); }
}

<STRING_BT> {
    \\n  { buffer.append('\n'); }
    \\r  { buffer.append('\r'); }
    \\t  { buffer.append('\t'); }
    \\f  { buffer.append('\f'); }
    \\\\ { buffer.append('\\'); }
    \\`  { buffer.append('`'); }
    `    { yybegin(YYINITIAL); return new Token<>(Type.STRING_LIT, buffer.toString()); }
    .    { buffer.append(yytext()); }
}

<YYINITIAL> {
    "("                    { return new Token<>(Type.O_PARENTHESES); }
    ")"                    { return new Token<>(Type.C_PARENTHESES); }
    "{"                    { return new Token<>(Type.O_C_BRACKET); }
    "}"                    { return new Token<>(Type.C_C_BRACKET); }
    "["                    { return new Token<>(Type.O_BRACKET); }
    "]"                    { return new Token<>(Type.C_BRACKET); }
    "."                    { return new Token<>(Type.DOT); }
    ","                    { return new Token<>(Type.COMMA); }

    "true"                 { return new Token<>(Type.TRUE_VALUE); }
    "false"                { return new Token<>(Type.FALSE_VALUE); }
    "null"                 { return new Token<>(Type.NULL_VALUE); }

    "int8"                 { return new Token<>(Type.INT8); }
    "int16"                { return new Token<>(Type.INT16); }
    "int32"                { return new Token<>(Type.INT32); }
    "int64"                { return new Token<>(Type.INT64); }
    "uint8"                { return new Token<>(Type.UINT8); }
    "uint16"               { return new Token<>(Type.UINT16); }
    "uint32"               { return new Token<>(Type.UINT32); }
    "uint64"               { return new Token<>(Type.UINT64); }
    "char"                 { return new Token<>(Type.CHAR); }
    "bool"                 { return new Token<>(Type.BOOL); }
    "float32"              { return new Token<>(Type.FLOAT32); }
    "float64"              { return new Token<>(Type.FLOAT64); }
    "function"             { return new Token<>(Type.FUNCTION); }
    "void"                 { return new Token<>(Type.VOID); }
    "string"               { return new Token<>(Type.STRING); }

    "include"              { return new Token<>(Type.INCLUDE); }
    "private"              { return new Token<>(Type.PRIVATE); }
    "protected"            { return new Token<>(Type.PROTECTED); }
    "class"                { return new Token<>(Type.CLASS); }
    "enum"                 { return new Token<>(Type.ENUM); }
    "interface"            { return new Token<>(Type.INTERFACE); }
    "new"                  { return new Token<>(Type.NEW); }
    "extends"              { return new Token<>(Type.EXTENDS); }
    "implements"           { return new Token<>(Type.IMPLEMENTS); }
    "abstract"             { return new Token<>(Type.ABSTRACT); }
    "final"                { return new Token<>(Type.FINAL); }
    "assert"               { return new Token<>(Type.ASSERT); }
    "this"                 { return new Token<>(Type.THIS); }
    "return"               { return new Token<>(Type.RETURN); }
    "if"                   { return new Token<>(Type.IF); }
    "else"                 { return new Token<>(Type.ELSE); }
    "for"                  { return new Token<>(Type.FOR); }
    "in"                   { return new Token<>(Type.IN); }
    "range"                { return new Token<>(Type.RANGE); }
    "while"                { return new Token<>(Type.WHILE); }
    "continue"             { return new Token<>(Type.CONTINUE); }
    "break"                { return new Token<>(Type.BREAK); }
    "is"                   { return new Token<>(Type.IS); }
    "async"                { return new Token<>(Type.ASYNC); }
    "future"               { return new Token<>(Type.FUTURE); }
    "unsafe"               { return new Token<>(Type.UNSAFE); }
    "defer"                { return new Token<>(Type.DEFER); }
    "external"             { return new Token<>(Type.EXTERNAL); }

    "="                    { return new Token<>(Type.EQ_OPER); }
    "+"                    { return new Token<>(Type.ADD_OPER); }
    "-"                    { return new Token<>(Type.SUB_OPER); }
    "*"                    { return new Token<>(Type.MUL_OPER); }
    "/"                    { return new Token<>(Type.DIV_OPER); }
    "%"                    { return new Token<>(Type.MOD_OPER); }
    "+="                   { return new Token<>(Type.ADD_EQ_OPER); }
    "-="                   { return new Token<>(Type.SUB_EQ_OPER); }
    "*="                   { return new Token<>(Type.MUL_EQ_OPER); }
    "/="                   { return new Token<>(Type.DIV_EQ_OPER); }
    "%="                   { return new Token<>(Type.MOD_EQ_OPER); }
    "++"                   { return new Token<>(Type.INCR_OPER); }
    "--"                   { return new Token<>(Type.DECR_OPER); }
    "**"                   { return new Token<>(Type.POW_OPER); }
    ">"                    { return new Token<>(Type.GT_OPER); }
    "<"                    { return new Token<>(Type.LT_OPER); }
    ">="                   { return new Token<>(Type.GT_EQ_OPER); }
    "<="                   { return new Token<>(Type.LT_EQ_OPER); }
    "&"                    { return new Token<>(Type.BIT_AND_OPER); }
    "|"                    { return new Token<>(Type.BIT_OR_OPER); }
    "~"                    { return new Token<>(Type.BIT_NOT_OPER); }
    "^"                    { return new Token<>(Type.BIT_XOR_OPER); }
    "<<"                   { return new Token<>(Type.BIT_SHL_OPER); }
    ">>"                   { return new Token<>(Type.BIT_SHR_OPER); }
    "and"                  { return new Token<>(Type.AND_OPER); }
    "or"                   { return new Token<>(Type.OR_OPER); }
    "not"                  { return new Token<>(Type.NOT_OPER); }
    "?"                    { return new Token<>(Type.TERNARY_OPER); }

    "-"?[1-9][0-9]*        { return new Token<>(Type.DECIMAL, Long.parseLong(yytext())); }
    "0x"[0-9a-fA-F]+       { return new Token<>(Type.DECIMAL, Long.parseLong(yytext().substring(2), 16)); }
    "-"?[0-9]+"."[0-9]*    { return new Token<>(Type.FLOATING_POINT, Double.parseDouble(yytext())); }
    [a-zA-Z_][a-zA-Z0-9_]* { return new Token<>(Type.IDENTIFIER, yytext()); }
    [ \t\r]+               { return new Token<>(Type.WHITESPACE); }
    [\n]                   { line++; }

    .                      { Errors.print("Unexpected token", line, yytext()); return new Token<>(Type.ERROR); }
    <<EOF>>                { return null; }
}