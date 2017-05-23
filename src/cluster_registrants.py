#!/bin/python3

# Important: requires manually classified idns, called

import csv

clusters = dict()
with open('../data/manually-classified-idns-20170501.csv') as f:
    rows = csv.reader(f, strict=True)
    for row in rows:
        if row[6].startswith('Third Party'):
            k = row[4] + row[5]
            if k in clusters:
                clusters[k].append(row[:])
            else:
                clusters[k] = [row[:]]

f_clusters = []
count = 0
for c in clusters:
    if len(clusters[c]) > 1:
        f_clusters.append(c)
        count += len(clusters[c])

print('Number of Third Party domains whose Registrant Organization and Email')
print('\thas than one homograph IDN registered: ' + str(count))
print('Number of Registrant\'s Organization and Email that have')
print('\tmore than one homograph IDN: ' + str(len(f_clusters)))

print('')
s_clusters = sorted(f_clusters, key=lambda k: len(clusters[k]), reverse=True)
for k in s_clusters:
    print('Number of homograph IDNs: ' + str(len(clusters[k])))
    print('Registrant Organization: "' + clusters[k][0][4] + '"')
    print('Registrant Email: "' + clusters[k][0][5] + '"')
    print('Homograph IDNs')
    print('\t(Rank, Canonical Domain, Unicode Domain, Punycode Domain, Classification)')
    for d in clusters[k]:
        print('\t' + d[0] + ',' + d[1] + ',' + d[2] + ',' + d[3] + ',' + d[6])
    print('')
