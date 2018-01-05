The available newest aria2 version is 1.33.1 so far.
If you ran make before whaching this,trust me,you will fail.

Aria2 Project is not perfect in supporting aarch64 android.

So run folowing command before make

```shell
cd aria2-1.33.1
cat src/a2io.h|sed 's/ stat64/ stat/'>src/a2io.h

```
