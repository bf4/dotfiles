#!/usr/bin/python

import subprocess

def get_keychain_pass(account=None, server=None):
  command = 'get_keychain_pass ' + account + ' ' + server
  return subprocess.check_output(command, shell=True, stderr=subprocess.STDOUT)
