def pad(msg):
    m = bytearray(msg.encode('ascii'))
    padding = 448 * 512 * (len(m) // 448) - len(m)
    m.extend(bytearray([1] + [0 for _ in range(m)]))

    return m
