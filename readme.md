# 构建日志

连接上手机会自动识别cpu型号，build的时候就能生成对应平台的apk包，比FatAPK小很多
arm64
avr7
x86
...

不连接手机 默认生成FatAPK包含所有平台lib, 可能会导致运行冲突

先用 `flutter build apk --target-platform=android-arm`
不行的话 然后再用android studio打包（进到PROJECT-ROOT/android目录）

debug包和release包都可以用自带的签名文件，密码android, alias自动可选择

还不行 重启手机和电脑试试