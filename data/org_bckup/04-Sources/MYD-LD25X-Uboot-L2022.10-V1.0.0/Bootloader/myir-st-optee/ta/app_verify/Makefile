# Makefile for app_verify Trusted Application
# Phase 7: TA Build configuration

TA_DEV_KIT_DIR ?= $(OPTEE_DIR)/out/arm-plat-stm32mp2

TA_SOURCES := app_verify_ta.c

TA_CFLAGS := -I$(TA_DEV_KIT_DIR)/include -Wall -Werror

include $(TA_DEV_KIT_DIR)/mk/ta_dev_kit.mk
