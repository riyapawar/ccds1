import git
import os
import pandas as pd
import pandasql as ps
import array as arr

acct = ['ltkhang', 'nttdots', 'samvid25', 'AlphaDelta']
repos = ['dn-ids-ddos-defense', 'go-dots', 'ARP-Spoofing-Detection-and-Prevention', 'Secure-Desktop']
for i in range (0,4):
    if not os.path.exists(acct[i]):
        os.makedirs(acct[i])
    git.Git(f'{acct[i]}/').clone(f'https://github.com/{acct[i]}/{repos[i]}.git')
