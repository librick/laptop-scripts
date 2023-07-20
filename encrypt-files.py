#!/usr/bin/env python3
import sys
import subprocess
import os
import re

plaintext_dir = "age-plaintext"
ciphertext_dir = "age-ciphertext"
pubkey_fname = "pubkey.txt"

if not os.path.isdir(plaintext_dir):
    sys.stderr.write("directory does not exist: {}\n".format(plaintext_dir))
    raise ValueError

if not os.path.isdir(ciphertext_dir):
    sys.stderr.write("directory does not exist: {}\n".format(ciphertext_dir))
    raise ValueError

if not os.path.isfile(pubkey_fname):
    sys.stderr.write("file does not exist: {}\n".format(pubkey_fname))
    raise ValueError

with open(pubkey_fname, "r") as f:
    pubkey = f.read()

if not pubkey.startswith('age'):
    sys.stderr.write("malformed public key, bad prefix\n")
    raise ValueError

# age public keys are encoded as Bech32 with HRP age
pkregex = re.compile('^age[0-9a-z]+$')
if pkregex.match(pubkey) is None:
    sys.stderr.write(
        "malformed public key, doesn't match regex: {}\n".format(pkregex.pattern))
    raise ValueError

plaintext_path = os.path.join(os.getcwd(), plaintext_dir)
ciphertext_path = os.path.join(os.getcwd(), ciphertext_dir)
print("plaintext path: {}".format(plaintext_path))
print("ciphertext path: {}".format(ciphertext_path))
print("public key: {}".format(pubkey))

plaintext_files = os.listdir(plaintext_path)
ciphertext_files = os.listdir(ciphertext_path)
print("discovered {} plaintext file(s)".format(len(plaintext_files)))
print("discovered {} ciphertext files(s)".format(len(ciphertext_files)))

if len(ciphertext_files) > 0:
    print("removing existing ciphertext files…")
    for ct in ciphertext_files:
        ct_path=os.path.join(ciphertext_path, ct)
        os.remove(ct_path)
        print("- deleted file, {}".format(ct))
else:
    print("no existing ciphertext files found, skipping deletion")

if len(plaintext_files) > 0:
    print("encrypting existing plaintext files…")
    for pt in plaintext_files:
        pt_path=os.path.join(plaintext_path, pt)
        ct_path=os.path.join(ciphertext_path, pt + ".age")

        with open(pt_path, 'r') as age_stdin:
            with open(ct_path, 'w') as age_stdout:
                subprocess.run(['age', '-r', pubkey],
                    stdin=age_stdin,
                    stdout=age_stdout,
                    check=True)

        print("- encrypted file: {}".format(pt_path))
        print("-- produced ciphertext file: {}".format(ct_path))
else:
    print("no existing plaintext files found, skipping encryption")

print('finished encryption, displaying directory contents ({})'.format(ciphertext_path))
ls = subprocess.run(['ls','-la',ciphertext_path],
    capture_output=True, text=True, check=True)
print(ls.stdout)
