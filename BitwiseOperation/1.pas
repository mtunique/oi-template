取出第i位 mark and(1<<(i-1))
取出最后一个1  i and (i xor (i-1))==x and -x
去掉末尾的0 i div (i and (i xor (i-1)))