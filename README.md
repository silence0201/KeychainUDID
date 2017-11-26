# KeychainUDID
===

获取设备唯一编码(UDID),不刷机的情况下会保持一致

### 自定义

自定义Key:

	#define UDID_KEY   @"com.silence.udid"

已经加了宏判断,可以在使用项目中任何地方对Key进行定义

### 基本方法

	///  获取UDID
	+ (NSString *)UDID ;

	/// 删除保存的UDID
	+ (void)deleteUDID;

## KeychainUDID
KeychainUDID is available under the MIT license. See the LICENSE file for more info.