package me.spencernold.tlang;

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



%}

%%

[ \t\r\n]+          { /* skip */ }
"-"?[1-9][0-9]*     { return new Token<Long>(Type.DECIMAL, Long.parseLong(yytext())); }
"0x"[0-9a-fA-F]+    { return new Token<Long>(Type.DECIMAL, Long.parseLong(yytext().substring(2), 16)); }
"-"?[0-9]+"."[0-9]* { return new Token<Double>(Type.FLOATING_POINT, Double.parseDouble(yytext())); }
.                   { return new Token<>(Type.ERROR); }
<<EOF>>             { return null; }