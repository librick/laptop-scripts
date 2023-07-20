#!/usr/bin/env python3
import sys
import subprocess
import os
plaintext_dir = "age-plaintext"
ciphertext_dir = "age-ciphertext"
privkey_fname = "key.txt"

if not os.path.isdir(plaintext_dir):
    sys.stderr.write("directory does not exist: {}\n".format(plaintext_dir))
    raise ValueError

if not os.path.isdir(ciphertext_dir):
    sys.stderr.write("directory does not exist: {}\n".format(ciphertext_dir))
    raise ValueError

if not os.path.isfile(privkey_fname):
    sys.stderr.write("file does not exist: {}\n".format(privkey_fname))
    raise ValueError

plaintext_path = os.path.join(os.getcwd(), plaintext_dir)
ciphertext_path = os.path.join(os.getcwd(), ciphertext_dir)
print("plaintext path: {}".format(plaintext_path))
print("ciphertext path: {}".format(ciphertext_path))
print("key file: {}".format(privkey_fname))

plaintext_files = os.listdir(plaintext_path)
ciphertext_files = os.listdir(ciphertext_path)
print("discovered {} plaintext file(s)".format(len(plaintext_files)))
print("discovered {} ciphertext files(s)".format(len(ciphertext_files)))

if len(ciphertext_files) > 0:
    print("decrypting existing ciphertext files…")
    for ct in ciphertext_files:
        ct_path=os.path.join(ciphertext_path, ct)
        pt = ct.removesuffix(".age")
        pt_path=os.path.join(plaintext_path, pt)

        with open(ct_path, 'r') as age_stdin:
            with open(pt_path, 'w') as age_stdout:
                subprocess.run(['age', '-d', '-i', privkey_fname],
                    stdin=age_stdin,
                    stdout=age_stdout,
                    check=True)

        print("- decrypted file: {}".format(ct_path))
        print("-- produced plaintext file: {}".format(pt_path))
else:
    print("no existing ciphertext files found, skipping decryption")

print('finished decryption, displaying directory contents ({})'.format(plaintext_path))
ls = subprocess.run(['ls','-la',plaintext_path],
    capture_output=True, text=True, check=True)
print(ls.stdout)
