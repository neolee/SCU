## SCU（Squirrel 配置工具）

开源中文输入法 Squirrel（鼠鬚管）终于有了一个图形化的配置工具。目前还只支持最基本的配置选项，但总体框架已经完整，以后会增加更多配置选项的支持。SCU 本身也在 GitHub 开源，有兴趣的朋友可以一起来改进和增强它，如果有任何使用上的问题也可以在 GitHub 上提交错误报告（见下面的相关链接）。

如果不希望自己编译而又希望试用 SCU，可以从这里下载

- [SCU 最新版本 0.3.378](http://update.soulhacker.me/scu/SCU.zip)  
  SHA1 checksum: `c721b111faeeaeb77bbd5e4aaea9d6cd996eef51`
  
已经安装过 SCU 的朋友建议使用应用内置的自动升级功能来进行升级。使用前确保至少激活过 Squirrel（鼠鬚管）输入法一次并务必备份好 Squirrel 配置目录 `~/Library/Rime`（如果不知道在哪里，可以从 Squirrel 鼠鬚管输入法菜单里选择 Settings/用户设定，然后备份打开窗口里所有文件），进行任何配置之后必须执行 Squirrel（鼠鬚管）输入法菜单中的 Deploy/部署 命令才能生效。

**已支持的选项：**

- 基本选项：缺省键盘布局、开关切换输入状态时的系统提示、；
- 候选条选项：垂直/水平方向、候选词数、字体、透明度、颜色方案、圆角大小等；
- 应用选项：在指定应用中自动强制 Squirrel 进入 ASCII 字符输入模式和/或软光标模式；
- 输入方案选项：开关特定输入方案。

**尚未支持的选项：**

- 输入方案选项：定制特定输入方案；
- 其他官方定制指南中描述的配置选项。

**系统要求：**

- Mac OS X 10.7 或以上版本
- Squirrel（鼠鬚管）输入法 0.9.13 或以上版本

**相关链接：**

- 下载开源中文输入法 Squirrel（鼠鬚管）：  
  https://code.google.com/p/rimeime/wiki/Downloads
- SCU 开源项目主页：  
  https://github.com/neolee/SCU
- SCU 错误报告：  
  https://github.com/neolee/SCU/issues

**相关软件和鸣谢：**

- 佛振 (lotem)，开源输入法引擎 Rime（中州韵）和 Mac OS X 中文输入法 Squirrel（鼠鬚管）的作者。  
  https://code.google.com/p/rimeime
- James Montgomerie (th-in-gs)，开源 YAML Cocoa 封装库 YACYAML 的作者。  
  https://github.com/th-in-gs/YACYAML
- Vadim Shpakovski (shpakovski)，开源 Cocoa Preference 窗口类库 MASPreferences 的作者。  
  https://github.com/shpakovski/MASPreferences

  另外，为了 SCU 开发的舒服一点，写了 `NSDictionary+KeyPath` 和 `NSObject+DeepMutableCopy` 两个 category 来实现 `NSDictionary` 和 `NSMutableDictionary` 的 keypath 读写支持（其实绝大部分时间花在这上面了），有需要的朋友可以从下面的项目中检取：

- neolee / SHKit  
  https://github.com/neolee/SHKit