#!/usr/env/bin python
#-*- coding:utf-8 -*-

#运算符重载

class person:
    def __init__(self, name):
        self.name = name

    def __add__(self, other):
        if isinstance(other, person):
            return "{},{}".format(self.name, other.name)
            pass
        else:
            return "不是同类对象不能相加"

p1 = person("李正")
p2 = person("王明")
p3 = p1 + p2

print(p1)
print(p2)
print(p3)
