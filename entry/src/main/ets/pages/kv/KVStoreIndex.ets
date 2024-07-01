import distributedData from '@ohos.data.distributedData'
import distributedKVStore from '@ohos.data.distributedKVStore';
import abilityAccessCtrl, { Permissions } from '@ohos.abilityAccessCtrl';
import DiaryKVStore from '../../utils/DiaryKVStore';
import bundleManager from '@ohos.bundle.bundleManager';
import common from '@ohos.app.ability.common';

const KEY_TEST_STRING_ELEMENT = 'key_test_string';
const VALUE_TEST_STRING_ELEMENT = 'value_test_string';

@Entry
@Component
struct KVStoreIndex {
  @State message: string = 'Hello World'
  kvStore: distributedKVStore.SingleKVStore | undefined = undefined
  kvManager: distributedKVStore.KVManager | undefined = undefined
  @State value: string | undefined = undefined
  context: Context = getContext()

  build() {
    Column({ space: 10 }) {
      Button('创建KVManager')
        .btnKvStyle()
        .onClick(async () => {
          await DiaryKVStore.initKVManager()
        })

      Button('获取/创建KVStore')
        .btnKvStyle()
        .onClick(async () => {
          try {
            await DiaryKVStore.initKVStore()
          } catch (e) {
            console.error(`An unexpected error occurred. Code:${e.code},message:${e.message}`);
          }
        })

      Button('订阅分布式数据变化')
        .btnKvStyle()
        .onClick(() => {
          DiaryKVStore.onSubscribe()
        })

      Button('写入数据1')
        .btnKvStyle()
        .onClick(async () => {
          try {
            await DiaryKVStore.putKVStore(KEY_TEST_STRING_ELEMENT, VALUE_TEST_STRING_ELEMENT)
          } catch (e) {
            console.error(`An unexpected error occurred. Code:${e.code},message:${e.message}`);
          }
        })

      Button('读取数据1')
        .btnKvStyle()
        .onClick(async () => {
          try {
            await DiaryKVStore.getKVStore(KEY_TEST_STRING_ELEMENT)
          } catch (e) {
            console.error(`Failed to get data. Code:${e.code},message:${e.message}`);
          }
        })


      Button('删除数据')
        .btnKvStyle()
        .onClick(async (event: ClickEvent) => {
          try {
            await DiaryKVStore.delKVStore(KEY_TEST_STRING_ELEMENT)
          } catch (e) {
            console.error(`An unexpected error occurred. Code:${e.code},message:${e.message}`);
          }
        })
    }.padding({ left: 20, right: 20, top: 20 })
    .width('100%')
    .height('100%')
  }
}

@Extend(Button)
function btnKvStyle() {
  .width('100%')
  .height(60)
  .fontSize(30)
  .align(Alignment.Center)
  .backgroundColor('#02bd79')
  .fontColor('#FFFFFF')
}

