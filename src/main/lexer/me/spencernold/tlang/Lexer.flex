package me.spencernold.tlang;

import me.spencernold.tlang.lexer.LexException;

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
private int index = 0;

private Token<?> token(int type) {
    return token(type, null);
}

private <T> Token<T> token(int type, T value) {
    Token<T> token = new Token<T>(type, value, line, index);
    index += yytext().length();
    return token;
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
    \"   { yybegin(YYINITIAL); return token(TokenType.STRING_LIT, buffer.toString()); }
    .    { buffer.append(yytext()); }
}

<STRING_SQ> {
    \\n  { buffer.append('\n'); }
    \\r  { buffer.append('\r'); }
    \\t  { buffer.append('\t'); }
    \\f  { buffer.append('\f'); }
    \\\\ { buffer.append('\\'); }
    \\'  { buffer.append('\''); }
    '    { yybegin(YYINITIAL); return token(TokenType.STRING_LIT, buffer.toString()); }
    .    { buffer.append(yytext()); }
}

<STRING_BT> {
    \\n  { buffer.append('\n'); }
    \\r  { buffer.append('\r'); }
    \\t  { buffer.append('\t'); }
    \\f  { buffer.append('\f'); }
    \\\\ { buffer.append('\\'); }
    \\`  { buffer.append('`'); }
    `    { yybegin(YYINITIAL); return token(TokenType.STRING_LIT, buffer.toString()); }
    .    { buffer.append(yytext()); }
}

<YYINITIAL> {
    "("                    { return token(TokenType.O_PARENTHESES); }
    ")"                    { return token(TokenType.C_PARENTHESES); }
    "{"                    { return token(TokenType.O_C_BRACKET); }
    "}"                    { return token(TokenType.C_C_BRACKET); }
    "["                    { return token(TokenType.O_BRACKET); }
    "]"                    { return token(TokenType.C_BRACKET); }
    "."                    { return token(TokenType.DOT); }
    ","                    { return token(TokenType.COMMA); }

    "true"                 { return token(TokenType.TRUE_VALUE); }
    "false"                { return token(TokenType.FALSE_VALUE); }
    "null"                 { return token(TokenType.NULL_VALUE); }

    "int8"                 { return token(TokenType.INT8); }
    "int16"                { return token(TokenType.INT16); }
    "int32"                { return token(TokenType.INT32); }
    "int64"                { return token(TokenType.INT64); }
    "uint8"                { return token(TokenType.UINT8); }
    "uint16"               { return token(TokenType.UINT16); }
    "uint32"               { return token(TokenType.UINT32); }
    "uint64"               { return token(TokenType.UINT64); }
    "char"                 { return token(TokenType.CHAR); }
    "bool"                 { return token(TokenType.BOOL); }
    "float32"              { return token(TokenType.FLOAT32); }
    "float64"              { return token(TokenType.FLOAT64); }
    "function"             { return token(TokenType.FUNCTION); }
    "void"                 { return token(TokenType.VOID); }
    "string"               { return token(TokenType.STRING); }

    "include"              { return token(TokenType.INCLUDE); }
    "private"              { return token(TokenType.PRIVATE); }
    "protected"            { return token(TokenType.PROTECTED); }
    "class"                { return token(TokenType.CLASS); }
    "enum"                 { return token(TokenType.ENUM); }
    "interface"            { return token(TokenType.INTERFACE); }
    "new"                  { return token(TokenType.NEW); }
    "extends"              { return token(TokenType.EXTENDS); }
    "implements"           { return token(TokenType.IMPLEMENTS); }
    "abstract"             { return token(TokenType.ABSTRACT); }
    "final"                { return token(TokenType.FINAL); }
    "assert"               { return token(TokenType.ASSERT); }
    "this"                 { return token(TokenType.THIS); }
    "return"               { return token(TokenType.RETURN); }
    "if"                   { return token(TokenType.IF); }
    "else"                 { return token(TokenType.ELSE); }
    "for"                  { return token(TokenType.FOR); }
    "in"                   { return token(TokenType.IN); }
    "range"                { return token(TokenType.RANGE); }
    "while"                { return token(TokenType.WHILE); }
    "continue"             { return token(TokenType.CONTINUE); }
    "break"                { return token(TokenType.BREAK); }
    "is"                   { return token(TokenType.IS); }
    "async"                { return token(TokenType.ASYNC); }
    "future"               { return token(TokenType.FUTURE); }
    "unsafe"               { return token(TokenType.UNSAFE); }
    "defer"                { return token(TokenType.DEFER); }
    "external"             { return token(TokenType.EXTERNAL); }

    "="                    { return token(TokenType.EQ_OPER); }
    "+"                    { return token(TokenType.ADD_OPER); }
    "-"                    { return token(TokenType.SUB_OPER); }
    "*"                    { return token(TokenType.MUL_OPER); }
    "/"                    { return token(TokenType.DIV_OPER); }
    "%"                    { return token(TokenType.MOD_OPER); }
    "+="                   { return token(TokenType.ADD_EQ_OPER); }
    "-="                   { return token(TokenType.SUB_EQ_OPER); }
    "*="                   { return token(TokenType.MUL_EQ_OPER); }
    "/="                   { return token(TokenType.DIV_EQ_OPER); }
    "%="                   { return token(TokenType.MOD_EQ_OPER); }
    "++"                   { return token(TokenType.INCR_OPER); }
    "--"                   { return token(TokenType.DECR_OPER); }
    "**"                   { return token(TokenType.POW_OPER); }
    ">"                    { return token(TokenType.GT_OPER); }
    "<"                    { return token(TokenType.LT_OPER); }
    ">="                   { return token(TokenType.GT_EQ_OPER); }
    "<="                   { return token(TokenType.LT_EQ_OPER); }
    "&"                    { return token(TokenType.BIT_AND_OPER); }
    "|"                    { return token(TokenType.BIT_OR_OPER); }
    "~"                    { return token(TokenType.BIT_NOT_OPER); }
    "^"                    { return token(TokenType.BIT_XOR_OPER); }
    "<<"                   { return token(TokenType.BIT_SHL_OPER); }
    ">>"                   { return token(TokenType.BIT_SHR_OPER); }
    "and"                  { return token(TokenType.AND_OPER); }
    "or"                   { return token(TokenType.OR_OPER); }
    "not"                  { return token(TokenType.NOT_OPER); }
    "?"                    { return token(TokenType.TERNARY_OPER); }

    "-"?[1-9][0-9]*        { return token(TokenType.DECIMAL, Long.parseLong(yytext())); }
    "0x"[0-9a-fA-F]+       { return token(TokenType.DECIMAL, Long.parseLong(yytext().substring(2), 16)); }
    "-"?[0-9]+"."[0-9]*    { return token(TokenType.FLOATING_POINT, Double.parseDouble(yytext())); }
    [a-zA-Z_][a-zA-Z0-9_]* { return token(TokenType.IDENTIFIER, yytext()); }
    [ \t\r]+                { index += yytext().length(); }
    [\n]                   { line++; index = 0; }

    .                      { throw new LexException("Unexpected token", line, yytext()); }
    <<EOF>>                { return null; }
}