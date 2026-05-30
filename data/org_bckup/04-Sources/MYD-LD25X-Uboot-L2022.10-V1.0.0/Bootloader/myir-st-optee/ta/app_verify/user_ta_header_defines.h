/*
 * Trusted Application Header Definitions
 * Phase 7: TA Source - User TA header definitions
 */

#ifndef __USER_TA_HEADER_DEFINES_H
#define __USER_TA_HEADER_DEFINES_H

#define TA_UUID { 0x12345678, 0x1234, 0x5678, \
    { 0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc, 0xde, 0xf0 } }

#define TA_FLAGS (TA_FLAG_EXEC_DDR | TA_FLAG_SINGLE_INSTANCE)

#define TA_STACK_SIZE (2 * 1024)  /* 2KB */
#define TA_DATA_SIZE (32 * 1024)  /* 32KB */

#endif /* __USER_TA_HEADER_DEFINES_H */
