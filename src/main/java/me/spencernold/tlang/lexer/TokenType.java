package me.spencernold.tlang.lexer;

public class TokenType {
    public static int ERROR = 0x000;
    public static int WHITESPACE = 0x100;
    public static int NOP = 0x100;
    public static int STRING_LIT = 0x101;
    public static int FLOATING_POINT = 0x102;
    public static int DECIMAL = 0x103;
    public static int IDENTIFIER = 0x104;


    public static int O_PARENTHESES = 0x105;
    public static int C_PARENTHESES = 0x106;
    public static int O_C_BRACKET = 0x107;
    public static int C_C_BRACKET = 0x108;
    public static int O_BRACKET = 0x109;
    public static int C_BRACKET = 0x10A;
    public static int DOT = 0x10B;
    public static int COMMA = 0x10C;


    public static int TRUE_VALUE = 0x110;
    public static int FALSE_VALUE = 0x111;
    public static int NULL_VALUE = 0x112;


    public static int TYPE_MASK = 0x11FF;
    public static int INT8 = 0x1100;
    public static int INT16 = 0x1101;
    public static int INT32 = 0x1102;
    public static int INT64 = 0x1103;
    public static int UINT8 = 0x1104;
    public static int UINT16 = 0x1105;
    public static int UINT32 = 0x1106;
    public static int UINT64 = 0x1107;
    public static int CHAR = 0x1108;
    public static int BOOL = 0x1109;
    public static int FLOAT32 = 0x110A;
    public static int FLOAT64 = 0x110B;
    public static int FUNCTION = 0x110C;
    public static int VOID = 0x110D;
    public static int STRING = 0x110E;


    public static int OPER_MASK = 0x21FF;
    public static int EQ_OPER = 0x2100;
    public static int ADD_OPER = 0x2101;
    public static int SUB_OPER = 0x2102;
    public static int MUL_OPER = 0x2103;
    public static int DIV_OPER = 0x2104;
    public static int MOD_OPER = 0x2105;
    public static int INCR_OPER = 0x2106;
    public static int DECR_OPER = 0x2107;
    public static int ADD_EQ_OPER = 0x2108;
    public static int SUB_EQ_OPER = 0x2109;
    public static int MUL_EQ_OPER = 0x210A;
    public static int DIV_EQ_OPER = 0x210B;
    public static int MOD_EQ_OPER = 0x210C;
    public static int POW_OPER = 0x210D;
    public static int GT_OPER = 0x210E;
    public static int LT_OPER = 0x210F;
    public static int GT_EQ_OPER = 0x2110;
    public static int LT_EQ_OPER = 0x2111;
    public static int BIT_AND_OPER = 0x2112;
    public static int BIT_OR_OPER = 0x2113;
    public static int BIT_XOR_OPER = 0x2114;
    public static int BIT_NOT_OPER = 0x2115;
    public static int BIT_SHL_OPER = 0x2116;
    public static int BIT_SHR_OPER = 0x2117;
    public static int AND_OPER = 0x2118;
    public static int OR_OPER = 0x2119;
    public static int NOT_OPER = 0x211A;
    public static int TERNARY_OPER = 0x211B;


    public static int KEYWORD_MASK = 0x31FF;
    public static int INCLUDE = 0x3100;
    public static int PRIVATE = 0x3101;
    public static int PROTECTED = 0x3102;
    public static int CLASS = 0x3103;
    public static int ENUM = 0x3104;
    public static int INTERFACE = 0x3105;
    public static int NEW = 0x3106;
    public static int EXTENDS = 0x3107;
    public static int IMPLEMENTS = 0x3108;
    public static int ABSTRACT = 0x3109;
    public static int FINAL = 0x310A;
    public static int ASSERT = 0x310B;
    public static int THIS = 0x310C;
    public static int RETURN = 0x310D;
    public static int IF = 0x310E;
    public static int ELSE = 0x310F;
    public static int FOR = 0x3110;
    public static int IN = 0x3111;
    public static int RANGE = 0x3112;
    public static int WHILE = 0x3113;
    public static int CONTINUE = 0x3114;
    public static int BREAK = 0x3115;
    public static int IS = 0x3116;
    public static int ASYNC = 0x3117;
    public static int FUTURE = 0x3118;
    public static int UNSAFE = 0x3119;
    public static int DEFER = 0x311A;
    public static int EXTERNAL = 0x311B;

    public static boolean isType(int mask, int type) {
        return (mask | type) == mask;
    }
}
