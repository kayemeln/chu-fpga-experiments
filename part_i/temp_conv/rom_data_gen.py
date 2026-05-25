c_to_f = []

for c in range(101):
    c_to_f.append(round(9/5 * c + 32))

with open("c_to_f.txt", 'w') as file:
    for f in c_to_f:
        #file.write(str(f) + '\n')
        file.write(format(f, '08b') + '\n')

f_to_c = []

for f in range(32, 213):
    f_to_c.append(round((f - 32) * 5/9))

with open("f_to_c.txt", 'w') as file:
    for c in f_to_c:
        #file.write(str(c) + '\n')
        file.write(format(c, '08b') + '\n')
