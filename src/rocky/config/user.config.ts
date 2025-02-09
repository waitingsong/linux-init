import type { CreateUserOptions } from '@waiting/shared-core/shell'
import { UserShell } from '@waiting/shared-core/shell'

// #region login user -------------

const postgres: CreateUserOptions = {
  username: 'postgres',
  uid: 26,
  gid: 26,
  createHomeDir: true,
}

const admin: CreateUserOptions = {
  username: 'admin',
  uid: 2000,
  gid: 2000,
  createHomeDir: true,
  hasSudo: true,
  groups: ['docker', 'www', 'postgres'],
  sshAllowUser: true,
  sshSelfWithoutPassword: true,
}

const dba: CreateUserOptions = {
  username: 'dba',
  uid: 88,
  gid: 88,
  createHomeDir: true,
  groups: ['docker', 'www', 'postgres', 'admin'],
  hasSudo: true,
  sudoWithoutPassword: true,
  sshAllowUser: true,
  sshSelfWithoutPassword: true,
}


const git: CreateUserOptions = {
  username: 'git',
  createHomeDir: true,
  sshAllowUser: true,
  sshSelfWithoutPassword: true,
}

const ci: CreateUserOptions = {
  username: 'ci',
  createHomeDir: true,
  sshAllowUser: true,
  sshSelfWithoutPassword: true,
}

// #region /bin/false user -----------------

const www: CreateUserOptions = {
  username: 'www',
  shell: UserShell.nologin,
  createHomeDir: false,
}

const nginx: CreateUserOptions = {
  username: 'nginx',
  shell: UserShell.binFalse,
  createHomeDir: false,
  groups: ['www'],
}

const docker: CreateUserOptions = {
  username: 'docker',
  shell: UserShell.nologin,
  createHomeDir: false,
}

const pgbouncer: CreateUserOptions = {
  username: 'pgbouncer',
  shell: UserShell.nologin,
  createHomeDir: false,
}



// #region export

export const userList: CreateUserOptions[] = [
  postgres,
  admin,
  dba,
  git,
  ci,
  www,
  nginx,
  docker,
  pgbouncer,
]

