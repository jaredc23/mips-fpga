//-----------------------------------------------------------------------------
/*!     \file      zassemble.c
 *
 *      \brief      Program for translating assembly into machine code
 *      \details    This program is for use with a custom assembly language
 *                  based on MIPS. This program's purpose is to take a .s/.asm 
 *                  file with assembly code and translate into machine code capable of
 *                  being run on an FPGA MIPS processor.
 */

/*------------------------------------------------------------------------------
 *   #$-Include Files-$#
 *-----------------------------------------------------------------------------*/
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <unistd.h>

/*------------------------------------------------------------------------------
 *   #$-Defines-$#
 *-----------------------------------------------------------------------------*/

//Opcode defines
#define LW      0x0 //I
#define SW      0x1 //I
#define ADD     0x2 //R
#define ADDI    0x3 //I
#define INV     0x4 //R
#define AND     0X5 //R
#define ANDI    0x6 //I
#define OR      0x7 //R
#define ORI     0x8 //I
#define SRA     0x9 //I
#define SLL     0xA //I
#define BEQ     0xB //J
#define BNE     0xC //J
#define CLR     0xD //R

//ANSI color defines
#define ANSI_COLOR_RED     "\x1b[31m"
#define ANSI_COLOR_RESET   "\x1b[0m"

//Global variables for error handling
static char* fullLine;
static int lineNumber = 1;
static int instructionNumber = 1;

//This will go away
static int error_count = 0;

/*------------------------------------------------------------------------------
 *   #$-Typedefs-$#
 *-----------------------------------------------------------------------------*/

typedef unsigned short ushort;
typedef unsigned char uchar;

//-----------------------------------------------------------------------------
/*!     \brief      Generic machine code instruction bitfield
 */
typedef struct INSTR_
{
    ushort          : 12;
    ushort opcode   :  4;
} INSTR;

//-----------------------------------------------------------------------------
/*!     \brief      R-Type machine code instruction bitfield
 *      \note       "pad" field included in order to fill with zeros during
 *                  file write, so it does not contain junk values
 */
typedef struct R_INSTR_
{
    ushort pad      : 6;
    ushort rd       : 2;
    ushort rt       : 2;
    ushort rs       : 2;
    ushort opcode   : 4;
} R_INSTR;

//-----------------------------------------------------------------------------
/*!     \brief      IJ-Type machine code instruction bitfield
 */
typedef struct IJ_INSTR_
{
    ushort immed    : 8;
    ushort rd       : 2;
    ushort rs       : 2;
    ushort opcode   : 4;
} IJ_INSTR;

//-----------------------------------------------------------------------------
/*!     \brief      Error enumeration
 */
typedef enum ERROR_
{
    NO_INPUT,
    INV_INPUT,
    INV_OUTPUT,
    INV_OPCODE,
    INV_LABEL,
    PARSE_ERR,
    PC_ERR
} ERROR;

//-----------------------------------------------------------------------------
/*!     \brief      Node for instruction linked list
 *      \details    Instructions are arranged in a linked list structure.
 *                  Each instruction node contains a bitfield of the machine
 *                  code instruction, a label reference appearing in a branch
 *                  or jump instruction, and a pointer to the next instruction
 *                  node.
 *      \param      label_reference     A label referenced in a branch or jump
 *                                      instruction
 *      \param      instr_LL_head       Global static pointer to head of instruction LL
 */
typedef struct INSTR_NODE_
{
    INSTR instr;
    char* label_reference;
    struct INSTR_NODE_ *next;
} INSTR_NODE;

static INSTR_NODE* instr_LL_head = NULL;


//-----------------------------------------------------------------------------
/*!     \brief      Node for label linked list
 *      \details    Labels are arranged in a linked list structure. Each label
 *                  node contains the label string, the line on which it was
 *                  found, and a pointer to the next label node.
 *      \param      label_LL_head       Global static pointer to head of label LL
 */
typedef struct LABEL_NODE_
{
    char *label;
    int line;
    struct LABEL_NODE_ *next;
} LABEL_NODE;

static LABEL_NODE* label_LL_head = NULL;

//-----------------------------------------------------------------------------
/*!     \brief      Node for error linked list
 *      \details    Errors are arranged in a linked list structure. Each error
 *                  node contains the error code, the line on which it was
 *                  found, the full line string, and a pointer to the next error node.
 *      \param      error_LL_head       Global static pointer to head of label LL
 */
typedef struct ERROR_NODE_
{
    ERROR error;
    int line_number;
    char* full_line;
    char* label_reference;
    struct ERROR_NODE_ *next;
} ERROR_NODE;

static ERROR_NODE* error_LL_head = NULL;


/*------------------------------------------------------------------------------
 *   #$-Instruction Functions-$#
 *-----------------------------------------------------------------------------*/
//-----------------------------------------------------------------------------
/*!     \brief      Function to write an instruction to a file in hex format
 *      \details    Takes an instruction and writes it to file fd in hex. Also
 *                  Adds a necessary initialization string before the first
 *                  instruction is written.
 *      \param      firstInstruction    Tracker needed to prepend instruction
 *                                      list with necessary initialization string
 */
static bool firstInstruction = true;
void writeInstr(INSTR instr, FILE* fd)
{
    if (firstInstruction) {
        fprintf(fd, "memory_initialization_radix=16;\nmemory_initialization_vector=%04hx", instr);
        firstInstruction = false;
    } else {
        fprintf(fd, ",%04hx", instr);
    }
}


//-----------------------------------------------------------------------------
/*!     \brief      Function to add a machine code instruction to LL
 *      \details    Takes a generic type machine code instruction and appends
 *                  it to a linked list of instructions
 */
INSTR_NODE* addInstruction(INSTR *new, INSTR_NODE **current)
{
    //Create new instruction node
    INSTR_NODE *newItem = (INSTR_NODE*)malloc(sizeof(INSTR_NODE));
    newItem->next = NULL;
    
    //Populate with instruction
    newItem->instr = *new;
    
    //If this is the first instruction
    if (instr_LL_head == NULL)
    {
        instr_LL_head = newItem;
        *current = instr_LL_head;
    }
    //If this is not the first instruction
    else if (*current != NULL)
    {
        (*current)->next = newItem;
        *current = newItem;
    }
    
    return *current;
}

//-----------------------------------------------------------------------------
/*!     \brief      Wrapper for adding R-type instruction to LL
 *      \details    Takes an instruction in terms of R-type specific parameters,
 *                  populates them into an R-type machine code instruction bitfield,
 *                  then casts as a generic machine code instruction and calls
 *                  addInstruction()
 */
INSTR_NODE* addRInstr(ushort opcode, ushort rs, ushort rt, ushort rd, INSTR_NODE **current)
{
    R_INSTR *instr = (R_INSTR*)malloc(sizeof(R_INSTR));
    instr->opcode = opcode;
    instr->rs = rs;
    instr->rt = rt;
    instr->rd = rd;
    instr->pad = 0;
    
    return addInstruction((INSTR*)instr, current);
}

//-----------------------------------------------------------------------------
/*!     \brief      Wrapper for adding IJ-type instruction to LL
 *      \details    Takes an instruction in terms of IJ-type specific parameters,
 *                  populates them into an IJ-type machine code instruction bitfield,
 *                  and casts as a generic machine code instruction and calls
 *                  addInstruction(). Also adds a label_reference to the created
 *                  list item (for branch/jump commands)
 */
INSTR_NODE* addIJInstr(ushort opcode, ushort rs, ushort rd, ushort immed, char* label_reference, INSTR_NODE **current)
{
    IJ_INSTR *instr = (IJ_INSTR*)malloc(sizeof(IJ_INSTR));
    instr->opcode = opcode;
    instr->rs = rs;
    instr->rd = rd;
    instr->immed = immed;
    
    if ( (*current = addInstruction((INSTR*)instr, current)) )
    {
        (*current)->label_reference = (char*)malloc(255);
        strcpy((*current)->label_reference, label_reference);
    }
    
    return *current;
}


/*------------------------------------------------------------------------------
 *   #$-Error Functions-$#
 *-----------------------------------------------------------------------------*/

//-----------------------------------------------------------------------------
/*!     \brief      Return -1 for empty/NULL string
 */
int lineIsEmpty(char* parse_buf)
{
    if ( parse_buf == NULL              ||
        (strcmp(parse_buf, "\n") == 0) ||
        (strcmp(parse_buf, "\r") == 0) ||
        (strcmp(parse_buf, "")   == 0)   )
    {
        return -1;
    }
    
    return 0;
}

//-----------------------------------------------------------------------------
/*!     \brief      Function to add an error to a LL
 */
int addError(ERROR error)
{
    //Create new error node
    ERROR_NODE *newItem = (ERROR_NODE*)malloc(sizeof(ERROR_NODE));
    newItem->next = NULL;
    
    //Populate with error
    newItem->error = error;
    
    //Populate with lineNumber
    newItem->line_number = lineNumber;
    
    if ( !lineIsEmpty(fullLine) )
    {
        //Allocate memory for line
        newItem->full_line = (char*) malloc(strlen(fullLine)*sizeof(char));
        
        //Populate with full line
        strcpy( (newItem->full_line), fullLine);
    }
    
    //If this is the first instruction
    if (error_LL_head == NULL)
    {
        error_LL_head = newItem;
    }
    //If this is not the first instruction
    else
    {
        //Tracker to traverse LL
        ERROR_NODE* current = error_LL_head;
        
        //While we aren't at the last node
        while (current->next != NULL)
        {
            //Advance to next node
            current = current->next;
        }
        
        //Append new error
        current->next = newItem;
    }
    
    return 0;
}

//-----------------------------------------------------------------------------
/*!     \brief      Function to handle errors
 */
int handleErrors(void)
{
    ERROR_NODE* current_error = error_LL_head;
    
    //If no errors, return 1
    if (current_error == NULL)
    {
        return 1;
    }
    
    //Traverse until we're at the last error
    while (current_error != NULL)
    {
        fprintf(stderr, ANSI_COLOR_RED "error" ANSI_COLOR_RESET);
        
        switch (current_error->error)
        {
            case NO_INPUT:
                fprintf(stderr, ": No input file specified. Call program using syntax\n\n\t./zassemble input_assembly.s [output_machine_code.coe]\n\n");
                break;
            case INV_INPUT:
                fprintf(stderr, ": Input file specified could not be opened, or is invalid.\n\n");
                break;
            case INV_OUTPUT:
                fprintf(stderr, ": Output file specified could not be opened, or is invalid.\n\n");
                break;
            case INV_OPCODE:
                fprintf(stderr, ": line %d: ", current_error->line_number);
                fprintf(stderr, "The instruction contains an unrecognized opcode: \n%s", current_error->full_line);
                fprintf(stderr, "\n\n");
                break;
            case INV_LABEL:
                //fprintf(stderr, ": line %d: ", current_error->line_number);
                fprintf(stderr, ": Invalid label. Check to ensure all labels referenced in branch/jump instructions are valid.");
                fprintf(stderr, "\n\n");
                break;
            case PARSE_ERR:
                fprintf(stderr, ": line %d: ", current_error->line_number);
                fprintf(stderr, "The instruction contains invalid syntax: \n%s", current_error->full_line);
                fprintf(stderr, "\n\n");
                break;
            case PC_ERR:
                fprintf(stderr, ": Too many instructions. You may only have up to 256 instructions in your program.");
        }
        
        //Advance one error
        current_error = current_error->next;
    }
    
    //A zero return indicates there were errors and they were handled
    return 0;
}

/*------------------------------------------------------------------------------
 *   #$-Label Functions-$#
 *-----------------------------------------------------------------------------*/
//-----------------------------------------------------------------------------
/*!     \brief      Function to add a node to a label linked list
 *      \details    Prepends a new node storing a label string and a line number
 *                  to the linked list pointed to by head
 *      \param      label_LL_head    Pointer to the head of (file global) label LL.
 */
void addLabel(char* label, int line)
{
    //Create new node
    LABEL_NODE *newNode;
    newNode = (LABEL_NODE*) malloc(sizeof(LABEL_NODE));
    
    //Save label and line number in new node
    newNode->label = (char*) malloc(strlen(label)*sizeof(char));
    strcpy(newNode->label, label);
    newNode->line = line;
    
    //Prepend new node onto existing linked list
    newNode->next = label_LL_head;
    label_LL_head = newNode;
}

//-----------------------------------------------------------------------------
/*!     \brief      Function to get relative position to a label
 *      \details    Takes in a label referenced in a branch or jump instruction
 *                  and the line of that instruction and returns the relative
 *                  number of line numbers away the specified label is.
 *      \note       A negative return value indicates jump up
 */
uchar getLabelJump(char* label, int current_line)
{
    //Traverse label LL
    LABEL_NODE *current = label_LL_head;
    while (current != NULL)
    {
        //If label is found, return relative jump
        if (strcmp(label, current->label) == 0)
        {
            return (uchar)((current->line) - (current_line));
        }
        current = current->next;
    }
    //If label is not found, generate an error
    addError(INV_LABEL);
    
    return -1;
}

/*------------------------------------------------------------------------------
 *   #$-Parsing Functions-$#
 *-----------------------------------------------------------------------------*/

//-----------------------------------------------------------------------------
/*!     \brief      Replaces any tabs in parse_buf with spaces
 *      \details    Takes in parse_buf, searches for tab characters, and
 *                  replaces those found with spaces.
 */
int replaceTabsWithSpaces(char* parse_buf)
{
    char* tab_location;
    
    //Get pointer to first occurence of '\t' in parse_buf
    tab_location = strchr(parse_buf, '\t');
    
    //If pointer isn't NULL, we found one
    while (tab_location != NULL)
    {
        //Edit parse_buf to replace tab with space
        parse_buf[tab_location-parse_buf] = ' ';
        
        //This syntax advnaces strchr() to find next tab
        tab_location = strchr(tab_location + 1, '\t');
    }
    
    return lineIsEmpty(parse_buf);
}

//-----------------------------------------------------------------------------
/*!     \brief      Removes any comments from parse_buf
 *      \details    Takes in parse_buf, tokenizes based on comment flag "#",
 *                  and removes everything after the first "#".
 */
int removeComments(char* parse_buf)
{
    char* token;
    char* comment_location;
    
    //See where comment is
    comment_location = strchr(parse_buf, '#');
    
    //If pointer isn't NULL, we found one
    if (comment_location != NULL)
    {
        //Edit parse_buf to replace tab with space
        parse_buf[comment_location-parse_buf] = '\0';
        
    }
    
    //If the line without a comment is empty, return a 1 code
    return lineIsEmpty(parse_buf);
}

//-----------------------------------------------------------------------------
/*!     \brief      Categorizes and removes labels from parse_buf
 *      \details    Takes in parse_buf, tokenizes based on ":",
 *                  then stores everything after ":" in parse_buf.
 */
int parseForLabels(char* parse_buf)
{
    char tokenizer[255], label[255];
    char* token;
    
    //Check for empty line
    if ( lineIsEmpty(parse_buf) )
    {
        return -1;
    }
    
    //Initialize tokenizer
    strcpy(tokenizer, parse_buf);
    
    //Tokenize, split on ":" (for labels)
    token = strtok(tokenizer, ":");
    
    // If we found a ":"
    if (strcmp(token, parse_buf) != 0)
    {
        //Check for empty string
        if ( lineIsEmpty(token) )
        {
            return -1;
        }
        
        //Add label
        addLabel(token, instructionNumber);
        
        // Store everything after label in parse_buf
        token = strtok(NULL, "\n");
        
        //Check for empty line
        if ( lineIsEmpty(token) )
        {
            return -1;
        }
        
        //Copy line w/ label removed back to parse_buf
        strcpy(parse_buf, token);
        
    }
    
    //Return 0 since parse_buf isn't empty
    return 0;
}

//-----------------------------------------------------------------------------
/*!     \brief      Translates opcode from string to hex
 *      \details    Takes an opcode as a string and translates to hex. Returns
 *                  an error if the opcode was not recognized
 */
ushort translateOpcode(char *opcode)
{
    if (0 == strcmp(opcode, "lw"))
        return LW;
    else if (0 == strcmp(opcode, "sw"))
        return SW;
    else if (0 == strcmp(opcode, "add"))
	        return ADD;
	else if (0 == strcmp(opcode, "addi"))
        return ADDI;
    else if (0 == strcmp(opcode, "inv"))
        return INV;
    else if (0 == strcmp(opcode, "and"))
        return AND;
    else if (0 == strcmp(opcode, "andi"))
        return ANDI;
    else if (0 == strcmp(opcode, "or"))
        return OR;
    else if (0 == strcmp(opcode, "ori"))
        return ORI;
    else if (0 == strcmp(opcode, "sra"))
        return SRA;
    else if (0 == strcmp(opcode, "sll"))
        return SLL;
    else if (0 == strcmp(opcode, "beq"))
        return BEQ;
    else if (0 == strcmp(opcode, "bne"))
        return BNE;
    else if (0 == strcmp(opcode, "clr"))
        return CLR;
    else
    {
        addError(INV_OPCODE);

        return 0xF;
    }
}


//-----------------------------------------------------------------------------
/*!     \brief      Gets opcode from parse_buf and translates to numerical opcode
 *                  Basically a wrapper for translateOpcode( )
 */
int getOpcode(char* parse_buf, INSTR* instr_ptr)
{
    char tokenizer[255];
    char* token;
    
    //Initialize tokenizer
    strcpy(tokenizer, parse_buf);

    //Parse for opcode
    token = strtok(tokenizer, " ");
    
    //Check for empty string
    if ( lineIsEmpty(token) )
    {
        return -1;
    }
    
    instr_ptr->opcode = translateOpcode(token);
    
    //Pull everything after opcode into parse_buf
    token = strtok(NULL, "\n");
    
    //Check for empty string
    if ( lineIsEmpty(token) )
    {
        return -1;
    }
    
    strcpy(parse_buf, token);
    
    //Return numerical opcode
    return 0;

}


//-----------------------------------------------------------------------------
/*!     \brief      Parses string, returns immediate value
 *      \details    Takes a string assumed to contain an immediate value;
 *                  if the string contains "0x", the value is interpretted as
 *                  hex, otherwise, it is interpretted as decimal.
 */
int getImmed(char* immediate_string)
{
    char* zero_indicator;
    char* x_indicator;
    //char* token;
    int immedNum;
    
    //Look for zero in token
    zero_indicator = strchr(immediate_string, '0');
    
    //Look for x in token
    x_indicator = strchr(immediate_string, 'x');
    
    //Case where "0x" is present
    if (x_indicator == (zero_indicator + 1))
    {
        immediate_string = x_indicator + 1;
        sscanf(immediate_string, "%x", &immedNum);
    }
    
    //Case where "0x" is not present
    else if (x_indicator == NULL)
    {
        sscanf(immediate_string, "%d", &immedNum);
    }
    
    //Case indicates error
    else
    {
        //Need some kind of error handle here
        return 0;
    }
    
    return immedNum;
}
//-----------------------------------------------------------------------------
/*!     \brief      Function to populate an instr bitfield based on a string
 *      \details    Based on the internal value of strtok, function parses
 *                  the assembly instruction for registers, immediates, and
 *                  labels. The first register is found the same for all
 *                  instruction types; after that, different subsets of
 *                  instructions are treated differently.
 */
int populateInstr(INSTR *instr, char* parse_buf, char* label_reference)
{
    int rFirst = -1, rSecond = -1, rThird = -1;
    int result = 0;
    int immedNum;
    int scanError = 0;
    
    char immedStr[255];
    strcpy(immedStr, "");
    
    //Grab first space-delimited argument
    char *token = strtok(parse_buf, " ");
    
    //Check for empty string
    if ( lineIsEmpty(token) )
    {
        return -1;
    }
    
    //Parse first register
    sscanf(token, "$%i,", &rFirst);
    
    // First we treat normal R-type
    // Format:
    // opcode $rd, $rs, $rt
    if (instr->opcode == ADD ||
        instr->opcode == AND ||
        instr->opcode == OR    )
    {
        //Grab second register
        token = strtok(NULL, " ");
        
        //Check for empty string
        if ( lineIsEmpty(token) )
        {
            return -1;
        }
        
        //Parse second register
        sscanf(token, "$%i,", &rSecond);
        
        // Grab third register
        token = strtok(NULL, " ");
        
        //Check for empty string
        if ( lineIsEmpty(token) )
        {
            return -1;
        }
        //Parse third register
        sscanf(token, "$%i", &rThird);
        
        R_INSTR *r_instr = (R_INSTR*)instr;
        
        //Populate instructions according to format
        // opcode   $rd, $rs, $rt
        r_instr->rs = rSecond;
        r_instr->rt = rThird;
        r_instr->rd = rFirst;
        
        //Check for unread registers
        if (rFirst    == -1 ||
            rSecond   == -1 ||
            rThird    == -1 ||
            scanError == -1   )
        {
            addError(PARSE_ERR);
        }
    }
    
    //Next treat weird INV
    // Format:
    // opcode $rd, $rt
    else if (instr->opcode == INV)
    {
        //Grab second register
        token = strtok(NULL, " ");
        
        //Check for empty string
        if ( lineIsEmpty(token) )
        {
            return -1;
        }
        
        //Parse second register
        sscanf(token, "$%i", &rSecond);
        
        R_INSTR *r_instr = (R_INSTR*)instr;
        
        //Populate instructions according to format
        // opcode   $rd, $rs, $rt
        r_instr->rs = 0;
        r_instr->rt = rSecond;
        r_instr->rd = rFirst;
        
        //Check for unread registers
        if (rFirst    == -1 ||
            rSecond   == -1 ||
            scanError == -1   )
        {
            addError(PARSE_ERR);
        }
    }
    
    //Next treat weird R-type (inv/clr)
    // Format:
    // opcode $rt
    else if (instr->opcode == CLR)
    {
        R_INSTR *r_instr = (R_INSTR*)instr;
        
        //Populate instructions according to format
        // opcode   $rt
        // (duplicate $rt into $rd)
        r_instr->rs = 0;
        r_instr->rt = rFirst;
        r_instr->rd = rFirst;
        
        //Check for unread registers
        if (rFirst    == -1 ||
            scanError == -1   )
        {
            addError(PARSE_ERR);
            
        }
    }
    
    // Next treat weird IJ-type (load/store)
    // Format:
    // opcode $rt, offs($rs)
    //TODO: Ensure these instructios work
    else if(instr->opcode == LW ||
            instr->opcode == SW )
    {
        //Grab immediate
        token = strtok(NULL, "(");
        
        //Check for empty string
        if ( lineIsEmpty(token) )
        {
            return -1;
        }
        
        immedNum = getImmed(token);
        
        //Parse immediate
        //sscanf(token, "%x", &immedNum);
        
        //Grab second register
        token = strtok(NULL, ")");
        
        //Check for empty string
        if ( lineIsEmpty(token) )
        {
            return -1;
        }
        
        //Parse second register
        sscanf(token, "$%i", &rSecond);
        
        //Populate instructions according to format
        // opcode   $rt, offst($rs)
        IJ_INSTR *ij_instr = (IJ_INSTR*)instr;
        ij_instr->rs = rSecond;
        ij_instr->rd = rFirst;
        ij_instr->immed = immedNum;
        
        //Check for unread registers
        if (rFirst    == -1 ||
            rSecond   == -1 ||
            scanError == -1   )
        {
            addError(PARSE_ERR);
            
        }
    }
    
    // Now treat IJ instructions with a LABEL
    // Format:
    // opcode $rd, $rs, LABEL
    else if (instr->opcode == BEQ ||
             instr->opcode == BNE   )
    {
        //Grab second register
        token = strtok(NULL, " ");
        
        //Check for empty string
        if ( lineIsEmpty(token) )
        {
            return -1;
        }
        
        //Parse second register
        sscanf(token, "$%i,", &rSecond);
        
        //Grab label
        token = strtok(NULL, " \n");
        
        //Check for empty string
        if ( lineIsEmpty(token) )
        {
            return -1;
        }
        
        //Parse label
        sscanf(token, "%s", immedStr);
        
        //Populate instructions according to format
        // opcode $rs, $rt, label
        IJ_INSTR *ij_instr = (IJ_INSTR*)instr;
        ij_instr->rs = rFirst;
        ij_instr->rd = rSecond;
        ij_instr->immed = (uchar)(-1); //immed is only 8 bits
        strcpy(label_reference, immedStr);
        
        //Check for unread registers
        if (rFirst               == -1 ||
            rSecond              == -1 ||
            strcmp(immedStr, "") == 0  ||
            scanError            == -1   )
        {
            addError(PARSE_ERR);
            
        }
        
    }
    
    // Now treat all other IJ type instructions
    // Format:
    // opcode $rd, $rs, IMM
    else if (instr->opcode == ADDI ||
             instr->opcode == ANDI ||
             instr->opcode == ORI  ||
             instr->opcode == SRA  ||
             instr->opcode == SLL    )
    {
        //Grab second register
        token = strtok(NULL, " ");
        
        //Check for empty string
        if ( lineIsEmpty(token) )
        {
            return -1;
        }
        
        //Parse second register
        sscanf(token, "$%i,", &rSecond);
        
        //Grab immediate
        token = strtok(NULL, " \n");
        
        //Check for empty string
        if ( lineIsEmpty(token) )
        {
            return -1;
        }
        
        immedNum = getImmed(token);
        
        //Parse immediate
        //sscanf(token, "%x", &immedNum);
        
        // Populate instructions according to format
        // opcode $rd, $rs, IMM
        IJ_INSTR *ij_instr = (IJ_INSTR*)instr;
        ij_instr->rs = rSecond;
        ij_instr->rd = rFirst;
        ij_instr->immed = immedNum;
        
        //Check for unread registers
        if (rFirst    == -1 ||
            rSecond   == -1 ||
            scanError == -1  )
        {
            addError(PARSE_ERR);
            
        }
    }
    
    return 0;
}

//-----------------------------------------------------------------------------
/*!     \brief      Completes parse of one line
 */
int parseOneLine(char* parse_buf, INSTR* instr_ptr, INSTR_NODE** ptr_to_current)
{
    char label_reference[255];
    
    //Skip parsing if parse_buf is newline, empty, or NULL,
    //or if we're at the end of the file
    if ( !lineIsEmpty(parse_buf) )
    {
        
        //Replace all tabs with spaces
        if ( replaceTabsWithSpaces(parse_buf) )
        {
            //Non-zero return indicates empty line
            return -1;
        }
        
        //Remove all comments
        if ( removeComments(parse_buf) )
        {
            //Non-zero return indicates empty line
            return -1;
        }
        //Parse for labels
        if( parseForLabels(parse_buf) )
        {
            //Non-zero return indicates empty line
            return -1;
        }
        
        //
        if ( getOpcode(parse_buf, instr_ptr) ) //TODO: Treat invalid opcodes
        {
            //Non-zero return indicates empty line
            return -1;
        }
        
        // Populate instruction
        if( populateInstr(instr_ptr, parse_buf, label_reference) )
        {
            //Non-zero return indicates inability to parse line
            return -1;
        }
        
        // Add instruction to instruction LL
        switch (instr_ptr->opcode)
        {
            case ADD:
            case AND:
            case OR:
            case INV:
            case CLR:
                *ptr_to_current = addRInstr(instr_ptr->opcode,
                                    ((R_INSTR*)instr_ptr)->rs,
                                    ((R_INSTR*)instr_ptr)->rt,
                                    ((R_INSTR*)instr_ptr)->rd,
                                    ptr_to_current);
                return 0;
                
            case LW:
            case SW:
            case ADDI:
            case ANDI:
            case ORI:
            case SRA:
            case SLL:
            case BEQ:
            case BNE:
                *ptr_to_current = addIJInstr(instr_ptr->opcode,
                                     ((IJ_INSTR*)instr_ptr)->rs,
                                     ((IJ_INSTR*)instr_ptr)->rd,
                                     ((IJ_INSTR*)instr_ptr)->immed,
                                     label_reference,
                                     ptr_to_current);
                return 0;
            default:
                return -1;
        }
    }
    
    return -1;
}


/*------------------------------------------------------------------------------
 *                                  #$-Main-$#
 *-----------------------------------------------------------------------------*/
int main (int argc, char *argv[])
{
    char *inFile, *outFile;

    // Argument handling according to expected format:
    // ./zassamble assembly.s [machine_code.coe]

    //No input file specified
    if (argc < 2)
    {
        addError(NO_INPUT);
        handleErrors();

        return 0;
    }
    
    // Assign input file
    inFile = argv[1];

    // Output file specified
    if (argc == 3)
    {
        // Assign output file
        outFile = argv[2];
    }
    // No output file specified
    else
    {
        outFile = "machine_code.coe";
    }

    // Open input for read & check validity
    FILE *inFd = fopen(inFile, "r");
    if (inFd == NULL)
    {
        addError(INV_INPUT);
        handleErrors();
        return 0;
    }

    // Initialize current for instruction LL to NULL

    INSTR_NODE* current = NULL;

    /******************************************************/
    // First pass of file: grabbing instructions and labels
    /******************************************************/
    do
    {
        
        //String that will retain full line throughout parsing
        fullLine = (char *)malloc(255*sizeof(char));
        strcpy(fullLine, "");
        
        //String that will be parsed and edited in the process
        char *parse_buf = (char*)malloc(255*sizeof(char));
        strcpy(parse_buf, "");
        
        // Grab line from file
        size_t charCount; //Junk variable
        getline(&fullLine, &charCount, inFd);
        strcpy(parse_buf, fullLine);
        
        //Current instruction to fill
        INSTR instr;
        
        //Parse line
        if( !parseOneLine(parse_buf, &instr, &current) )
        {
            //Zero return value indicates successful parsing
            instructionNumber++;
        }

        lineNumber++;
        // Free memory allocated for line
        free(parse_buf);
        free(fullLine);
        
    } while (!feof(inFd));

    fclose(inFd);

    //Open and check output file
    FILE *outFd = fopen(outFile, "w");
    if (outFd == NULL)
    {
        addError(INV_OUTPUT);
        handleErrors();

        return 0;
    }

    /******************************************************/
    // Second pass of file: linking instructions to labels
    /******************************************************/
    
    // Starting at head, parse each instruction in LL
    // Link labels if necessary
    int current_line = 1;
    current = instr_LL_head;
    while (current != NULL)
    {
        // Fetch instruction from current node in LL
        INSTR *instr =  &(current->instr);
        
        //printf("instr = %x, next = %x\n", *instr, current-> next);
        
        //If we have a branch/jump instruction, link label
        if ( instr->opcode == BEQ ||
             instr->opcode == BNE   )
        {
            ((IJ_INSTR*)instr)->immed = getLabelJump((current->label_reference), current_line);
        }
    
        // Write instruction to file
        writeInstr(*instr, outFd);
              
        // Advance to next node in LL
        current = current->next;
        current_line++;
        
        if (current_line == 257)
        {
            addError(PC_ERR);
        }
    }

    //Print newline to terminate output file
    fprintf(outFd, ";\n");

    // Close output file
    fclose(outFd);
    
    //If there were errors, delete the generated file
    //since it contains bad code
    if( !handleErrors() )
    {
        unlink(outFile);
    }
              
    return 0;
}