##通过find命令寻找最近一段时间修改过的文件

- -ctime：指定时间内文件的权限被修改过，change  
- -atime：指定时间内文件被访问过（读取），access  
- -mtime：指定时间(以天为单位)内文件被修改过，modify  
- -mmin：指定时间(以分钟为单位)内文件被修改过，modify  

寻找三天以内被修改过的文件：  
```
find . -mtime -3 -name "*.mk"
```

寻找三天前被修改过的文件:  
```
find . -mtime +3 -name "*.mk"
```