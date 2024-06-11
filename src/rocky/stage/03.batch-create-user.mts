#!/usr/bin/env tsx
/* eslint-disable no-await-in-loop */
import assert from 'node:assert'

import {
  createUser,
  createGroup,
  modifyUserGroup,
  userExists,
  setUserPassword,
  setUserSudo,
  updateSshAllowUser,
} from '@waiting/shared-core/shell'
import { $, cd } from 'zx'

import { OS_DIR } from '../config/env.js'
import { userList } from '../config/user.config.js'


cd(OS_DIR)
console.info({ OS_DIR })
await $`pwd`.then(({ stdout }) => { console.info(stdout) })


// console.info({ userList })
console.info('==================== 新增系统默认用户 ====================')

for (const user of userList) {
  assert(user.username, 'username is required')

  console.info(`--------- create user: ${user.username} --------- `)
  if (await userExists(user.username)) {
    console.info(`user ${user.username} exists, skip`)
    if (user.hasSudo) {
      console.info(`>> set sudo for user: ${user.username} --------- `)
      await setUserSudo(user.username, user.sudoWithoutPassword)
    }
    if (user.sshAllowUser) {
      await updateSshAllowUser(user.username)
    }
    continue
  }

  if (user.gid && user.gid > 0) {
    await createGroup(user)
  }

  await createUser(user)
  await setUserPassword(user.username)
  if (user.hasSudo) {
    console.info(`>> set sudo for user: ${user.username} --------- `)
    await setUserSudo(user.username, user.sudoWithoutPassword)
  }

  if (user.sshAllowUser) {
    await updateSshAllowUser(user.username)
  }

  await $`sh/ssh-sync-authorized_keys.sh ${user.username}`
  if (user.sshSelfWithoutPassword) {
    await $`sudo -u ${user.username} sh/ssh-no-password.sh ${user.username}`
  }

}

await updateSshAllowUser('root')

for (const user of userList) {
  if (! user.groups) { continue }
  console.info(`--------- update user groups: ${user.username} --------- `)
  await modifyUserGroup(user)
  const { stdout } = await $`id ${user.username}`
  console.info(stdout)
}

