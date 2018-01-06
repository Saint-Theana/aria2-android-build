The available newest aria2 version is 1.33.1 so far.
If you ran make before whaching this,trust me,you will fail.

Aria2 Project is not perfect in supporting aarch64 android.

You need to modify some source code file before make

See:
```shell
1:
replace function stat64 with stat.
151 #define a2stat(path, buf) stat64(path, buf)
                                 ^
It should be like:
151 #define a2stat(path, buf) stat(path, buf)
target:  aria2-1.33.1/src/a2io.h

```

```shell
2
removefunction gzbuffer 
65 #if HAVE_GZBUFFER
66       gzbuffer(fp_, 1 << 17);
67 #endif

delete code above
target:  aria2-1.33.1/src/GZipFile.cc

```
