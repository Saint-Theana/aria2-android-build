After libraries build was complete.

``` shell
Only one thing to pay attention:
If you want check ca while downloading https URL
You need to modify ./android-config
Add opinion --with-ca-bundle
for example:
--with-ca-bundle='/sdcard/ca-certificates.crt' \
and ca-certificates.crt must be placed /sdcard under your Android phpone or it wouldn't work
```


Just use ./android-config and ./android-make would be ok.

