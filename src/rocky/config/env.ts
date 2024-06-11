#!/usr/bin/env tsx
import { join } from 'node:path'

import { genCurrentDirname } from '@waiting/shared-core'


const DIR = genCurrentDirname(import.meta.url)
export const OS_DIR = join(DIR, '..')
export const BASE = join(OS_DIR, '../..')
export const SRC = join(OS_DIR, '..')
export const ASSERT = join(OS_DIR, '../../asset')

// export const NVM_NODEJS_ORG_MIRROR="https://npmmirror.com/dist"
export const NVM_NODEJS_ORG_MIRROR = 'https://mirrors.aliyun.com/nodejs-release'
export const NPM_REG_MIRROR = 'https://registry.npmmirror.com'

// cd(OS_DIR)

