# OP-TEE Configuration Makefile
# Phase 3: OP-TEE platform configuration for STM32MP2

PLATFORM_FLAVOR ?= stm32mp2
PLATFORM = stm32mp2

# Compiler flags
CFLAGS += -O2
CFLAGS += -Wall -Werror

# OP-TEE core configuration
CFG_WITH_STACK_CANARY ?= y
CFG_WITH_USER_TA ?= y
